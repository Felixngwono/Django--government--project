from datetime import date, timedelta
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
from member.models import Project, ReportIssue, User, Tender, TenderApplication, Contractor


class AIInsightsTest(TestCase):
    def test_admin_dashboard_view_renders(self):
        user = User.objects.create_superuser(email='admin@example.com', username='admin', password='testpass123')
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
        self.assertEqual(model, 'govtracker-intelligence-v2')


class ProjectOverviewTest(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(email='overview_user@example.com', username='overviewuser', password='password123')
        self.p1 = Project.objects.create(
            project_title='Nairobi Expressway',
            project_description='Major highway expansion',
            project_location='Nairobi',
            project_status='ongoing',
            priority='high',
            project_Budgeting=1000000,
            amount_spent=250000,
            implementing_agency='KeNHA',
            end_date=date.today() + timedelta(days=30)
        )
        self.p2 = Project.objects.create(
            project_title='Mombasa Port Expansion',
            project_description='Deep water berth',
            project_location='Mombasa',
            project_status='completed',
            priority='medium',
            project_Budgeting=500000,
            amount_spent=500000,
            implementing_agency='KPA',
            end_date=date.today() - timedelta(days=10)
        )
        self.p3 = Project.objects.create(
            project_title='Kisumu Water Project',
            project_description='Clean water network',
            project_location='Kisumu',
            project_status='delayed',
            priority='high',
            project_Budgeting=300000,
            amount_spent=100000,
            implementing_agency='Ministry of Water',
            end_date=date.today() - timedelta(days=5)
        )

    def test_project_overview_view_renders(self):
        self.client.force_login(self.user)
        response = self.client.get(reverse('projectoverview'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'overview.html')
        self.assertEqual(response.context['total_projects'], 3)
        self.assertEqual(response.context['ongoing_count'], 1)
        self.assertEqual(response.context['completed_count'], 1)
        self.assertEqual(response.context['delayed_count'], 1)
        self.assertEqual(response.context['total_budget'], 1800000)
        self.assertEqual(response.context['total_spent'], 850000)
        self.assertEqual(response.context['budget_remaining'], 950000)
        self.assertEqual(response.context['budget_utilization'], 47.2)

    def test_project_overview_search_and_filters(self):
        self.client.force_login(self.user)

        # Search by query
        response = self.client.get(reverse('projectoverview'), {'q': 'Expressway'})
        self.assertEqual(len(response.context['projects']), 1)
        self.assertEqual(response.context['projects'][0].project_title, 'Nairobi Expressway')

        # Filter by status
        response = self.client.get(reverse('projectoverview'), {'status': 'completed'})
        self.assertEqual(len(response.context['projects']), 1)
        self.assertEqual(response.context['projects'][0].project_title, 'Mombasa Port Expansion')

        # Filter by priority
        response = self.client.get(reverse('projectoverview'), {'priority': 'high'})
        self.assertEqual(len(response.context['projects']), 2)


class TenderAndBidsTest(TestCase):
    def setUp(self):
        self.officer = User.objects.create_user(email='officer@example.com', username='officer', password='password123', is_superuser=True)
        self.contractor_user = User.objects.create_user(email='contractor@example.com', username='contractor', password='password123')
        self.project = Project.objects.create(
            project_title='Bridge Construction',
            project_location='Nakuru',
            project_status='ongoing',
            project_Budgeting=2000000
        )
        self.tender = Tender.objects.create(
            title='Nakuru Bridge Procurement',
            reference_number='TND-2025-001',
            project=self.project,
            status='open',
            created_by=self.officer,
            estimated_budget=1500000,
            closing_date=date.today() + timedelta(days=15)
        )

    def test_tender_list_view(self):
        self.client.force_login(self.contractor_user)
        response = self.client.get(reverse('tender_list'))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Nakuru Bridge Procurement')

    def test_tender_detail_view(self):
        self.client.force_login(self.contractor_user)
        response = self.client.get(reverse('tender_detail', args=[self.tender.id]))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'TND-2025-001')

    def test_apply_tender_creates_bid_and_contractor_profile(self):
        self.client.force_login(self.contractor_user)
        post_data = {
            'company_name': 'Apex Builders Ltd',
            'company_email': 'apex@example.com',
            'company_phone': '0712345678',
            'bid_amount': 1200000,
        }
        response = self.client.post(reverse('apply_tender', args=[self.tender.id]), post_data)
        self.assertRedirects(response, reverse('track_application'))

        app = TenderApplication.objects.get(tender=self.tender, applicant=self.contractor_user)
        self.assertEqual(app.company_name, 'Apex Builders Ltd')
        self.assertEqual(app.bid_amount, 1200000)

        # Check Contractor profile auto creation
        contractor = Contractor.objects.get(company='Apex Builders Ltd')
        self.assertEqual(contractor.email, 'apex@example.com')

    def test_cannot_apply_twice_or_to_closed_tender(self):
        self.client.force_login(self.contractor_user)
        TenderApplication.objects.create(
            tender=self.tender,
            applicant=self.contractor_user,
            company_name='Apex Builders Ltd',
            bid_amount=1200000
        )
        # Attempt duplicate application
        response = self.client.post(reverse('apply_tender', args=[self.tender.id]), {
            'company_name': 'Apex Builders Ltd',
            'bid_amount': 1100000,
        })
        self.assertRedirects(response, reverse('track_application'))

        # Closed tender test
        closed_tender = Tender.objects.create(
            title='Closed Tender',
            reference_number='TND-2025-002',
            status='closed',
            closing_date=date.today() - timedelta(days=1)
        )
        response = self.client.get(reverse('apply_tender', args=[closed_tender.id]))
        self.assertRedirects(response, reverse('tender_detail', args=[closed_tender.id]))

    def test_evaluate_and_award_tender(self):
        # Create 2 applications
        user2 = User.objects.create_user(email='bolder@example.com', username='bolderuser', password='password123')
        app1 = TenderApplication.objects.create(
            tender=self.tender,
            applicant=self.contractor_user,
            company_name='Apex Builders Ltd',
            bid_amount=1000000,
            technical_score=80.0
        )
        app2 = TenderApplication.objects.create(
            tender=self.tender,
            applicant=user2,
            company_name='Bolder Infra',
            bid_amount=1200000,
            technical_score=90.0
        )

        self.client.force_login(self.officer)

        # Evaluate
        self.tender.status = 'closed'
        self.tender.save()
        response = self.client.post(reverse('evaluate_tender', args=[self.tender.id]), {
            f'tech_{app1.id}': '85',
            f'tech_{app2.id}': '90',
        })
        self.assertRedirects(response, reverse('evaluate_tender', args=[self.tender.id]))

        app1.refresh_from_db()
        app2.refresh_from_db()
        self.assertEqual(app1.financial_score, 100.0) # 1000000 / 1000000 * 100
        self.assertAlmostEqual(app2.financial_score, 83.333333, places=2)

        # Award tender to app1
        response = self.client.post(reverse('award_tender', args=[self.tender.id]), {
            'application_id': app1.id
        })
        self.assertRedirects(response, reverse('tender_detail', args=[self.tender.id]))

        self.tender.refresh_from_db()
        self.assertEqual(self.tender.status, 'awarded')
        self.assertEqual(self.tender.awarded_to.company, 'Apex Builders Ltd')
        self.assertEqual(self.tender.project.project_contractor, 'Apex Builders Ltd')

    def test_my_bids_view(self):
        TenderApplication.objects.create(
            tender=self.tender,
            applicant=self.contractor_user,
            company_name='Apex Builders Ltd',
            bid_amount=1200000
        )
        self.client.force_login(self.contractor_user)
        response = self.client.get(reverse('my_bids'))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Apex Builders Ltd')

        # Filter by search
        response = self.client.get(reverse('my_bids'), {'q': 'Nakuru'})
        self.assertEqual(response.status_code, 200)
