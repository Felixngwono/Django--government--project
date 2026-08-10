# services/ai/chat_assistant.py

from openai import OpenAI
from member.models import AIChatSession, AIChatMessage, Project

client = OpenAI()

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

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        messages=messages,
        temperature=0.5,
        max_tokens=800,
    )

    reply = response.choices[0].message.content
    tokens = response.usage.total_tokens

    AIChatMessage.objects.create(
        session=session,
        role='assistant',
        content=reply,
        model=response.model,
        tokens=tokens,
    )

    # Update session title if it's new
    if session.messages.count() <= 2:
        session.title = user_message[:60]
        session.save(update_fields=['title', 'updated_at'])

    return reply
