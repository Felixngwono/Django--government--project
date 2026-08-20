# services/ai/chat_assistant.py

import json
from django.conf import settings
from openai import OpenAI
from member.models import AIChatSession, AIChatMessage, Project, ReportIssue
from member.ai_services import build_project_intelligence

SYSTEM_PROMPT = """
You are GovTracker Assistant — an AI for a government project tracking platform.
You help citizens, officials, and managers understand project statuses,
tender information, progress reports, and budgets.
Be factual, concise, and professional. If you lack data, say so clearly.
"""

def get_openai_client():
    api_key = getattr(settings, "OPENAI_API_KEY", "")
    if not api_key:
        return None
    return OpenAI(api_key=api_key)

def chat(session: AIChatSession, user_message: str, project_context: Project = None) -> str:
    client = get_openai_client()
    if not client:
        from ai.chart_assistant import chat as fallback_chat
        return fallback_chat(session, user_message, project_context)

    # Build message history
    history = list(session.messages.order_by('created_at').values('role', 'content'))

    system = SYSTEM_PROMPT
    if project_context:
        system += f"""

Current project context:
- Title: {project_context.project_title}
- Status: {project_context.project_status}
- Budget Used: {project_context.budget_utilization}%
- Location: {project_context.project_location}
- Agency: {project_context.implementing_agency}
"""

    messages = [{"role": "system", "content": system}]
    messages += [{"role": m['role'], "content": m['content']} for m in history[-10:]]  # last 10 msgs
    messages.append({"role": "user", "content": user_message})

    # Save user message
    AIChatMessage.objects.create(session=session, role='user', content=user_message)

    model = getattr(settings, "OPENAI_MODEL", "gpt-4o-mini")
    try:
        response = client.chat.completions.create(
            model=model,
            messages=messages,
            temperature=0.5,
            max_tokens=800,
        )
    except Exception:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            temperature=0.5,
            max_tokens=800,
        )

    reply = response.choices[0].message.content.strip()
    tokens = getattr(response.usage, "total_tokens", None) if hasattr(response, "usage") else None

    AIChatMessage.objects.create(
        session=session,
        role='assistant',
        content=reply,
        model=getattr(response, "model", model),
        tokens=tokens,
    )

    if session.messages.count() <= 2:
        session.title = user_message[:60]
        session.save(update_fields=['title', 'updated_at'])

    return reply


