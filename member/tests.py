from django.test import TestCase
from django.urls import reverse

from member.ai_services import (
    build_project_intelligence,
    build_report_text,
    classify_issue_category,
    predict_project_risk,
    generate_chatbot_reply,
    triage_issue,
)
from member.forms import ReportIssueForm
from member.models import Project, ReportIssue, User


class AIInsightsTest(TestCase):
    def test_admin_dashboard_view_renders(self):
        user = User.objects.create_user(email='admin@example.com', username='admin', password='testpass123')
        self.client.force_login(user)

        response = self.client.get(reverse('adminview'))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Admin Dashboard')

    def test_build_project_intelligence_reports_project_statuses(self):
        Project.objects.create(
            project_title="Road Rehabilitation",
            project_description="Upgrade the main roads",
            project_location="Nairobi",
            project_status="ongoing",
            project_Budgeting=500000,
            amount_spent=120000,
        )
        Project.objects.create(
            project_title="Water Supply",
            project_description="New water pipes",
            project_location="Kisumu",
            project_status="Delayed",
            project_Budgeting=300000,
            amount_spent=90000,
        )
        Project.objects.create(
            project_title="School Renovation",
            project_description="Modernize classrooms",
            project_location="Mombasa",
            project_status="completed",
            project_Budgeting=200000,
            amount_spent=200000,
        )

        intelligence = build_project_intelligence(Project.objects.all())

        self.assertEqual(intelligence["totals"]["total_projects"], 3)
        self.assertEqual(intelligence["totals"]["delayed_projects"], 1)
        self.assertEqual(intelligence["totals"]["completed_projects"], 1)
        self.assertIn("recommendations", intelligence)

    def test_classify_issue_category_and_risk_prediction(self):
        category = classify_issue_category("The road is blocked and there is a serious delay")
        self.assertEqual(category, "infrastructure")

        risk = predict_project_risk("Road project is delayed and budget is overspending")
        self.assertIn(risk["level"], {"high", "medium", "low"})

    def test_triage_falls_back_safely_without_an_api_key(self):
        user = User.objects.create_user(email='citizen@example.com', username='citizen', password='testpass123')
        project = Project.objects.create(project_title='Road Upgrade', project_status='ongoing')
        issue = ReportIssue.objects.create(project=project, user=user, title='Blocked road', issue_description='The road is blocked and unsafe.')
        assessment = triage_issue(issue)
        self.assertEqual(assessment['provider'], 'heuristic')
        self.assertEqual(assessment['category'], 'infrastructure')

    def test_issue_form_does_not_allow_user_impersonation(self):
        self.assertNotIn('user', ReportIssueForm().fields)

    def test_build_report_text_contains_summary(self):
        report = build_report_text("Road project is delayed and budget is growing")
        self.assertIn("summary", report.lower())

    def test_chatbot_has_a_useful_local_response_without_an_api_key(self):
        context = {
            'summary': 'Portfolio: 2 projects â€” 1 ongoing and 1 delayed.',
            'status_breakdown': {'delayed': 1},
            'totals': {'total_budget': 500000, 'total_spent': 200000, 'budget_utilization': 40},
        }
        reply, model = generate_chatbot_reply('What is the budget?', [], context)

        self.assertIn('500,000.00', reply)
        self.assertEqual(model, '')
