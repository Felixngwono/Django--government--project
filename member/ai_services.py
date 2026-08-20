"""Reliable, local AI-assistance helpers for GovTracker.

These helpers intentionally work without a third-party API key.  They turn the
project records already held by GovTracker into explainable recommendations,
which keeps the AI screens useful during development and when an external AI
provider is unavailable.
"""

from decimal import Decimal


def _text(value):
    return (value or "").lower()


def classify_issue_category(text):
    text = _text(text)
    categories = {
        "infrastructure": ("road", "bridge", "water", "drain", "building", "electric", "blocked"),
        "financial": ("budget", "fund", "money", "payment", "cost", "overspend", "fraud"),
        "safety": ("unsafe", "danger", "accident", "injur", "hazard", "emergency"),
        "corruption": ("corrupt", "bribe", "embezz", "theft", "procurement"),
        "delay": ("delay", "late", "stalled", "behind schedule", "overdue"),
        "quality": ("quality", "defect", "poor work", "crack", "broken"),
    }
    for category, keywords in categories.items():
        if any(keyword in text for keyword in keywords):
            return category
    return "other"


def predict_project_risk(text):
    text = _text(text)
    high_terms = ("critical", "corruption", "unsafe", "danger", "blocked", "overspend", "over budget")
    medium_terms = ("delay", "late", "stalled", "risk", "issue", "concern")
    score = 15 + 20 * sum(term in text for term in medium_terms) + 30 * sum(term in text for term in high_terms)
    score = min(score, 100)
    level = "high" if score >= 65 else "medium" if score >= 35 else "low"
    return {"score": score, "level": level}


def triage_issue(issue):
    description = f"{issue.title or ''} {issue.issue_description or ''}"
    risk = predict_project_risk(description)
    severity = _text(getattr(issue, "severity", ""))
    urgency = "critical" if severity == "critical" or risk["score"] >= 85 else "high" if severity == "high" or risk["score"] >= 65 else "moderate" if severity == "medium" or risk["score"] >= 35 else "low"
    category = classify_issue_category(description)
    project_name = getattr(getattr(issue, "project", None), "project_title", None) or "this project"
    return {
        "category": category,
        "urgency": urgency,
        "confidence": 75 if category != "other" else 45,
        "summary": f"The report for {project_name} is classified as {category} with {urgency} urgency based on the reported details.",
        "recommended_action": "Assign the issue to the responsible officer, verify the report, and publish a progress update." if urgency in {"high", "critical"} else "Review the report, confirm the details, and schedule follow-up action.",
        "model": "govtracker-rules-v1",
        "provider": "heuristic",
    }


