from datetime import date, timedelta
from django.core.files.uploadedfile import SimpleUploadedFile
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
from member.forms import MyUserCreationForm, ReportIssueForm
from member.models import (
    Contractor,
    ContractorPaymentRequest,
    Milestone,
    Project,
    ProjectStage,
    ReportIssue,
    StageReport,
    Tender,
    TenderApplication,
    User,
)


class ContractorStageReportProjectSelectionTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            email='contractor@example.com',
            username='contractor',
            password='password123',
            role='contractor',
            name='Working Contractor',
        )
        self.project = Project.objects.create(project_title='Road Upgrade')
        self.other_project = Project.objects.create(project_title='Water Supply')
        unrelated_contractor = Contractor.objects.create(
            email='other-contractor@example.com',
            name='Other Contractor',
        )
        unrelated_contractor.projects.add(self.project)
        self.contractor = Contractor.objects.create(
            email='registered-contractor@example.com',
            name=self.user.full_name,
        )
        self.contractor.projects.add(self.project, self.other_project)
        self.client.force_login(self.user)

    def test_project_works_report_link_preselects_the_current_project(self):
        response = self.client.get(
            reverse('submit_stage_report'),
            {'project': self.project.pk},
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, f'name="project" value="{self.project.pk}"')
        self.assertContains(response, self.project.project_title)
        self.assertNotContains(response, '<select name="project"')

    def test_multiple_assigned_projects_are_available_for_selection(self):
        response = self.client.get(reverse('submit_stage_report'))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, f'value="{self.project.pk}">{self.project.project_title}</option>')
        self.assertContains(response, f'value="{self.other_project.pk}">{self.other_project.project_title}</option>')
        self.assertContains(response, '<select name="project"')

    def test_only_assigned_project_is_preselected_automatically(self):
        self.contractor.projects.remove(self.other_project)

        response = self.client.get(reverse('submit_stage_report'))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, f'name="project" value="{self.project.pk}"')
        self.assertNotContains(response, '<select name="project"')

    def test_report_cannot_be_submitted_for_an_unassigned_project(self):
        unassigned_project = Project.objects.create(project_title='School Repair')

        response = self.client.post(reverse('submit_stage_report'), {
            'project': unassigned_project.pk,
            'stage_description': 'Foundation',
            'description': 'Foundation work completed.',
            'location': 'Central',
            'progress_percentage': 25,
        })

        self.assertEqual(response.status_code, 302)
        self.assertFalse(StageReport.objects.exists())

    def test_assigned_contractor_can_see_add_milestone_form(self):
        response = self.client.get(reverse('project_details', args=[self.project.pk]))

        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.context['can_manage_project_stages'])
        self.assertContains(response, 'Add Milestone')
        self.assertContains(response, 'Add Stage')
        self.assertContains(response, 'x-show="addMilestone"')
        self.assertContains(response, 'x-show="addStage"')

    def test_unassigned_contractor_cannot_see_stage_or_milestone_actions(self):
        unassigned_user = User.objects.create_user(
            email='unassigned@example.com',
            username='unassigned-contractor',
            password='password123',
            role='contractor',
            name='Unassigned Contractor',
        )
        self.client.force_login(unassigned_user)

        response = self.client.get(reverse('project_details', args=[self.project.pk]))

        self.assertEqual(response.status_code, 200)
        self.assertFalse(response.context['can_manage_project_stages'])
        self.assertNotContains(response, 'Add Stage')
        self.assertNotContains(response, 'Add Milestone')

    def test_unassigned_contractor_cannot_post_stage_or_milestone(self):
        unassigned_user = User.objects.create_user(
            email='unassigned@example.com',
            username='unassigned-contractor',
            password='password123',
            role='contractor',
            name='Unassigned Contractor',
        )
        self.client.force_login(unassigned_user)
        url = reverse('project_details', args=[self.project.pk])

        self.client.post(url, {
            'action': 'stage_add',
            'stage_name': 'Unauthorized stage',
            'description': 'Should not be saved.',
            'progress_percentage': '0',
            'status': 'not_started',
            'order': '1',
        })
        self.client.post(url, {
            'action': 'milestone_add',
            'title': 'Unauthorized milestone',
            'description': 'Should not be saved.',
            'progress_percentage': '0',
            'status': 'pending',
            'stage': '',
        })

        self.assertFalse(ProjectStage.objects.filter(
            project=self.project, stage_name='Unauthorized stage'
        ).exists())
        self.assertFalse(Milestone.objects.filter(
            project=self.project, title='Unauthorized milestone'
        ).exists())

    def test_assigned_contractor_can_add_stage_and_milestone(self):
        stage_response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'stage_add',
                'stage_name': 'Foundation work',
                'description': 'Prepare the foundation.',
                'progress_percentage': '10',
                'status': 'in_progress',
                'order': '1',
            },
        )
        milestone_response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'milestone_add',
                'title': 'Foundation inspection',
                'description': 'Complete the foundation inspection.',
                'progress_percentage': '0',
                'status': 'pending',
                'stage': '',
            },
        )

        self.assertEqual(stage_response.status_code, 302)
        self.assertEqual(milestone_response.status_code, 302)
        self.assertTrue(ProjectStage.objects.filter(
            project=self.project, stage_name='Foundation work'
        ).exists())
        self.assertTrue(Milestone.objects.filter(
            project=self.project, title='Foundation inspection'
        ).exists())


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


