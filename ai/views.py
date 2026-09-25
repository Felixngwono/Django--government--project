import json
from types import SimpleNamespace

from django.contrib.auth.decorators import login_required
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone
from django.views.decorators.http import require_POST
from rest_framework import permissions, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from ai.chart_assistant import chat
from ai.issue_assessor import assess_issue
from ai.report_generator import generate_project_summary
from ai.project_analysis import _analysis_payloads, _progress_value, build_portfolio_anomaly_summary, generate_project_analyses
from ai.services import generate_ai_portfolio_insights
from member.ai_services import build_project_intelligence
from member.models import AIIssueAssessment, AIChatSession, AIReportGeneration, Project, ReportIssue, Tender


def visible_projects(user):
    projects = Project.objects.all()
    if getattr(user, "role", None) == "citizen":
        return projects.filter(is_public=True)
    return projects


@login_required
def ai_assistant(request):
    return redirect("ai_chatbot")


@login_required
def ai_intelligence(request):
    projects = list(visible_projects(request.user).select_related("category", "district"))
    focus = request.GET.get("focus", "overview")
    allowed_focus = {"overview", "anomalies", "risk", "finance", "project", "contractor", "procurement", "data", "alerts"}
    if focus not in allowed_focus:
        focus = "overview"

    # ── Build one analysis snapshot per project (reused across all tabs) ──
    findings = []
    for project in projects:
        for analysis_type, summary, data, confidence in _analysis_payloads(project):
            if analysis_type == "risk" and (data["anomaly_score"] >= 40 or data["early_warnings"]):
                findings.append({"project": project, "type": "Risk / Anomaly", "score": data["anomaly_score"], "summary": summary, "confidence": confidence, "data": data})

    findings.sort(key=lambda item: item["score"], reverse=True)

    # ── AI Overview: detection counts by category ──
    detection_counts = {
        "financial": sum(1 for item in findings if item["data"].get("anomaly_indicators")),
        "schedule": sum(1 for item in findings if item["data"].get("schedule_delay_months") or item["data"].get("schedule_health", 100) < 60),
        "progress": sum(1 for item in findings if item["data"].get("anomaly_score", 0) >= 50 and item["data"].get("financial_health", 100) < 60),
        "contractor": sum(1 for item in findings if (item["data"].get("contractor") or {}).get("delayed_projects", 0) >= 2),
        "procurement": sum(1 for item in findings if item["data"].get("procurement_indicators")),
        "data": sum(1 for item in findings if item["data"].get("data_integrity_flags") or item["data"].get("duplicate_candidates")),
    }

    # ── Risk Analysis: ranking + filters ──
    county = request.GET.get("county", "")
    agency = request.GET.get("agency", "")
    status_filter = request.GET.get("status", "")
    risk_level = request.GET.get("level", "")

    ranked = sorted(
        projects,
        key=lambda project: next((data["score"] for kind, _summary, data, _confidence in _analysis_payloads(project) if kind == "risk"), 0),
        reverse=True,
    )
    ranked_items = []
    for project in ranked:
        kind, summary_text, data, _confidence = next(item for item in _analysis_payloads(project) if item[0] == "risk")
        level = data["level"]
        if county and (project.district.name if project.district else "").lower() != county.lower():
            continue
        if agency and (project.implementing_agency or "").lower() != agency.lower():
            continue
        if status_filter and (project.project_status or "").lower() != status_filter.lower():
            continue
        if risk_level and level != risk_level.lower():
            continue
        ranked_items.append({"project": project, "data": data, "level": level, "summary": summary_text})

    counties = sorted({project.district.name for project in projects if project.district})
    agencies = sorted({project.implementing_agency for project in projects if project.implementing_agency})

    # ── Financial Intelligence ──
    finance_findings = [item for item in findings if item["data"].get("anomaly_indicators")][:10]
    finance_stats = {
        "analyzed": len(projects),
        "anomalies": detection_counts["financial"],
        "overruns": sum(1 for project in projects if project.project_Budgeting and project.amount_spent and project.amount_spent > project.project_Budgeting),
        "unusual_payments": sum(1 for item in findings if any("expenditure" in indicator.lower() or "expense" in indicator.lower() for indicator in item["data"].get("anomaly_indicators", []))),
        "budget_variations": sum(1 for item in findings if any("revision" in indicator.lower() for indicator in item["data"].get("anomaly_indicators", []))),
    }

    # ── Contractor Intelligence ──
    contractor_map = {}
    for project in projects:
        name = (project.project_contractor or "").strip()
        if not name:
            continue
        entry = contractor_map.setdefault(name, {"name": name, "projects": 0, "completed": 0, "delayed": 0, "abandoned": 0, "scores": []})
        entry["projects"] += 1
        status = (project.project_status or "").lower()
        if status == "completed":
            entry["completed"] += 1
        elif status in {"delayed", "stalled", "suspended"}:
            entry["delayed"] += 1
        elif status == "cancelled":
            entry["abandoned"] += 1
        for kind, _summary, data, _confidence in _analysis_payloads(project):
            if kind == "risk" and data.get("contractor", {}).get("rating") is not None:
                entry["scores"].append(data["contractor"]["rating"])
    contractor_items = []
    for entry in contractor_map.values():
        avg = round(sum(entry["scores"]) / len(entry["scores"]), 1) if entry["scores"] else None
        score = max(0, min(100, round(avg - entry["delayed"] * 8))) if avg is not None else None
        risk = "HIGH" if entry["delayed"] >= 3 or (score is not None and score < 45) else "MEDIUM" if entry["delayed"] or (score is not None and score < 65) else "LOW"
        contractor_items.append({**entry, "performance": score, "risk": risk})
    contractor_items.sort(key=lambda item: (item["risk"] != "HIGH", item["risk"] != "MEDIUM", item["performance"] or 0))

    # ── Procurement Intelligence (tender-level) ──
    tenders = Tender.objects.select_related("project", "awarded_to").prefetch_related("applications").order_by("-created_at")
    procurement_stats = {"analyzed": tenders.count(), "repeated_awards": 0, "price_anomalies": 0, "short_window": 0}
    tender_anomalies = []
    award_counts = {}
    for tender in tenders:
        if tender.awarded_to_id:
            award_counts[tender.awarded_to_id] = award_counts.get(tender.awarded_to_id, 0) + 1
        if tender.estimated_budget and tender.award_amount and tender.estimated_budget > 0:
            variance = round(float((tender.award_amount - tender.estimated_budget) / tender.estimated_budget * 100), 1)
            if abs(variance) >= 25:
                procurement_stats["price_anomalies"] += 1
                tender_anomalies.append({"tender": tender, "issue": f"Winning bid is {variance:+.1f}% versus estimated cost.", "variance": variance})
        if tender.opening_date and tender.closing_date and (tender.closing_date - tender.opening_date).days < 7:
            procurement_stats["short_window"] += 1
            tender_anomalies.append({"tender": tender, "issue": "Procurement window was shorter than seven days.", "variance": None})
    procurement_stats["repeated_awards"] = sum(1 for count in award_counts.values() if count >= 3)
    procurement_stats["anomalies"] = len(tender_anomalies)
    tender_anomalies = tender_anomalies[:10]

    # ── Data Quality ──
    data_flags = {"missing": 0, "duplicates": 0, "conflicting_dates": 0, "invalid_progress": 0, "status_inconsistent": 0}
    data_findings = []
    for project in projects:
        data = next((data for kind, _summary, data, _confidence in _analysis_payloads(project) if kind == "risk"), None)
        if data is None:
            continue
        flags = data.get("data_integrity_flags", [])
        if not project.project_Budgeting or not project.start_date:
            data_flags["missing"] += 1
        if data.get("duplicate_candidates"):
            data_flags["duplicates"] += 1
        if project.end_date and project.start_date and project.end_date < project.start_date:
            data_flags["conflicting_dates"] += 1
        progress = _progress_value(project)
        if progress is None or progress < 0 or progress > 100:
            data_flags["invalid_progress"] += 1
        if flags:
            data_flags["status_inconsistent"] += len(flags)
            data_findings.append({"project": project, "flags": flags, "duplicates": data.get("duplicate_candidates", [])})
    data_stats = {**data_flags, "analyzed": sum(len(project.project_title or "") > 0 for project in projects) and len(projects)}
    data_findings = data_findings[:10]

    # ── AI Alerts ──
    alert_counts = {"critical": 0, "high": 0, "medium": 0}
    for item in findings:
        if item["score"] >= 80:
            alert_counts["critical"] += 1
        elif item["score"] >= 60:
            alert_counts["high"] += 1
        else:
            alert_counts["medium"] += 1
    alerts = [item for item in findings if item["data"].get("early_warnings")][:12]

    context = {
        "focus": focus,
        "projects_count": len(projects),
        "summary": build_portfolio_anomaly_summary(projects),
        "findings": findings[:20],
        "detection_counts": detection_counts,
        "ranked_items": ranked_items[:20],
        "counties": counties,
        "agencies": agencies,
        "status_choices": Project.STATUS_CHOICES,
        "filters": {"county": county, "agency": agency, "status": status_filter, "level": risk_level},
        "finance_stats": finance_stats,
        "finance_findings": finance_findings,
        "contractor_items": contractor_items[:15],
        "procurement_stats": procurement_stats,
        "tender_anomalies": tender_anomalies,
        "data_stats": data_stats,
        "data_findings": data_findings,
        "alert_counts": alert_counts,
        "alerts": alerts,
    }
    return render(request, "ai_intelligence.html", context)


