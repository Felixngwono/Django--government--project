
from member.models import AIChatSession, AIChatMessage, Project

SYSTEM_PROMPT = """
You are GovTracker Assistant — an AI for a government project tracking platform.
You help citizens, officials, and managers understand project statuses, 
tender information, progress reports, and budgets.
Be factual, concise, and professional. If you lack data, say so clearly.
"""

def chat(session: AIChatSession, user_message: str, project_context: Project = None) -> str:
    # Build message history
    history = list(session.messages.order_by('created_at').values('role', 'content'))

    # Optionally inject project context
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

    reply = "AI chat is currently unavailable because no AI service is configured."
    tokens = 0
    model_name = "offline"

    AIChatMessage.objects.create(
        session=session,
        role='assistant',
        content=reply,
        model=model_name,
        tokens=tokens,
    )

    # Update session title if it's new
    if session.messages.count() <= 2:
        session.title = user_message[:60]
        session.save(update_fields=['title', 'updated_at'])

    return reply