class RolePermissionTests(TestCase):
    def setUp(self):
        self.citizen = User.objects.create_user(
            email='citizen-role@example.com', username='citizen-role', password='password123'
        )
        self.officer = User.objects.create_user(
            email='officer-role@example.com', username='officer-role', password='password123', role='official'
        )

    def test_registration_and_profile_form_do_not_expose_privileged_fields(self):
        form = MyUserCreationForm()
        self.assertNotIn('role', form.fields)
        self.assertNotIn('is_enduser', form.fields)

    def test_citizen_cannot_create_projects_tenders_or_budgets(self):
        self.client.force_login(self.citizen)
        for url_name in (
            'createproject', 'add_tender', 'add_budget', 'add_expense',
            'generate_report', 'system_reports', 'export_pdf', 'export_excel',
        ):
            with self.subTest(url_name=url_name):
                response = self.client.get(reverse(url_name))
                self.assertEqual(response.status_code, 403)

    def test_citizen_cannot_edit_another_users_profile(self):
        other_user = User.objects.create_user(
            email='another@example.com', username='another-user', password='password123'
        )
        self.client.force_login(self.citizen)
        response = self.client.get(reverse('profile', args=[other_user.pk]))
        self.assertEqual(response.status_code, 403)

    def test_officer_can_open_staff_workflows(self):
        self.client.force_login(self.officer)
        for url_name in ('createproject', 'add_tender', 'add_budget', 'add_expense'):
            with self.subTest(url_name=url_name):
                response = self.client.get(reverse(url_name))
                self.assertEqual(response.status_code, 200)