@login_required
def ai_investigation(request, project_id):
    project = get_object_or_404(visible_projects(request.user), id=project_id)
    analyses = []
    for analysis_type, summary, data, confidence in _analysis_payloads(project):
        analyses.append(SimpleNamespace(analysis_type=analysis_type, summary=summary, data=data, confidence=confidence))
    risk = next(item for item in analyses if item.analysis_type == "risk")
    return render(request, "ai_investigation.html", {"project": project, "analyses": analyses, "risk": risk})


@login_required
def ai_chatbot(request):
    if request.method == "POST":
        session_id = request.POST.get("session_id")
        user_input = (request.POST.get("message") or "").strip()
        project_id = request.POST.get("project_id")
        persona = request.POST.get("persona", "general")

        if not user_input:
            return redirect(request.path)

        if session_id:
            session = AIChatSession.objects.filter(id=session_id, user=request.user).first()
            if session is None:
                session = AIChatSession.objects.create(user=request.user)
        else:
            session = AIChatSession.objects.create(user=request.user)

        project = visible_projects(request.user).filter(id=project_id).first() if project_id else None
        chat(session, user_input, project, persona)
        return redirect(f"{request.path}?session_id={session.id}")

    sessions = AIChatSession.objects.filter(user=request.user).order_by("-updated_at")
    session_id = request.GET.get("session_id")
    selected_session = sessions.filter(id=session_id).first() if session_id else None
    chat_messages = selected_session.messages.all() if selected_session else []

    return render(
        request,
        "ai_chatbot.html",
        {
            "chat_sessions": sessions,
            "chat_messages": chat_messages,
            "session": selected_session or SimpleNamespace(id=None),
            "projects": visible_projects(request.user).order_by("project_title"),
        },
    )