def generate_ai_portfolio_insights(projects):
    """Generates AI insights for the project portfolio using OpenAI LLM with smart fallback."""
    intelligence = build_project_intelligence(projects)
    totals = intelligence["totals"]
    delayed_projects = totals.get("delayed_projects", 0)
    open_issues = ReportIssue.objects.filter(resolved=False).count()

    total_projects = totals.get("total_projects", 0)
    total_budget = float(totals.get("total_budget", 0) or 0)
    total_spent = float(totals.get("total_spent", 0) or 0)
    remaining_budget = max(0.0, total_budget - total_spent)

    totals["remaining_budget"] = remaining_budget

    if total_projects > 0:
        raw_health = 100 - ((delayed_projects / total_projects) * 35) - (open_issues * 3)
        health_score = max(25, min(100, round(raw_health)))
    else:
        health_score = 100

    totals["health_score"] = health_score

    if health_score >= 80:
        health_status = "Optimal"
        health_color = "emerald"
    elif health_score >= 60:
        health_status = "Attention Required"
        health_color = "amber"
    else:
        health_status = "Critical Risk"
        health_color = "rose"

    totals["health_status"] = health_status
    totals["health_color"] = health_color

    # Key projects breakdown for structured table display
    key_projects = []
    for p in projects[:10]:
        p_budget = float(getattr(p, "project_Budgeting", 0) or 0)
        p_spent = float(getattr(p, "amount_spent", 0) or 0)
        p_variance = max(0.0, p_budget - p_spent)
        p_util = round((p_spent / p_budget * 100), 1) if p_budget > 0 else 0

        p_prog = 0
        if getattr(p, "progress", None):
            try:
                p_prog = int(str(p.progress).replace("%", "").strip())
            except ValueError:
                p_prog = 0

        key_projects.append(
            {
                "id": p.id,
                "title": p.project_title or "Untitled Project",
                "category": p.category.name if getattr(p, "category", None) else "Infrastructure",
                "status": (p.project_status or "ongoing").lower(),
                "budget": p_budget,
                "spent": p_spent,
                "variance": p_variance,
                "utilization": p_util,
                "progress": p_prog,
                "location": p.project_location or "National",
                "contractor": str(p.project_contractor) if p.project_contractor else "Unassigned",
                "priority": getattr(p, "priority", "medium") or "medium",
            }
        )

    clean_fallback_summary = (
        f"The government project portfolio currently encompasses {total_projects} active capital projects "
        f"with a cumulative budget allocation of KES {total_budget:,.2f}. "
        f"Presently, {totals.get('ongoing_projects', 0)} projects are in active execution, "
        f"{totals.get('completed_projects', 0)} are completed, and {delayed_projects} projects face timeline delays requiring supervisory action."
    )

    recommendations = list(intelligence.get("recommendations", []))
    if delayed_projects:
        recommendations.append(f"Accelerate timeline recovery for {delayed_projects} delayed project(s) via active contractor review.")
    if open_issues:
        recommendations.append(f"Triage {open_issues} open citizen issue report(s) to maintain public trust and project compliance.")

    insights = {
        "summary": clean_fallback_summary,
        "ai_assistant_summary": f"Strategic analysis indicates budget utilization at {totals.get('budget_utilization', 0)}%. Financial commitments remain within projections, though {delayed_projects} delayed project(s) require intervention.",
        "totals": totals,
        "recommendations": recommendations,
        "key_projects": key_projects,
        "open_issues_count": open_issues,
        "is_ai_generated": False,
    }

    client = get_openai_client()
    if not client:
        return insights

    # Prepare prompt for OpenAI LLM
    delayed_names = [p.project_title for p in projects.filter(project_status__iexact="delayed")[:5]]
    prompt = f"""You are the Lead Government AI Analytics Advisor for GovTracker.
Analyze the following project portfolio dataset and provide executive-level AI insights:

Dataset:
- Total Projects: {totals.get('total_projects', 0)}
- Ongoing Projects: {totals.get('ongoing_projects', 0)}
- Upcoming Projects: {totals.get('upcoming_projects', 0)}
- Completed Projects: {totals.get('completed_projects', 0)}
- Delayed Projects: {delayed_projects} (Sample delayed: {', '.join(delayed_names) if delayed_names else 'None'})
- Total Budget Allocated: ${totals.get('total_budget', 0):,.2f}
- Total Spent: ${totals.get('total_spent', 0):,.2f}
- Budget Utilization Rate: {totals.get('budget_utilization', 0)}%
- Open Unresolved Issues: {open_issues}

Respond ONLY in JSON format matching this schema:
{{
  "summary": "<Concise 2-3 sentence executive summary of current project portfolio health and risks>",
  "ai_assistant_summary": "<Strategic AI analysis highlighting specific risk factors, budget performance, and resource efficiency>",
  "recommendations": [
     "<Actionable AI recommendation 1>",
     "<Actionable AI recommendation 2>",
     "<Actionable AI recommendation 3>"
  ]
}}
"""

    model = getattr(settings, "OPENAI_MODEL", "gpt-4o-mini")
    try:
        response = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": "You are a professional government portfolio analyst. Return valid JSON only."},
                {"role": "user", "content": prompt},
            ],
            temperature=0.3,
            max_tokens=600,
        )
        content = response.choices[0].message.content.strip()
        # Clean potential markdown code blocks
        if content.startswith("```"):
            content = content.split("\n", 1)[-1].rsplit("```", 1)[0].strip()
        data = json.loads(content)

        if data.get("summary"):
            insights["summary"] = data["summary"]
        if data.get("ai_assistant_summary"):
            insights["ai_assistant_summary"] = data["ai_assistant_summary"]
        if data.get("recommendations") and isinstance(data["recommendations"], list):
            insights["recommendations"] = data["recommendations"]
        insights["is_ai_generated"] = True
    except Exception:
        # Graceful fallback to heuristic insights if API error occurs
        pass

    return insights