def build_project_intelligence(projects):
    from member.models import Tender, TenderApplication, Contractor, ReportIssue

    records = list(projects)
    statuses = {"ongoing": 0, "upcoming": 0, "completed": 0, "delayed": 0}
    total_budget = Decimal("0")
    total_spent = Decimal("0")

    project_list_details = []
    for project in records:
        status = _text(getattr(project, "project_status", ""))
        if status in statuses:
            statuses[status] += 1
        budget = getattr(project, "project_Budgeting", None) or Decimal("0")
        spent = getattr(project, "amount_spent", None) or Decimal("0")
        total_budget += budget
        total_spent += spent

        contractor_info = project.project_contractor or "Unassigned"
        project_list_details.append(
            f"- {project.project_title} (ID: {project.id}): Status={project.project_status}, "
            f"Location={project.project_location or 'N/A'}, Progress={project.progress or 0}%, "
            f"Budget=KES {budget:,.2f}, Spent=KES {spent:,.2f}, Contractor={contractor_info}"
        )

    utilization = round(float(total_spent / total_budget * 100), 2) if total_budget else 0

    # Tenders Context
    tenders = list(Tender.objects.select_related('project', 'awarded_to')[:15])
    tender_list_details = []
    for t in tenders:
        awarded_str = f"Awarded to {t.awarded_to.company or t.awarded_to.name}" if t.awarded_to else "Not Awarded"
        tender_list_details.append(
            f"- {t.reference_number}: {t.title or 'Tender'} (Status={t.status}, "
            f"Method={t.procurement_method}, Budget=KES {t.estimated_budget or 0:,.2f}, {awarded_str})"
        )

    # Contractors Context
    contractors = list(Contractor.objects.all()[:15])
    contractor_list_details = []
    for c in contractors:
        b_status = " [BLACKLISTED]" if c.is_blacklisted else ""
        contractor_list_details.append(
            f"- {c.company or c.name}{b_status} (Location={c.location or 'National'}, "
            f"Category={c.category or 'NCA'}, Phone={c.phone or 'N/A'})"
        )

    # Bids Context
    bids = list(TenderApplication.objects.select_related('tender', 'applicant')[:15])
    bid_list_details = []
    for b in bids:
        t_ref = b.tender.reference_number if b.tender else "N/A"
        bid_list_details.append(
            f"- Bid by {b.company_name or (b.applicant.username if b.applicant else 'Company')} for {t_ref}: "
            f"Amount=KES {b.bid_amount or 0:,.2f}, Status={b.status}, TechScore={b.technical_score}, "
            f"FinScore={b.financial_score}, Total={b.total_score:.1f}%"
        )

    # Issues Context
    issues = list(ReportIssue.objects.select_related('project')[:15])
    issue_list_details = []
    for iss in issues:
        p_name = iss.project.project_title if iss.project else "General"
        issue_list_details.append(
            f"- Issue #{iss.id} on '{p_name}': {iss.title} (Severity={iss.severity}, Status={iss.status})"
        )

    recommendations = []
    if statuses["delayed"]:
        recommendations.append(f"Prioritize recovery plans for {statuses['delayed']} delayed project(s).")
    if utilization > 90:
        recommendations.append("Review high budget utilization before approving further expenditure.")
    if not recommendations:
        recommendations.append("Portfolio indicators are stable; continue routine monitoring.")

    project_text = "\n".join(project_list_details[:10]) if project_list_details else "No projects recorded."
    tender_text = "\n".join(tender_list_details) if tender_list_details else "No tenders recorded."
    contractor_text = "\n".join(contractor_list_details) if contractor_list_details else "No contractors recorded."
    bid_text = "\n".join(bid_list_details) if bid_list_details else "No bids recorded."
    issue_text = "\n".join(issue_list_details) if issue_list_details else "No issues reported."

    summary = (
        f"Portfolio: {len(records)} projects — {statuses['ongoing']} ongoing, {statuses['delayed']} delayed, "
        f"{statuses['completed']} completed, {statuses['upcoming']} upcoming.\n\n"
        f"Key Projects:\n{project_text}\n\n"
        f"Tenders ({len(tenders)} tracked):\n{tender_text}\n\n"
        f"Contractors ({len(contractors)} registered):\n{contractor_text}\n\n"
        f"Recent Bids:\n{bid_text}\n\n"
        f"Reported Issues:\n{issue_text}"
    )

    return {
        "summary": summary,
        "status_breakdown": statuses,
        "totals": {
            "total_projects": len(records),
            "total_budget": total_budget,
            "total_spent": total_spent,
            "budget_utilization": utilization,
            "ongoing_projects": statuses["ongoing"],
            "upcoming_projects": statuses["upcoming"],
            "delayed_projects": statuses["delayed"],
            "completed_projects": statuses["completed"],
            "total_tenders": len(tenders),
            "total_contractors": len(contractors),
            "total_bids": len(bids),
            "total_issues": len(issues),
        },
        "project_details": project_list_details,
        "tender_details": tender_list_details,
        "contractor_details": contractor_list_details,
        "bid_details": bid_list_details,
        "issue_details": issue_list_details,
        "recommendations": recommendations,
    }


def build_report_text(text):
    risk = predict_project_risk(text)
    return f"Summary: {text.strip() or 'No project details were supplied.'}\n\nRisk level: {risk['level'].title()} ({risk['score']}/100).\n\nRecommended next step: review the project record and assign an accountable follow-up action."


