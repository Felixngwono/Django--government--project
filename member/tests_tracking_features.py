from datetime import timedelta
from decimal import Decimal

from django.test import TestCase
from django.urls import reverse
from django.utils import timezone

from member.models import (
    ContractorPaymentRequest,
    GovernmentAgency,
    IssueResponse,
    IssueResponsePolicy,
    Project,
    ProjectBaseline,
    ProjectChangeRequest,
    ProjectInspection,
    ReportIssue,
    ProjectStage,
    User,
)


class ProjectGovernanceWorkflowTests(TestCase):
    def setUp(self):
        self.official = User.objects.create_user(
            email='official@example.com',
            username='official',
            password='password123',
            role='official',
        )
        self.project = Project.objects.create(
            project_title='Community Health Centre',
            project_Budgeting=Decimal('1000000.00'),
            start_date=timezone.localdate(),
            end_date=timezone.localdate() + timedelta(days=180),
        )
        self.client.force_login(self.official)

    def test_project_stage_list_paginates_and_preserves_filters(self):
        for index in range(10):
            ProjectStage.objects.create(
                project=self.project,
                stage_name=f'Construction section {index}',
                order=index,
            )

        response = self.client.get(
            reverse('projectstage_list'),
            {'page': 2, 'q': 'Construction', 'project': self.project.pk},
        )

        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.context['stages']), 1)
        self.assertEqual(response.context['stages'].number, 2)
        self.assertEqual(response.context['total_stages'], 10)
        self.assertContains(response, f'?page=1&q=Construction&project={self.project.pk}')

    def test_project_creation_records_approved_baseline(self):
        baseline = ProjectBaseline.objects.get(project=self.project)

        self.assertEqual(baseline.approved_budget, Decimal('1000000.00'))
        self.assertEqual(baseline.approved_start_date, self.project.start_date)
        self.assertEqual(baseline.approved_end_date, self.project.end_date)

    def test_change_request_requires_approval_before_changing_project(self):
        response = self.client.post(
            reverse('project_change_requests', args=[self.project.pk]),
            {
                'proposed_budget': '1250000.00',
                'reason': 'Additional accessibility works were added to the scope.',
            },
        )

        self.assertRedirects(
            response,
            reverse('project_change_requests', args=[self.project.pk]),
        )
        change = ProjectChangeRequest.objects.get(project=self.project)
        self.assertEqual(change.status, 'pending')
        self.project.refresh_from_db()
        self.assertEqual(self.project.project_Budgeting, Decimal('1000000.00'))

        response = self.client.post(
            reverse('review_project_change', args=[change.pk]),
            {'decision': 'approved', 'reviewer_comments': 'Approved after review.'},
        )

        self.assertRedirects(
            response,
            reverse('project_change_requests', args=[self.project.pk]),
        )
        self.project.refresh_from_db()
        self.assertEqual(self.project.project_Budgeting, Decimal('1250000.00'))
        self.assertEqual(self.project.baseline.approved_budget, Decimal('1000000.00'))
        change.refresh_from_db()
        self.assertEqual(change.status, 'approved')

    def test_contract_value_change_requires_a_project_tender(self):
        response = self.client.post(
            reverse('project_change_requests', args=[self.project.pk]),
            {
                'proposed_contract_value': '950000.00',
                'reason': 'Adjust the awarded contract after an approved scope review.',
            },
        )

        self.assertEqual(response.status_code, 200)
        self.assertFalse(ProjectChangeRequest.objects.filter(project=self.project).exists())
        self.assertContains(response, 'Select the project tender')

    def test_non_official_cannot_approve_project_change(self):
        change = ProjectChangeRequest.objects.create(
            project=self.project,
            proposed_budget=Decimal('1200000.00'),
            reason='Approved budget adjustment.',
            requested_by=self.official,
        )
        citizen = User.objects.create_user(
            email='citizen@example.com',
            username='citizen',
            password='password123',
            role='citizen',
        )
        self.client.force_login(citizen)

        response = self.client.post(
            reverse('review_project_change', args=[change.pk]),
            {'decision': 'approved'},
        )

        self.assertEqual(response.status_code, 403)
        self.project.refresh_from_db()
        self.assertEqual(self.project.project_Budgeting, Decimal('1000000.00'))

    def test_inspection_is_recorded_with_authorized_inspector(self):
        response = self.client.post(
            reverse('project_inspections', args=[self.project.pk]),
            {
                'outcome': 'corrective_action',
                'findings': 'Drainage work needs correction before handover.',
                'latitude': '-1.286389',
                'longitude': '36.817223',
            },
        )

        self.assertRedirects(
            response,
            reverse('project_inspections', args=[self.project.pk]),
        )
        inspection = ProjectInspection.objects.get(project=self.project)
        self.assertEqual(inspection.inspected_by, self.official)
        self.assertEqual(inspection.outcome, 'corrective_action')
        self.assertEqual(inspection.latitude, Decimal('-1.286389'))

    def test_agency_registry_creates_a_shared_agency_record(self):
        response = self.client.post(
            reverse('government_agencies'),
            {'name': 'Ministry of Public Works', 'code': 'MPW', 'is_active': 'on'},
        )

        self.assertRedirects(response, reverse('government_agencies'))
        self.assertTrue(GovernmentAgency.objects.filter(code='MPW').exists())

    def test_agency_registry_updates_and_deactivates_existing_agency(self):
        agency = GovernmentAgency.objects.create(name='Ministry of Works', code='MOW')

        response = self.client.post(
            reverse('government_agencies'),
            {
                'agency_id': agency.pk,
                'name': 'Ministry of Public Works',
                'code': 'MPW',
                'description': 'Responsible for public infrastructure.',
                'contact_email': 'contact@example.gov',
                'contact_phone': '+254700000000',
            },
        )

        self.assertRedirects(response, reverse('government_agencies'))
        agency.refresh_from_db()
        self.assertEqual(agency.name, 'Ministry of Public Works')
        self.assertEqual(agency.code, 'MPW')
        self.assertFalse(agency.is_active)


