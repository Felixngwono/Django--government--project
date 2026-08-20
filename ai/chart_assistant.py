
from django.conf import settings

from member.ai_services import build_project_intelligence, generate_chatbot_reply
from member.models import AIChatSession, AIChatMessage, Project

SYSTEM_PROMPT = """
You are GovTracker Assistant — an AI for a government project tracking platform.
You help citizens, officials, and managers understand project statuses,
tender information, progress reports, and budgets.
Be factual, concise, and professional. If you lack data, say so clearly.
"""

def _openai_reply(user_message, history, context, project_context):
    """Return an API response when configured, otherwise signal a local fallback."""
    api_key = getattr(settings, "OPENAI_API_KEY", "")
    if not api_key:
        return None, None, None

    try:
        from openai import OpenAI

        project_details = ""
        if project_context:
            project_details = (
                f"\nSelected Project Specific Context: {project_context.project_title} (ID: {project_context.id}); "
                f"Status: {project_context.project_status}; "
                f"Budget: KES {getattr(project_context, 'project_Budgeting', 0) or 0:,.2f}; "
                f"Spent: KES {getattr(project_context, 'amount_spent', 0) or 0:,.2f}; "
                f"Location: {project_context.project_location or 'N/A'}; "
                f"Contractor: {project_context.project_contractor or 'N/A'}; "
                f"Progress: {getattr(project_context, 'progress', 0) or 0}%."
            )
        instructions = SYSTEM_PROMPT + (
            "\nUse only the supplied GovTracker platform information below to answer the query accurately and helpfully. "
            "Do not invent project facts, and do not claim to approve or modify database records.\n\n"
            f"GovTracker System Database Context:\n{context['summary']}\n"
            f"{project_details}"
        )
        messages = [{"role": "system", "content": instructions}]
        for item in history[-10:]:
            if item.get("role") in {"user", "assistant"}:
                messages.append({"role": item["role"], "content": item["content"]})
        messages.append({"role": "user", "content": user_message})

        client = OpenAI(api_key=api_key)
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
        if not reply:
            return None, None, None
        tokens = response.usage.total_tokens if hasattr(response, "usage") and response.usage else None
        return reply, getattr(response, "model", model), tokens
    except Exception:
        return None, None, None
        # The application remains usable if credentials, connectivity, quota, or the provider fail.
        return None, None, None


def chat(session: AIChatSession, user_message: str, project_context: Project = None) -> str:
    # Build message history
    history = list(session.messages.order_by('created_at').values('role', 'content'))

    # Save user message
    AIChatMessage.objects.create(session=session, role='user', content=user_message)

    projects = Project.objects.filter(id=project_context.id) if project_context else Project.objects.all()
    context = build_project_intelligence(projects)
    reply, model_name, tokens = _openai_reply(user_message, history, context, project_context)
    if reply is None:
        reply, model_name = generate_chatbot_reply(user_message, history, context)

    AIChatMessage.objects.create(
        session=session,
        role='assistant',
        content=reply,
        model=model_name or "govtracker-rules-v1",
        tokens=tokens,
    )

    # Update session title if it's new
    if session.messages.count() <= 2:
        session.title = user_message[:60]
        session.save(update_fields=['title', 'updated_at'])

    return reply