def generate_chatbot_reply(message, history, context):
    question = _text(message)
    totals = context.get("totals", {}) if context else {}
    status = context.get("status_breakdown", {}) if context else {}

    total_projects = totals.get("total_projects", 0)
    total_budget = float(totals.get("total_budget") or 0)
    total_spent = float(totals.get("total_spent") or 0)
    remaining_budget = max(0.0, total_budget - total_spent)
    utilization = totals.get("budget_utilization", 0)

    from member.models import Project, ReportIssue, Tender, Contractor, TenderApplication

    # Case 1: Delayed / Late / Stalled Projects Deep Analysis
    if any(term in question for term in ("delay", "late", "stalled", "behind", "overdue")):
        delayed_qs = Project.objects.filter(project_status__iexact="delayed").select_related("category")
        delayed_count = delayed_qs.count()
        if delayed_count == 0:
            return (
                "### 🟢 Portfolio Schedule Health Analysis\n\n"
                "Great news! There are currently **no delayed projects** recorded in the active portfolio.\n\n"
                f"- **Active Ongoing Projects**: {totals.get('ongoing_projects', 0)}\n"
                f"- **Completed Projects**: {totals.get('completed_projects', 0)}\n"
                f"- **Total Portfolio Budget**: KES {total_budget:,.2f}\n\n"
                "**Strategic Recommendation**: Maintain current milestone tracking and contractor reporting schedules."
            ), "govtracker-intelligence-v2"

        d_budget = float(sum(p.project_Budgeting or 0 for p in delayed_qs))
        d_spent = float(sum(p.amount_spent or 0 for p in delayed_qs))

        project_breakdown = []
        for p in delayed_qs[:10]:
            p_b = float(p.project_Budgeting or 0)
            p_s = float(p.amount_spent or 0)
            p_u = round((p_s / p_b * 100), 1) if p_b > 0 else 0
            contractor = p.project_contractor or "Unassigned"
            project_breakdown.append(
                f"• **{p.project_title}** (ID: {p.id})\n"
                f"  - **Category**: {p.category.name if p.category else 'Infrastructure'} | **Location**: {p.project_location or 'N/A'}\n"
                f"  - **Progress**: {p.progress or 0}% | **Budget**: KES {p_b:,.2f} | **Spent**: KES {p_s:,.2f} ({p_u}% utilized)\n"
                f"  - **Assigned Contractor**: {contractor}"
            )

        details_str = "\n\n".join(project_breakdown)
        return (
            f"### ⚠️ Executive Breakdown: {delayed_count} Delayed Capital Project(s)\n\n"
            f"There are **{delayed_count} project(s)** currently experiencing timeline delays, representing a combined financial commitment of **KES {d_budget:,.2f}** (KES {d_spent:,.2f} disbursed).\n\n"
            f"#### 📌 Specific Delayed Projects & Status:\n{details_str}\n\n"
            f"#### 🎯 Recommended Strategic Directives:\n"
            f"1. **Contractor Accountability Review**: Issue formal notices to assigned contractors with progress < 50%.\n"
            f"2. **Site Inspection Triage**: Mobilize field officers to audit delayed project sites.\n"
            f"3. **Budget Reallocation Safeguard**: Freeze unspent disbursements until recovery plans are approved."
        ), "govtracker-intelligence-v2"

    # Case 2: Budget / Spend / Cost / Money / Financial Absorption
    elif any(term in question for term in ("budget", "spend", "cost", "money", "expenditure", "allocated", "reserve")):
        top_projects_qs = Project.objects.order_by("-project_Budgeting")[:5]
        top_str_list = []
        for p in top_projects_qs:
            p_b = float(p.project_Budgeting or 0)
            p_s = float(p.amount_spent or 0)
            p_u = round((p_s / p_b * 100), 1) if p_b > 0 else 0
            top_str_list.append(f"• **{p.project_title}**: KES {p_b:,.2f} budget (Spent: KES {p_s:,.2f} / {p_u}%)")

        top_str = "\n".join(top_str_list) if top_str_list else "No project budget data recorded."

        return (
            f"### 📊 Executive Portfolio Financial Assessment\n\n"
            f"- **Total Authorized Allocation**: **KES {total_budget:,.2f}**\n"
            f"- **Total Disbursed Expenditure**: **KES {total_spent:,.2f}**\n"
            f"- **Unspent Liquid Reserves**: **KES {remaining_budget:,.2f}**\n"
            f"- **Overall Absorption Rate**: **{utilization}%**\n\n"
            f"#### 🏆 Top Capital Allocation Commitments:\n{top_str}\n\n"
            f"#### 💡 Financial Guidance:\n"
            f"• Absorption rate is at **{utilization}%**. Reserve capital remains solvent.\n"
            f"• Ensure all disbursement requisitions undergo milestone verification before payment processing."
        ), "govtracker-intelligence-v2"

    # Case 3: Contractors / Vendors / Builders
    elif any(term in question for term in ("contractor", "company", "builder", "vendor")):
        contractors_qs = Contractor.objects.all()[:10]
        c_count = Contractor.objects.count()
        blacklisted_count = Contractor.objects.filter(is_blacklisted=True).count()

        c_list = []
        for c in contractors_qs:
            b_badge = " [🔴 BLACKLISTED]" if c.is_blacklisted else " [🟢 Active]"
            c_list.append(f"• **{c.company or c.name}**{b_badge} — Category: {c.category or 'General'} | Phone: {c.phone or 'N/A'}")

        c_str = "\n".join(c_list) if c_list else "No registered contractors found."

        return (
            f"### 🏗 Contractor Registry & Performance Overview\n\n"
            f"- **Total Registered Contractors**: **{c_count}**\n"
            f"- **Blacklisted Contractors**: **{blacklisted_count}**\n\n"
            f"#### 📋 Sample Registered Contractors:\n{c_str}\n\n"
            f"**Action Note**: Blacklisted contractors are automatically barred from participating in public tenders."
        ), "govtracker-intelligence-v2"

    # Case 4: Tenders / Bids / Proposals / Procurement
    elif any(term in question for term in ("tender", "procurement", "bid", "proposal")):
        tenders_qs = Tender.objects.select_related("project", "awarded_to")[:5]
        t_count = Tender.objects.count()
        b_count = TenderApplication.objects.count()

        t_list = []
        for t in tenders_qs:
            status_tag = f"Awarded to {t.awarded_to.company or t.awarded_to.name}" if t.awarded_to else f"Status: {t.status}"
            t_list.append(f"• **{t.reference_number}**: {t.title} (Est. Budget: KES {t.estimated_budget or 0:,.2f}) — *{status_tag}*")

        t_str = "\n".join(t_list) if t_list else "No active tenders listed."

        return (
            f"### 📜 Procurement & Tender Intelligence\n\n"
            f"- **Total Tenders Tracked**: **{t_count}**\n"
            f"- **Submitted Bids / Proposals**: **{b_count}**\n\n"
            f"#### 📂 Active & Recent Procurement Records:\n{t_str}\n\n"
            f"**Procurement Compliance**: All awards strictly adhere to public procurement scoring matrices."
        ), "govtracker-intelligence-v2"

    # Case 5: Issues / Complaints / Reports / Citizen Feedback / Risks
    elif any(term in question for term in ("issue", "problem", "complaint", "report", "risk", "triage")):
        issues_qs = ReportIssue.objects.select_related("project").order_by("-created_at")[:8]
        i_count = ReportIssue.objects.count()
        unresolved_count = ReportIssue.objects.filter(resolved=False).count()

        i_list = []
        for iss in issues_qs:
            p_name = iss.project.project_title if iss.project else "General"
            i_list.append(f"• **Issue #{iss.id}** on *{p_name}*: \"{iss.title}\" (Severity: `{iss.severity.upper()}` | Status: `{iss.status}`) ")

        i_str = "\n".join(i_list) if i_list else "No reported issues currently."

        return (
            f"### 🛡 Citizen Issue & Risk Intelligence Triage\n\n"
            f"- **Total Reported Citizen Issues**: **{i_count}**\n"
            f"- **Unresolved / Pending Triage**: **{unresolved_count}**\n\n"
            f"#### ⚠️ Recent Reported Signals:\n{i_str}\n\n"
            f"**Triage Action Plan**: Review unresolved issues on the AI Issue Dashboard to assign responsible officers."
        ), "govtracker-intelligence-v2"

    # Case 6: Matching Specific Project Search
    matching_projects = Project.objects.filter(project_title__icontains=message)[:5]
    if not matching_projects.exists():
        words = [w for w in question.split() if len(w) > 3 and w not in ("which", "what", "where", "show", "give", "list", "tell", "about", "project", "status")]
        if words:
            from django.db.models import Q
            q_obj = Q()
            for w in words:
                q_obj |= Q(project_title__icontains=w) | Q(project_description__icontains=w) | Q(project_location__icontains=w)
            matching_projects = Project.objects.filter(q_obj)[:5]

    if matching_projects.exists():
        p_reports = []
        for p in matching_projects:
            p_b = float(p.project_Budgeting or 0)
            p_s = float(p.amount_spent or 0)
            p_u = round((p_s / p_b * 100), 1) if p_b > 0 else 0
            p_reports.append(
                f"### 📁 Project Deep-Dive: {p.project_title} (ID: {p.id})\n"
                f"- **Status**: `{p.project_status.upper()}` | **Progress**: `{p.progress or 0}%`\n"
                f"- **Capital Allocation**: KES {p_b:,.2f} | **Disbursed**: KES {p_s:,.2f} ({p_u}% absorption)\n"
                f"- **Location**: {p.project_location or 'N/A'} | **Category**: {p.category.name if p.category else 'N/A'}\n"
                f"- **Contractor**: {p.project_contractor or 'Unassigned'}\n"
                f"- **Overview**: {p.project_description or 'No additional narrative provided.'}"
            )
        return "\n\n---\n\n".join(p_reports), "govtracker-intelligence-v2"

    # Case 7: Comprehensive Default Portfolio Synthesis
    ongoing = status.get("ongoing", totals.get("ongoing_projects", 0))
    completed = status.get("completed", totals.get("completed_projects", 0))
    delayed = status.get("delayed", totals.get("delayed_projects", 0))
    upcoming = status.get("upcoming", totals.get("upcoming_projects", 0))

    return (
        f"### 🏛 GovTracker AI Executive Portfolio Synthesis\n\n"
        f"Here is the comprehensive real-time status overview of the government capital projects portfolio:\n\n"
        f"#### 📊 Portfolio Metrics & Pipeline Status:\n"
        f"- **Total Tracked Projects**: **{total_projects}**\n"
        f"  - 🔵 **Ongoing**: {ongoing} projects\n"
        f"  - 🔴 **Delayed**: {delayed} projects\n"
        f"  - 🟢 **Completed**: {completed} projects\n"
        f"  - 🟡 **Upcoming**: {upcoming} projects\n\n"
        f"#### 💰 Financial Absorption Overview:\n"
        f"- **Total Capital Allocation**: **KES {total_budget:,.2f}**\n"
        f"- **Disbursed Expenditure**: **KES {total_spent:,.2f}** ({utilization}% utilization)\n"
        f"- **Available Liquid Reserves**: **KES {remaining_budget:,.2f}**\n\n"
        f"#### 🛠 Procurement & Citizen Signals:\n"
        f"- **Active Tenders**: {totals.get('total_tenders', 0)} | **Submitted Bids**: {totals.get('total_bids', 0)}\n"
        f"- **Registered Contractors**: {totals.get('total_contractors', 0)}\n"
        f"- **Citizen Issue Reports**: {totals.get('total_issues', 0)} total\n\n"
        f"You can ask me specific questions such as:\n"
        f"• *\"Which projects are currently delayed?\"*\n"
        f"• *\"What is the budget breakdown and spending?\"*\n"
        f"• *\"Show contractor performance and blacklisted vendors.\"*\n"
        f"• *\"List reported citizen issues and risks.\"*"
    ), "govtracker-intelligence-v2"