class CitizenEvidenceSubmissionTest(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(email='citizen@example.com', username='citizen', password='password123')
        self.project = Project.objects.create(
            project_title='Road Repair Project',
            project_description='Rehabilitate city roads',
            project_location='Kisumu',
            project_status='ongoing',
            project_Budgeting=500000,
            amount_spent=100000,
        )
        self.stage = self.project.stages.create(
            stage_name='construction',
            description='Road repair works',
            progress_percentage=45,
            order=1,
        )

    def test_submit_evidence_captures_full_context(self):
        self.client.force_login(self.user)
        response = self.client.post(reverse('submit_evidence'), {
            'project': self.project.id,
            'stage': self.stage.id,
            'category': 'infrastructure',
            'severity': 'high',
            'evidence_type': 'photo',
            'title': 'Cracked bridge support',
            'description': 'A major support beam is visibly cracked and unsafe.',
            'location': 'Nairobi Road junction',
            'coordinates': '-1.286389,36.817223',
            'observed_at': '2026-01-15',
            'notes': 'This is near the contractor work area and has become a risk to pedestrians.',
        })

        self.assertEqual(response.status_code, 302)
        evidence = CitizenEvidence.objects.get(user=self.user, project=self.project)
        self.assertEqual(evidence.category, 'infrastructure')
        self.assertEqual(evidence.severity, 'high')
        self.assertEqual(evidence.evidence_type, 'photo')
        self.assertEqual(evidence.coordinates, '-1.286389,36.817223')
        self.assertEqual(evidence.observed_at.strftime('%Y-%m-%d'), '2026-01-15')
        self.assertIn('risk to pedestrians', evidence.notes)


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


class ContractorDashboardWorkflowTests(TestCase):
    def setUp(self):
        self.contractor_user = User.objects.create_user(
            email='builder@example.com',
            username='builder',
            password='password123',
            role='contractor',
            name='Builder Representative',
            organization='BuildCo',
        )
        self.project = Project.objects.create(
            project_title='Clinic Construction',
            project_description='Build a community clinic.',
            project_location='North District',
            project_Budgeting=500000,
            project_status='ongoing',
            end_date=date.today() + timedelta(days=30),
        )
        self.contractor = Contractor.objects.create(
            email=self.contractor_user.email,
            name=self.contractor_user.full_name,
            company='BuildCo',
        )
        self.contractor.projects.add(self.project)

    def test_dashboard_shows_scoped_projects_and_overview_counts(self):
        other_project = Project.objects.create(project_title='Private Unassigned Project')
        StageReport.objects.create(
            project=self.project,
            reported_by=self.contractor_user,
            stage_description='Roofing',
            description='Roofing is in progress.',
            progress_percentage=45,
            location='North District',
        )

        self.client.force_login(self.contractor_user)
        response = self.client.get(reverse('contractor_performance'))

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.context['total_project_count'], 1)
        self.assertEqual(response.context['ongoing_project_count'], 1)
        self.assertEqual(response.context['pending_report_count'], 1)
        self.assertContains(response, self.project.project_title)
        self.assertNotContains(response, other_project.project_title)
        self.assertNotContains(response, 'Contractor Registry & Awarded Projects')

    def test_contractor_can_submit_invoice_only_for_assigned_project(self):
        self.client.force_login(self.contractor_user)
        invoice = SimpleUploadedFile('invoice.pdf', b'%PDF-1.4 test')
        response = self.client.post(reverse('contractor_payment_request'), {
            'project': self.project.pk,
            'invoice_number': 'INV-2026-01',
            'title': 'Foundation milestone invoice',
            'amount': '125000.00',
            'description': 'Foundation work completed.',
            'invoice_file': invoice,
        })

        self.assertRedirects(response, reverse('contractor_performance'))
        payment = ContractorPaymentRequest.objects.get(invoice_number='INV-2026-01')
        self.assertEqual(payment.submitted_by, self.contractor_user)
        self.assertEqual(payment.project, self.project)
        self.assertEqual(payment.status, 'pending')

    def test_officer_can_reject_report_with_feedback_and_approve_payment(self):
        report = StageReport.objects.create(
            project=self.project,
            reported_by=self.contractor_user,
            stage_description='Roofing',
            description='Roofing is in progress.',
            progress_percentage=45,
            location='North District',
        )
        payment = ContractorPaymentRequest.objects.create(
            project=self.project,
            contractor=self.contractor,
            submitted_by=self.contractor_user,
            title='Approved milestone invoice',
            amount=125000,
            invoice_file=SimpleUploadedFile('invoice.pdf', b'%PDF-1.4 test'),
        )
        reviewer = User.objects.create_user(
            email='officer@example.com',
            username='officer',
            password='password123',
            role='official',
        )
        self.client.force_login(reviewer)

        response = self.client.post(reverse('contractor_review_queue'), {
            'submission_type': 'report',
            'submission_id': report.pk,
            'action': 'rejected',
            'reviewer_comments': 'Attach inspection evidence.',
        })
        self.assertRedirects(response, reverse('contractor_review_queue'))
        report.refresh_from_db()
        self.assertEqual(report.review_status, 'rejected')
        self.assertEqual(report.reviewer_comments, 'Attach inspection evidence.')
        self.assertEqual(report.reviewed_by, reviewer)

        self.client.post(reverse('contractor_review_queue'), {
            'submission_type': 'payment',
            'submission_id': payment.pk,
            'action': 'approved',
            'reviewer_comments': 'Verified against milestone.',
        })
        payment.refresh_from_db()
        self.assertEqual(payment.status, 'approved')
        self.assertEqual(payment.reviewer_comments, 'Verified against milestone.')

    def test_rejected_invoice_requires_reviewer_comment(self):
        payment = ContractorPaymentRequest.objects.create(
            project=self.project,
            contractor=self.contractor,
            submitted_by=self.contractor_user,
            title='Invoice without review note',
            amount=125000,
            invoice_file=SimpleUploadedFile('invoice.pdf', b'%PDF-1.4 test'),
        )
        reviewer = User.objects.create_user(
            email='reviewer@example.com',
            username='reviewer',
            password='password123',
            role='official',
        )
        self.client.force_login(reviewer)

        self.client.post(reverse('contractor_review_queue'), {
            'submission_type': 'payment',
            'submission_id': payment.pk,
            'action': 'rejected',
            'reviewer_comments': '',
        })

        payment.refresh_from_db()
        self.assertEqual(payment.status, 'pending')

    def test_assigned_contractor_can_update_and_submit_milestone_for_verification(self):
        milestone = Milestone.objects.create(
            project=self.project,
            title='Foundation inspection',
            description='Complete and document the foundation.',
            progress_percentage=70,
            status='in_progress',
        )
        self.client.force_login(self.contractor_user)

        detail_response = self.client.get(reverse('milestone_detail', args=[milestone.pk]))
        self.assertEqual(detail_response.status_code, 200)
        self.assertContains(detail_response, 'Update milestone progress')

        update_response = self.client.post(
            reverse('milestone_quick_update', args=[milestone.pk]),
            {'progress_percentage': '100', 'status': 'completed'},
        )
        self.assertEqual(update_response.status_code, 302)
        milestone.refresh_from_db()
        self.assertEqual(milestone.progress_percentage, 100)
        self.assertEqual(milestone.status, 'completed')

        submit_response = self.client.post(
            reverse('submit_milestone_verification', args=[milestone.pk]),
        )
        self.assertEqual(submit_response.status_code, 302)
        milestone.refresh_from_db()
        self.assertEqual(milestone.verification_status, 'pending')
        pending_response = self.client.get(reverse('milestone_detail', args=[milestone.pk]))
        self.assertContains(pending_response, 'awaiting verification')

    def test_unassigned_contractor_cannot_update_or_submit_milestone(self):
        milestone = Milestone.objects.create(
            project=self.project,
            title='Roof inspection',
            description='Inspect the completed roof.',
            progress_percentage=100,
            status='completed',
        )
        unassigned_user = User.objects.create_user(
            email='unassigned-builder@example.com',
            username='other-builder',
            password='password123',
            role='contractor',
            name='Other Builder',
        )
        self.client.force_login(unassigned_user)

        update_response = self.client.post(
            reverse('milestone_quick_update', args=[milestone.pk]),
            {'progress_percentage': '100', 'status': 'completed'},
        )
        submit_response = self.client.post(
            reverse('submit_milestone_verification', args=[milestone.pk]),
        )

        self.assertEqual(update_response.status_code, 403)
        self.assertEqual(submit_response.status_code, 403)
        milestone.refresh_from_db()
        self.assertEqual(milestone.verification_status, 'not_submitted')

    def test_officer_can_review_milestone_and_rejection_requires_comment(self):
        milestone = Milestone.objects.create(
            project=self.project,
            title='Electrical inspection',
            description='Verify wiring and safety.',
            progress_percentage=100,
            status='completed',
            verification_status='pending',
        )
        reviewer = User.objects.create_user(
            email='milestone-reviewer@example.com',
            username='milestone-reviewer',
            password='password123',
            role='official',
        )
        self.client.force_login(reviewer)
        queue_response = self.client.get(reverse('contractor_review_queue'))
        self.assertContains(queue_response, 'Electrical inspection')

        missing_comment_response = self.client.post(reverse('contractor_review_queue'), {
            'submission_type': 'milestone',
            'submission_id': milestone.pk,
            'action': 'rejected',
            'reviewer_comments': '',
        })
        self.assertRedirects(missing_comment_response, reverse('contractor_review_queue'))
        milestone.refresh_from_db()
        self.assertEqual(milestone.verification_status, 'pending')

        review_response = self.client.post(reverse('contractor_review_queue'), {
            'submission_type': 'milestone',
            'submission_id': milestone.pk,
            'action': 'rejected',
            'reviewer_comments': 'Provide the signed inspection record.',
        })
        self.assertRedirects(review_response, reverse('contractor_review_queue'))
        milestone.refresh_from_db()
        self.assertEqual(milestone.verification_status, 'rejected')
        self.assertEqual(milestone.verification_comments, 'Provide the signed inspection record.')
        self.assertEqual(milestone.verified_by, reviewer)
