
from member.models import Project, AIReportGeneration

def generate_project_summary(project: Project, requested_by) -> AIReportGeneration:
    stages       = project.stages.all()
    milestones   = project.milestones.all()
    issues_count = project.issues.filter(resolved=False).count()

    context = f"""
    Project: {project.project_title}
    Status: {project.project_status}
    Budget: {project.project_Budgeting} | Spent: {project.amount_spent}
    Budget Utilization: {project.budget_utilization}%
    Start: {project.start_date} | End: {project.end_date}
    Implementing Agency: {project.implementing_agency}
    Stages: {[s.get_stage_name_display() for s in stages]}
    Milestones completed: {milestones.filter(status='completed').count()}/{milestones.count()}
    Open Issues: {issues_count}
    Progress: {project.progress}
    """

    return AIReportGeneration.objects.create(
        project=project,
        requested_by=requested_by,
        report_type='executive_summary',
        output='AI report generation is unavailable because no AI service is configured.',
        status='generated',
        model='offline',
    )