@login_required
@require_POST
def ai_chatbot_api(request):
    try:
        payload = json.loads(request.body.decode("utf-8")) if request.body else {}
    except json.JSONDecodeError:
        payload = {}

    message = (payload.get("message") or "").strip()
    if not message:
        return JsonResponse({"error": "Message is required."}, status=status.HTTP_400_BAD_REQUEST)

    session_id = payload.get("session_id")
    project_id = payload.get("project_id")
    persona = payload.get("persona", "general")

    if session_id:
        session = AIChatSession.objects.filter(id=session_id, user=request.user).first()
        if session is None:
            return JsonResponse({"error": "Session not found."}, status=status.HTTP_404_NOT_FOUND)
    else:
        session = AIChatSession.objects.create(user=request.user)

    project = visible_projects(request.user).filter(id=project_id).first() if project_id else None
    reply = chat(session, message, project, persona)
    return JsonResponse({"session_id": session.id, "reply": reply})


@login_required
def ai_insights(request):
    projects = visible_projects(request.user).select_related("category", "district")
    insights = generate_ai_portfolio_insights(projects)
    anomaly_summary = build_portfolio_anomaly_summary(projects)
    return render(request, "ai_insights.html", {"insights": insights, "anomaly_summary": anomaly_summary})


@login_required
def ai_report_page(request):
    reports = []
    for report in AIReportGeneration.objects.select_related("project").order_by("-created_at")[:5]:
        issue = report.project.issues.order_by("-created_at").first() if report.project_id else None
        assessment = None
        if issue:
            latest_assessment = issue.ai_assessments.order_by("-created_at").first()
            if latest_assessment:
                assessment = SimpleNamespace(
                    urgency=latest_assessment.urgency,
                    review_status=latest_assessment.review_status,
                )

        analyses = list(report.project.ai_analyses.filter(is_latest=True)) if report.project_id else []
        reports.append(
            SimpleNamespace(
                title=f"{report.project.project_title if report.project else 'Project'} — {report.report_type.replace('_', ' ').title()}",
                text=report.output or "No report content generated yet.",
            model=report.model or "GovTracker rules",
            created_at=report.created_at,
            analyses=analyses,
                assessment=assessment,
            )
        )

    return render(request, "ai_report_page.html", {"reports": reports, "projects": visible_projects(request.user).order_by("project_title")})


