from member.models import Project


def load_project_documents():
    """
    Convert Django Project objects into AI-readable documents.
    """

    documents = []

    projects = Project.objects.all()

    for project in projects:

        document = f"""
Project Title:
{project.project_title}

Description:
{project.project_description}

Location:
{project.project_location}

Implementing Agency:
{project.implementing_agency}

Budget:
{project.project_Budgeting}

Amount Spent:
{project.amount_spent}

Remaining Budget:
{project.budget_remaining}

Budget Utilization:
{project.budget_utilization}%

Status:
{project.project_status}

Project Manager:
{project.project_manager}

Contractor:
{project.project_contractor}

Start Date:
{project.start_date}

End Date:
{project.end_date}

Beneficiaries:
{project.beneficiaries}

Stakeholders:
{project.stakeholders}

Impact:
{project.impact}

Progress:
{project.progress}

Remarks:
{project.remarks}
"""

        documents.append(document)

    return documents