class IssueAndPaymentAccountabilityTests(TestCase):
    def setUp(self):
        self.manager = User.objects.create_user(
            email='manager@example.com',
            username='manager',
            password='password123',
            role='manager',
        )
        self.project = Project.objects.create(project_title='Public Water Point')

    def test_issue_submission_uses_configured_severity_response_target(self):
        policy, _created = IssueResponsePolicy.objects.get_or_create(
            severity='moderate',
            defaults={'target_hours': 168},
        )
        reporter = User.objects.create_user(
            email='reporter@example.com',
            username='reporter',
            password='password123',
            role='citizen',
        )
        self.client.force_login(reporter)
        before = timezone.now()

        response = self.client.post(
            reverse('add_report_issue'),
            {
                'title': 'Broken public tap',
                'project': self.project.pk,
                'issue_description': 'The water tap has stopped working.',
            },
        )

        self.assertRedirects(response, reverse('issue_list'))
        issue = ReportIssue.objects.get(project=self.project)
        self.assertGreaterEqual(
            issue.response_due_at,
            before + timedelta(hours=policy.target_hours),
        )
        self.assertEqual(issue.status, 'pending')

    def test_inline_project_issue_submission_gets_response_deadline(self):
        policy, _created = IssueResponsePolicy.objects.get_or_create(
            severity='moderate',
            defaults={'target_hours': 168},
        )
        self.client.force_login(self.manager)
        before = timezone.now()

        response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'issue_add',
                'title': 'Blocked drain',
                'severity': 'moderate',
                'issue_description': 'A blocked drain is causing local flooding.',
            },
        )

        self.assertRedirects(response, reverse('project_details', args=[self.project.pk]))
        issue = ReportIssue.objects.get(project=self.project)
        self.assertGreaterEqual(
            issue.response_due_at,
            before + timedelta(hours=policy.target_hours),
        )

    def test_inline_issue_closure_records_public_resolution_and_closure_time(self):
        issue = ReportIssue.objects.create(
            title='Damaged streetlight',
            project=self.project,
            issue_description='The streetlight beside the clinic is not working.',
            user=self.manager,
            status='in_progress',
            response_due_at=timezone.now() + timedelta(days=7),
        )
        self.client.force_login(self.manager)

        response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'issue_status',
                'issue_id': issue.pk,
                'status': 'resolved',
                'resolution_notes': 'The streetlight was repaired and tested.',
            },
        )

        self.assertRedirects(response, reverse('project_details', args=[self.project.pk]))
        issue.refresh_from_db()
        self.assertEqual(issue.status, 'resolved')
        self.assertIsNotNone(issue.closed_at)
        self.assertTrue(
            IssueResponse.objects.filter(
                issue=issue,
                author=self.manager,
                response='The streetlight was repaired and tested.',
                is_internal=False,
            ).exists()
        )

    def test_staff_can_assign_issue_and_record_response(self):
        issue = ReportIssue.objects.create(
            title='Damaged footpath',
            project=self.project,
            issue_description='A section of the footpath is damaged.',
            user=self.manager,
            response_due_at=timezone.now() + timedelta(days=7),
        )
        self.client.force_login(self.manager)

        response = self.client.post(
            reverse('issue_detail', args=[issue.pk]),
            {'action': 'respond', 'response': 'Inspection has been scheduled.'},
        )

        self.assertRedirects(response, reverse('issue_detail', args=[issue.pk]))
        self.assertTrue(IssueResponse.objects.filter(issue=issue, author=self.manager).exists())

    def test_payment_cannot_be_marked_paid_without_disbursement_reference(self):
        payment = ContractorPaymentRequest.objects.create(
            project=self.project,
            submitted_by=self.manager,
            title='Water point repair invoice',
            amount=Decimal('25000.00'),
            invoice_file='contractor_invoices/invoice.pdf',
            status='approved',
        )
        self.client.force_login(self.manager)

        response = self.client.post(
            reverse('contractor_review_queue'),
            {
                'submission_type': 'payment',
                'submission_id': payment.pk,
                'action': 'paid',
            },
        )

        self.assertRedirects(response, reverse('contractor_review_queue'))
        payment.refresh_from_db()
        self.assertEqual(payment.status, 'approved')
        self.assertEqual(payment.disbursement_reference, '')
