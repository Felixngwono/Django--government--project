import json
from types import SimpleNamespace

from django.contrib.auth.decorators import login_required
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.http import require_POST
from rest_framework import permissions, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from ai.chart_assistant import chat
from ai.issue_assessor import assess_issue
from ai.report_generator import generate_project_summary
from ai.services import generate_ai_portfolio_insights
from member.ai_services import build_project_intelligence
from member.models import AIIssueAssessment, AIChatSession, AIReportGeneration, Project, ReportIssue


@login_required
def ai_assistant(request):
    return redirect("ai_chatbot")


@login_required
def ai_chatbot(request):
    if request.method == "POST":
        session_id = request.POST.get("session_id")
        user_input = (request.POST.get("message") or "").strip()
        project_id = request.POST.get("project_id")

        if not user_input:
            return redirect(request.path)

        if session_id:
            session = AIChatSession.objects.filter(id=session_id, user=request.user).first()
            if session is None:
                session = AIChatSession.objects.create(user=request.user)
        else:
            session = AIChatSession.objects.create(user=request.user)

        project = Project.objects.filter(id=project_id).first() if project_id else None
        chat(session, user_input, project)
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
            "projects": Project.objects.order_by("project_title"),
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

    if session_id:
        session = AIChatSession.objects.filter(id=session_id, user=request.user).first()
        if session is None:
            return JsonResponse({"error": "Session not found."}, status=status.HTTP_404_NOT_FOUND)
    else:
        session = AIChatSession.objects.create(user=request.user)

    project = Project.objects.filter(id=project_id).first() if project_id else None
    reply = chat(session, message, project)
    return JsonResponse({"session_id": session.id, "reply": reply})


@login_required
def ai_insights(request):
    projects = Project.objects.select_related("category", "district")
    insights = generate_ai_portfolio_insights(projects)
    return render(request, "ai_insights.html", {"insights": insights})


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

        reports.append(
            SimpleNamespace(
                title=f"{report.project.project_title if report.project else 'Project'} — {report.report_type.replace('_', ' ').title()}",
                text=report.output or "No report content generated yet.",
                assessment=assessment,
            )
        )

    return render(request, "ai_report_page.html", {"reports": reports, "projects": Project.objects.order_by("project_title")})


@login_required
@require_POST
def ai_generate_report(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    generate_project_summary(project, request.user)
    return redirect("ai_report_page")


@login_required
def ai_issue_dashboard(request):
    issues = []
    for issue in ReportIssue.objects.select_related("project", "user").order_by("-created_at"):
        latest_assessment = issue.ai_assessments.order_by("-created_at").first()
        issues.append(
            {
                "issue": issue,
                "assessment": latest_assessment,
                "category": latest_assessment.category if latest_assessment else "Not assessed",
                "risk": {
                    "level": "high" if issue.severity in {"high", "critical"} else "medium",
                    "score": 90 if issue.severity == "critical" else 70 if issue.severity == "high" else 50,
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
    if decision in {"approved", "rejected"}:
        assessment.review_status = decision
        assessment.save(update_fields=["review_status"])
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