@login_required
@require_POST
def ai_generate_report(request, project_id):
    project = get_object_or_404(visible_projects(request.user), id=project_id)
    generate_project_summary(project, request.user)
    return redirect("ai_report_page")


@login_required
@require_POST
def ai_generate_analysis(request, project_id):
    project = get_object_or_404(visible_projects(request.user), id=project_id)
    generate_project_analyses(project, request.user)
    return redirect("ai_report_page")


@login_required
def ai_issue_dashboard(request):
    issues = []
    for issue in ReportIssue.objects.select_related("project", "user").order_by("-created_at"):
        latest_assessment = issue.ai_assessments.order_by("-created_at").first()
        if latest_assessment:
            score = int(latest_assessment.confidence or 0)
            level = "high" if latest_assessment.urgency in {"high", "critical"} else "medium" if latest_assessment.urgency == "moderate" else "low"
        else:
            score = 90 if issue.severity == "critical" else 70 if issue.severity == "high" else 50
            level = "high" if issue.severity in {"high", "critical"} else "medium"
        issues.append(
            {
                "issue": issue,
                "assessment": latest_assessment,
                "category": latest_assessment.category if latest_assessment else "Not assessed",
                "risk": {
                    "level": level,
                    "score": score,
                },
            }
        )
    return render(request, "ai_issue_dashboard.html", {"issues": issues})


@login_required
@require_POST
def ai_triage_issue(request, issue_id):
    issue = get_object_or_404(ReportIssue, id=issue_id)
    assess_issue(issue)
    return redirect("ai_issue_dashboard")


@login_required
@require_POST
def ai_review_assessment(request, assessment_id):
    assessment = get_object_or_404(AIIssueAssessment, id=assessment_id)
    decision = request.POST.get("decision")
    if decision in {"approved", "rejected"} and (request.user.is_superuser or request.user.is_staff or getattr(request.user, "role", None) in {"official", "manager", "auditor"}):
        assessment.review_status = decision
        assessment.reviewed_by = request.user
        assessment.reviewed_at = timezone.now()
        assessment.save(update_fields=["review_status", "reviewed_by", "reviewed_at"])
    return redirect("ai_issue_dashboard")


class ProjectViewSet(viewsets.ModelViewSet):
    queryset = Project.objects.select_related("category", "district").prefetch_related(
        "stages", "milestones", "media", "risks"
    )
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        qs = super().get_queryset()
        if getattr(self.request.user, "role", None) == "citizen":
            qs = qs.filter(is_public=True)
        return qs

    @action(detail=True, methods=["post"], url_path="generate-summary")
    def generate_summary(self, request, pk=None):
        project = self.get_object()
        report = generate_project_summary(project, request.user)
        return Response({"summary": report.output})

    @action(detail=False, methods=["get"], url_path="search")
    def ai_search(self, request):
        query = (request.query_params.get("q") or "").strip()
        if not query:
            return Response([], status=status.HTTP_200_OK)

        results = Project.objects.filter(
            Q(project_title__icontains=query)
            | Q(project_description__icontains=query)
            | Q(project_location__icontains=query)
        )[:10]

        data = [
            {
                "id": project.id,
                "project_title": project.project_title,
                "project_description": project.project_description,
                "project_location": project.project_location,
                "project_status": project.project_status,
                "priority": project.priority,
            }
            for project in results
        ]
        return Response(data)


class ReportIssueViewSet(viewsets.ModelViewSet):
    queryset = ReportIssue.objects.select_related("project", "user")
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=["post"], url_path="ai-assess")
    def ai_assess(self, request, pk=None):
        issue = self.get_object()
        assessment = assess_issue(issue)
        return Response(
            {
                "category": assessment.category,
                "urgency": assessment.urgency,
                "confidence": assessment.confidence,
                "summary": assessment.summary,
                "recommended_action": assessment.recommended_action,
            }
        )


class AIChatView(viewsets.ViewSet):
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=False, methods=["post"])
    def message(self, request):
        session_id = request.data.get("session_id")
        user_input = request.data.get("message", "").strip()
        project_id = request.data.get("project_id")

        if not user_input:
            return Response({"error": "Message is required."}, status=status.HTTP_400_BAD_REQUEST)

        if session_id:
            session = AIChatSession.objects.filter(id=session_id, user=request.user).first()
            if session is None:
                return Response({"error": "Session not found."}, status=status.HTTP_404_NOT_FOUND)
        else:
            session = AIChatSession.objects.create(user=request.user)

        project = Project.objects.filter(id=project_id).first() if project_id else None
        reply = chat(session, user_input, project)

        return Response({"session_id": session.id, "reply": reply})
