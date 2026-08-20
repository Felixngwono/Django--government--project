
from django.conf import settings
from member.ai_services import build_report_text
from member.models import Project, AIReportGeneration
from ai.services import get_openai_client

def generate_project_summary(project: Project, requested_by) -> AIReportGeneration:
    milestones = project.milestones.all()
    issues_count = project.issues.filter(resolved=False).count()

    context = (
        f"Project: {project.project_title}. Status: {project.project_status}. "
        f"Description: {project.project_description or 'None'}. "
        f"Budget: {project.project_Budgeting or 0}; Spent: {project.amount_spent or 0}; "
        f"Utilization: {project.budget_utilization}%. Open issues: {issues_count}. "
        f"Milestones completed: {milestones.filter(status='completed').count()}/{milestones.count()}. "
        f"Progress: {project.progress or 'No progress update recorded.'}"
    )

    output = None
    model_used = "govtracker-rules-v1"
    client = get_openai_client()

    if client:
        try:
            model = getattr(settings, "OPENAI_MODEL", "gpt-4o-mini")
            prompt = f"Generate an executive summary report for this government project context:\n{context}"
            response = client.chat.completions.create(
                model=model,
                messages=[
                    {"role": "system", "content": "You are a professional government report writer. Write a clear executive summary with key observations, budget performance, and recommended next steps."},
                    {"role": "user", "content": prompt},
                ],
                temperature=0.3,
                max_tokens=500,
            )
            output = response.choices[0].message.content.strip()
            model_used = getattr(response, "model", model)
        except Exception:
            output = None

    if not output:
        output = build_report_text(context)

    return AIReportGeneration.objects.create(
        project=project,
        requested_by=requested_by,
        report_type='executive_summary',
        output=output,
        status='generated',
        model=model_used,
    )

