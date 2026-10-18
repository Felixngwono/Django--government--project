from io import BytesIO
from tempfile import TemporaryDirectory
from datetime import date, timedelta
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase, override_settings
from django.urls import reverse
from django.utils import timezone
from PIL import Image

from member.ai_services import (
    build_project_intelligence,
    build_report_text,
    classify_issue_category,
    predict_project_risk,
    generate_chatbot_reply,
    triage_issue,
)
from member.forms import MyUserCreationForm, ProjectCreationForm, ReportIssueForm
from member.models import (
    AIProjectAnalysis,
    AuditLog,
    CitizenEvidence,
    Contractor,
    ContractorDocument,
    ContractorPaymentRequest,
    ContractorRating,
    Milestone,
    Project,
    ProjectExpense,
    ProjectStage,
    ProjectStatusHistory,
    ProgressUpdate,
    Notification,
    ReportIssue,
    StageReport,
    StageReportAttachment,
    Tender,
    TenderApplication,
    User,
)


class DelayedProjectMonitoringTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            email='delay-viewer@example.com',
            username='delay-viewer',
            password='password123',
            role='manager',
        )
        self.project = Project.objects.create(
            project_title='Delayed Bridge Renewal',
            project_description='Bridge works awaiting completion.',
            project_location='Central District',
            project_status='ongoing',
            project_Budgeting=1500000,
            end_date=timezone.now().date() - timedelta(days=30),
        )
        ProgressUpdate.objects.create(
            project=self.project,
            description='Deck repairs are underway.',
            progress_percentage=35,
        )
        self.project.project_status = 'delayed'
        self.project.save(update_fields=['project_status'])
        self.client.force_login(self.user)

    def test_delayed_list_uses_project_fields_and_links_to_project_detail(self):
        response = self.client.get(reverse('delayed'))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, self.project.project_title)
        self.assertContains(response, self.project.project_location)
        self.assertContains(response, reverse('project_details', args=[self.project.pk]))
        self.assertContains(response, '35% reported')
        self.assertContains(response, 'Page 1 of 1')

    def test_delayed_list_json_refresh_returns_live_rows_and_uncached_stats(self):
        response = self.client.get(reverse('delayed'), {'format': 'json'})

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response['Cache-Control'], 'no-store')
        payload = response.json()
        self.assertEqual(payload['total_delayed'], 1)
        self.assertEqual(payload['progress_count'], 1)
        self.assertEqual(len(payload['rows']), 1)
        self.assertEqual(payload['rows'][0]['id'], self.project.pk)
        self.assertEqual(payload['rows'][0]['progress'], 35)
        self.assertEqual(payload['rows'][0]['location'], self.project.project_location)
        self.assertEqual(
            payload['rows'][0]['details_url'],
            reverse('project_details', args=[self.project.pk]),
        )

    def test_delayed_filters_apply_to_html_and_json(self):
        other = Project.objects.create(
            project_title='Remote Clinic',
            project_location='Western District',
            project_status='delayed',
        )

        response = self.client.get(
            reverse('delayed'),
            {'q': 'Bridge', 'location': 'Central'},
        )
        json_response = self.client.get(
            reverse('delayed'),
            {'q': 'Bridge', 'location': 'Central', 'format': 'json'},
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, self.project.project_title)
        self.assertNotContains(response, other.project_title)
        self.assertEqual(json_response.json()['total_delayed'], 1)


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

    def test_project_details_links_to_the_assigned_contractor_profile(self):
        response = self.client.get(reverse('project_details', args=[self.project.pk]))

        self.assertEqual(response.status_code, 200)
        self.assertContains(
            response,
            f'href="{reverse("contractor_detail", args=[self.contractor.pk])}"',
        )

    def test_site_work_report_view_button_opens_contractor_workspace_reports_tab(self):
        StageReport.objects.create(
            project=self.project,
            stage_description='Foundation',
            description='Foundation work completed.',
            location='Project site',
            progress_percentage=35,
            reported_by=self.user,
            contractor=self.contractor,
        )

        response = self.client.get(reverse('project_details', args=[self.project.pk]))

        self.assertEqual(response.status_code, 200)
        self.assertContains(
            response,
            f'href="{reverse("contractor_project_works", args=[self.project.pk])}?tab=reports"',
        )

    def test_non_contractor_cannot_see_contractor_profile_stage_reports_or_actions(self):
        StageReport.objects.create(
            project=self.project,
            stage_description='Foundation',
            description='Contractor-submitted work report.',
            location='Project site',
            progress_percentage=35,
            reported_by=self.user,
            contractor=self.contractor,
        )
        officer = User.objects.create_user(
            email='contractor-profile-officer@example.com',
            username='profile-officer',
            password='password123',
            role='official',
        )
        self.client.force_login(officer)

        response = self.client.get(
            reverse('contractor_detail', args=[self.contractor.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertNotContains(response, 'Stage Report')
        self.assertNotContains(response, 'Manage Registry')
        self.assertNotContains(response, 'Stage Reports')
        self.assertNotContains(response, 'Contractor-submitted work report.')

    def test_contractor_can_see_own_stage_report_and_registry_actions(self):
        response = self.client.get(
            reverse('contractor_detail', args=[self.contractor.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Stage Report')
        self.assertContains(response, 'Manage Registry')
        self.assertContains(response, 'Stage Reports')

    def test_non_contractor_cannot_see_or_post_stage_and_milestone_add_actions(self):
        officer = User.objects.create_superuser(
            email='officer@example.com',
            username='officer',
            password='password123',
        )
        StageReport.objects.create(
            project=self.project,
            stage_description='Site preparation',
            description='Contractor work visible to project viewers',
            location='Project site',
            progress_percentage=25,
            reported_by=self.user,
        )
        self.client.force_login(officer)
        url = reverse('project_details', args=[self.project.pk])

        response = self.client.get(url)

        self.assertEqual(response.status_code, 200)
        self.assertFalse(response.context['can_manage_project_stages'])
        self.assertNotContains(response, 'Add Stage')
        self.assertNotContains(response, 'Add Milestone')
        self.assertNotContains(response, 'Add Expense')
        self.assertContains(response, 'Works Done on Site')
        self.assertContains(response, 'Contractor work visible to project viewers')

        stage_response = self.client.post(url, {
            'action': 'stage_add',
            'stage_name': 'Officer-added stage',
            'description': 'Should be denied.',
            'progress_percentage': '0',
            'status': 'not_started',
            'order': '1',
        })
        milestone_response = self.client.post(url, {
            'action': 'milestone_add',
            'title': 'Officer-added milestone',
            'description': 'Should be denied.',
            'progress_percentage': '0',
            'status': 'pending',
            'stage': '',
        })
        expense_response = self.client.post(url, {
            'action': 'expense_add',
            'title': 'Unauthorized expense',
            'category': 'materials',
            'amount': '123.45',
        })

        self.assertEqual(stage_response.status_code, 403)
        self.assertEqual(milestone_response.status_code, 403)
        self.assertEqual(expense_response.status_code, 403)
        self.assertFalse(ProjectStage.objects.filter(
            project=self.project, stage_name='Officer-added stage'
        ).exists())
        self.assertFalse(Milestone.objects.filter(
            project=self.project, title='Officer-added milestone'
        ).exists())
        self.assertFalse(ProjectExpense.objects.filter(
            project=self.project, title='Unauthorized expense'
        ).exists())

    def test_non_assigned_users_cannot_edit_stage_or_milestone_progress(self):
        stage = ProjectStage.objects.create(
            project=self.project,
            stage_name='Foundation',
            status='in_progress',
            progress_percentage=20,
        )
        milestone = Milestone.objects.create(
            project=self.project,
            stage=stage,
            title='Foundation inspection',
            description='Inspect the completed foundation.',
            progress_percentage=20,
            status='in_progress',
        )
        officer = User.objects.create_user(
            email='stage-editor@example.com',
            username='stage-editor',
            password='password123',
            role='official',
        )
        self.client.force_login(officer)
        url = reverse('project_details', args=[self.project.pk])

        response = self.client.get(url)
        stage_progress_response = self.client.post(url, {
            'action': 'job_progress_update',
            'stage_id': stage.pk,
            'progress_percentage': '100',
        })
        stage_status_response = self.client.post(url, {
            'action': 'stage_quick',
            'stage_id': stage.pk,
            'status': 'completed',
        })
        milestone_progress_response = self.client.post(url, {
            'action': 'milestone_quick',
            'milestone_id': milestone.pk,
            'progress_percentage': '100',
            'status': 'completed',
        })

        self.assertEqual(response.status_code, 200)
        self.assertNotContains(response, "Update this job's progress")
        self.assertNotContains(response, '@click="editMs = !editMs"')
        self.assertEqual(stage_progress_response.status_code, 403)
        self.assertEqual(stage_status_response.status_code, 403)
        self.assertEqual(milestone_progress_response.status_code, 403)
        stage.refresh_from_db()
        milestone.refresh_from_db()
        self.assertEqual(stage.progress_percentage, 20)
        self.assertEqual(stage.status, 'in_progress')
        self.assertEqual(milestone.progress_percentage, 20)
        self.assertEqual(milestone.status, 'in_progress')

    def test_assigned_contractor_can_submit_stage_progress_update(self):
        stage = ProjectStage.objects.create(
            project=self.project,
            stage_name='Drainage',
            status='in_progress',
            progress_percentage=25,
        )

        response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'job_progress_update',
                'stage_id': stage.pk,
                'progress_percentage': '60',
                'description': 'Drainage installation is progressing.',
            },
        )

        self.assertEqual(response.status_code, 302)
        stage.refresh_from_db()
        self.assertEqual(stage.progress_percentage, 60)
        self.assertEqual(stage.status, 'in_progress')
        self.assertTrue(ProgressUpdate.objects.filter(
            project=self.project,
            stage=stage,
            reported_by=self.user,
            progress_percentage=60,
            description='Drainage installation is progressing.',
        ).exists())

    def test_unassigned_contractor_cannot_see_stage_or_milestone_actions(self):
        unassigned_user = User.objects.create_user(
            email='unassigned@example.com',
            username='unassigned',
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
        self.assertNotContains(response, 'Add Expense')

        expense_response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'expense_add',
                'title': 'Unassigned expense',
                'category': 'materials',
                'amount': '25.00',
            },
        )

        self.assertEqual(expense_response.status_code, 403)
        self.assertFalse(ProjectExpense.objects.filter(
            project=self.project, title='Unassigned expense'
        ).exists())

    def test_contractor_project_workspace_shows_project_tabs_and_assigned_financials(self):
        ProjectStage.objects.create(
            project=self.project,
            stage_name='Foundation',
            progress_percentage=45,
        )
        ContractorPaymentRequest.objects.create(
            project=self.project,
            contractor=self.contractor,
            submitted_by=self.user,
            title='My foundation invoice',
            amount='125000.00',
            invoice_file='contractor_invoices/my-foundation-invoice.pdf',
            status='paid',
        )
        other_user = User.objects.create_user(
            email='another-contractor@example.com',
            username='another-contractor',
            password='password123',
            role='contractor',
            name='Another Contractor',
        )
        other_contractor = Contractor.objects.create(
            email=other_user.email,
            name=other_user.full_name,
        )
        ContractorPaymentRequest.objects.create(
            project=self.project,
            contractor=other_contractor,
            submitted_by=other_user,
            title='Another contractor invoice',
            amount='75000.00',
            invoice_file='contractor_invoices/another-invoice.pdf',
            status='pending',
        )

        response = self.client.get(
            reverse('contractor_project_works', args=[self.project.pk])
        )

        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'contractors/project_details.html')
        self.assertContains(response, 'Overview')
        self.assertContains(response, 'Milestones')
        self.assertContains(response, 'Progress reports')
        self.assertContains(response, 'Evidence gallery')
        self.assertContains(response, 'Finance')
        self.assertContains(response, 'Inspections')
        self.assertContains(response, 'Documents')
        self.assertContains(response, '45%')
        self.assertContains(response, 'My foundation invoice')
        self.assertContains(response, 'Upload report')
        self.assertContains(response, 'Submit invoice')
        self.assertNotContains(response, 'Another contractor invoice')

        upload_response = self.client.get(
            reverse('upload_progress_report', args=[self.project.pk])
        )
        self.assertEqual(upload_response.status_code, 200)

    def test_non_contractor_cannot_submit_stage_report_or_see_submission_actions(self):
        officer = User.objects.create_user(
            email='works-officer@example.com',
            username='works-officer',
            password='password123',
            role='official',
        )
        self.client.force_login(officer)

        workspace_response = self.client.get(
            reverse('contractor_project_works', args=[self.project.pk])
        )
        form_response = self.client.get(reverse('submit_stage_report'))
        submit_response = self.client.post(reverse('submit_stage_report'), {
            'project': self.project.pk,
            'stage_description': 'Unauthorized stage',
            'description': 'Should not be saved.',
            'location': 'Project site',
            'progress_percentage': '25',
        })

        self.assertEqual(workspace_response.status_code, 200)
        for action_text in (
            'Submit progress',
            'Report work',
            'Submit progress report',
            'Add evidence',
            'Submit your first report',
        ):
            with self.subTest(action_text=action_text):
                self.assertNotContains(workspace_response, action_text)
        self.assertEqual(form_response.status_code, 403)
        self.assertEqual(submit_response.status_code, 403)
        self.assertFalse(StageReport.objects.filter(
            project=self.project, stage_description='Unauthorized stage'
        ).exists())

    def test_authorized_officer_can_see_project_report_evidence_without_submission_actions(self):
        report = StageReport.objects.create(
            project=self.project,
            stage_description='Foundation',
            description='Foundation inspection evidence is available.',
            location='Project site',
            progress_percentage=35,
            reported_by=self.user,
            contractor=self.contractor,
        )
        officer = User.objects.create_user(
            email='evidence-officer@example.com',
            username='evidence-officer',
            password='password123',
            role='official',
        )
        with TemporaryDirectory() as media_root, override_settings(MEDIA_ROOT=media_root):
            StageReportAttachment.objects.create(
                report=report,
                file=SimpleUploadedFile(
                    'inspection-evidence.pdf',
                    b'project evidence',
                    content_type='application/pdf',
                ),
                caption='Foundation inspection evidence file',
            )
            self.client.force_login(officer)
            response = self.client.get(
                reverse('contractor_project_works', args=[self.project.pk]),
                {'tab': 'reports'},
            )

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Foundation inspection evidence is available.')
        self.assertContains(response, 'Foundation inspection evidence file')
        self.assertContains(response, 'inspection-evidence.pdf')
        self.assertNotContains(response, 'Upload report')
        self.assertNotContains(response, 'Submit invoice')
        self.assertNotContains(response, 'Edit submission')
        self.assertNotContains(response, 'Delete submission')

    def test_non_contractor_cannot_upload_progress_reports_or_submit_invoices(self):
        officer = User.objects.create_user(
            email='upload-officer@example.com',
            username='upload-officer',
            password='password123',
            role='official',
        )
        self.client.force_login(officer)

        upload_get = self.client.get(
            reverse('upload_progress_report', args=[self.project.pk])
        )
        upload_post = self.client.post(
            reverse('upload_progress_report', args=[self.project.pk]),
            {'report_title': 'Unauthorized report'},
        )
        invoice_get = self.client.get(reverse('contractor_payment_request'))
        invoice_post = self.client.post(
            reverse('contractor_payment_request'),
            {'title': 'Unauthorized invoice', 'amount': '100.00'},
        )

        self.assertEqual(upload_get.status_code, 403)
        self.assertEqual(upload_post.status_code, 403)
        self.assertEqual(invoice_get.status_code, 403)
        self.assertEqual(invoice_post.status_code, 403)
        self.assertFalse(StageReport.objects.filter(
            project=self.project, stage_description='Unauthorized report'
        ).exists())
        self.assertFalse(ContractorPaymentRequest.objects.filter(
            title='Unauthorized invoice'
        ).exists())

    def test_contractor_can_submit_and_review_multiple_photo_video_and_document_evidence(self):
        def make_image(name):
            image_buffer = BytesIO()
            Image.new('RGB', (2, 2), color='blue').save(image_buffer, format='PNG')
            return SimpleUploadedFile(name, image_buffer.getvalue(), content_type='image/png')

        upload_url = f"{reverse('submit_stage_report')}?project={self.project.pk}"
        with TemporaryDirectory() as media_root, override_settings(MEDIA_ROOT=media_root):
            response = self.client.post(upload_url, {
                'project': self.project.pk,
                'stage_description': 'Roofing',
                'description': 'Roofing works are underway.',
                'location': 'North block',
                'progress_percentage': '35',
                'photos': [
                    make_image('roofing-one.png'),
                    make_image('roofing-two.png'),
                ],
                'attachments': [
                    SimpleUploadedFile(
                        'roofing-walkthrough.mp4',
                        b'video evidence',
                        content_type='video/mp4',
                    ),
                    SimpleUploadedFile(
                        'inspection-notes.pdf',
                        b'%PDF-1.4 inspection evidence',
                        content_type='application/pdf',
                    ),
                ],
            }, follow=True)

            self.assertEqual(response.status_code, 200)
            self.assertEqual(
                response.redirect_chain[-1][0],
                f"{reverse('contractor_project_works', args=[self.project.pk])}?tab=reports",
            )
            report = StageReport.objects.get(project=self.project, reported_by=self.user)
            self.assertEqual(report.images.count(), 2)
            self.assertEqual(report.attachments.count(), 2)
            self.assertEqual(
                {
                    attachment.file.name.rsplit('/', 1)[-1]
                    for attachment in report.attachments.all()
                },
                {'roofing-walkthrough.mp4', 'inspection-notes.pdf'},
            )
            self.assertEqual(
                {attachment.media_kind for attachment in report.attachments.all()},
                {'video', 'document'},
            )
            self.assertContains(response, 'roofing-one.png')
            self.assertContains(response, 'roofing-two.png')
            self.assertContains(response, 'roofing-walkthrough.mp4')
            self.assertContains(response, 'inspection-notes.pdf')
            self.assertContains(response, '<video controls')
            self.assertContains(response, 'On-site evidence')

    def test_contractor_can_edit_own_report_without_changing_original_submission_time(self):
        report = StageReport.objects.create(
            project=self.project,
            stage_description='Foundation',
            description='Initial report',
            location='Site A',
            progress_percentage=20,
            reported_by=self.user,
            review_status='rejected',
            reviewer_comments='Please provide more detail.',
        )
        original_submitted_at = report.created_at

        response = self.client.post(
            reverse('contractor_project_works', args=[self.project.pk]),
            {
                'action': 'report_update',
                'report_id': report.pk,
                'stage_description': 'Foundation works',
                'description': 'Updated foundation report with additional detail.',
                'location': 'Site A, Block 2',
                'progress_percentage': '40',
                'delay_reason': 'Rain interrupted work.',
                'corrective_actions': 'Additional shifts scheduled.',
            },
            follow=True,
        )

        self.assertEqual(response.status_code, 200)
        self.assertEqual(
            response.redirect_chain[-1][0],
            f"{reverse('contractor_project_works', args=[self.project.pk])}?tab=reports",
        )
        report.refresh_from_db()
        self.assertEqual(report.created_at, original_submitted_at)
        self.assertEqual(report.description, 'Updated foundation report with additional detail.')
        self.assertEqual(report.progress_percentage, 40)
        self.assertEqual(report.location, 'Site A, Block 2')
        self.assertEqual(report.review_status, 'pending')
        self.assertEqual(report.reviewer_comments, '')
        self.assertContains(response, 'Save changes and resubmit')
        self.assertTrue(AuditLog.objects.filter(
            model_name='StageReport',
            object_id=report.pk,
            action='stage_report_updated',
        ).exists())

    def test_contractor_can_delete_own_report_and_audit_deletion(self):
        report = StageReport.objects.create(
            project=self.project,
            stage_description='Roofing',
            description='Roofing complete.',
            location='Site A',
            progress_percentage=100,
            reported_by=self.user,
        )

        response = self.client.post(
            reverse('contractor_project_works', args=[self.project.pk]),
            {'action': 'report_delete', 'report_id': report.pk},
            follow=True,
        )

        self.assertEqual(response.status_code, 200)
        self.assertFalse(StageReport.objects.filter(pk=report.pk).exists())
        self.assertTrue(AuditLog.objects.filter(
            model_name='StageReport',
            object_id=report.pk,
            action='stage_report_deleted',
        ).exists())
        self.assertContains(response, 'No progress reports have been submitted')

    def test_contractor_cannot_edit_another_contractors_report(self):
        other_user = User.objects.create_user(
            email='other@example.com',
            username='other-contractor',
            password='password123',
            role='contractor',
            name='Other Contractor',
        )
        other_contractor = Contractor.objects.create(
            email=other_user.email,
            name=other_user.full_name,
        )
        other_contractor.projects.add(self.project)
        report = StageReport.objects.create(
            project=self.project,
            stage_description='Electrical',
            description='Original report.',
            location='Site B',
            progress_percentage=10,
            reported_by=other_user,
        )

        response = self.client.post(
            reverse('contractor_project_works', args=[self.project.pk]),
            {
                'action': 'report_update',
                'report_id': report.pk,
                'stage_description': 'Electrical',
                'description': 'Changed by someone else.',
                'location': 'Site B',
                'progress_percentage': '90',
            },
        )

        self.assertEqual(response.status_code, 404)
        report.refresh_from_db()
        self.assertEqual(report.description, 'Original report.')
        self.assertEqual(report.progress_percentage, 10)

    def test_unassigned_contractor_cannot_post_stage_or_milestone(self):
        unassigned_user = User.objects.create_user(
            email='unassigned@example.com',
            username='unassigned',
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

    def test_assigned_contractor_can_add_project_expense(self):
        response = self.client.post(
            reverse('project_details', args=[self.project.pk]),
            {
                'action': 'expense_add',
                'title': 'Cement delivery',
                'category': 'materials',
                'amount': '1250.50',
                'description': 'Materials for the foundation work.',
            },
        )

        self.assertEqual(response.status_code, 302)
        expense = ProjectExpense.objects.get(project=self.project, title='Cement delivery')
        self.assertEqual(expense.recorded_by, self.user)
        self.assertEqual(str(expense.amount), '1250.50')
        self.project.refresh_from_db()
        self.assertEqual(str(self.project.amount_spent), '1250.50')

    def test_assigned_contractor_can_add_expense_from_expense_form(self):
        response = self.client.post(
            reverse('add_expense'),
            {
                'project': self.project.pk,
                'title': 'Safety equipment',
                'category': 'equipment',
                'amount': '325.00',
                'description': 'Protective gear for site workers.',
            },
        )

        self.assertEqual(response.status_code, 302)
        expense = ProjectExpense.objects.get(project=self.project, title='Safety equipment')
        self.assertEqual(expense.recorded_by, self.user)


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

    def test_officer_can_open_staff_workflows_but_cannot_add_stages_milestones_or_expenses(self):
        self.client.force_login(self.officer)
        for url_name in ('createproject', 'add_tender', 'add_budget'):
            with self.subTest(url_name=url_name):
                response = self.client.get(reverse(url_name))
                self.assertEqual(response.status_code, 200)
        for url_name in ('add_expense', 'projectstage_create', 'milestone_create'):
            with self.subTest(url_name=url_name):
                response = self.client.get(reverse(url_name))
                self.assertEqual(response.status_code, 403)

    def test_only_officials_and_admins_can_create_projects(self):
        engineer = User.objects.create_user(
            email='engineer-role@example.com', username='engineer-role',
            password='password123', role='engineer',
        )
        admin = User.objects.create_user(
            email='admin-role@example.com', username='admin-role',
            password='password123', role='admin',
        )

        for user, expected_status in ((engineer, 403), (admin, 200)):
            with self.subTest(role=user.role):
                self.client.force_login(user)
                response = self.client.get(reverse('createproject'))
                self.assertEqual(response.status_code, expected_status)

    def test_project_register_shows_add_button_only_to_officials_and_admins(self):
        admin = User.objects.create_user(
            email='register-admin@example.com', username='register-admin',
            password='password123', role='admin',
        )
        engineer = User.objects.create_user(
            email='register-engineer@example.com', username='register-engineer',
            password='password123', role='engineer',
        )
        for user, can_add in (
            (self.officer, True),
            (admin, True),
            (self.citizen, False),
            (engineer, False),
        ):
            with self.subTest(role=user.role):
                self.client.force_login(user)
                response = self.client.get(reverse('project'))
                self.assertEqual(response.status_code, 200)
                if can_add:
                    self.assertContains(response, 'Add project')
                else:
                    self.assertNotContains(response, 'Add project')

    def test_project_creation_generates_ai_analyses_without_user_entered_ai_fields(self):
        self.client.force_login(self.officer)
        form_response = self.client.get(reverse('createproject'))
        self.assertEqual(form_response.status_code, 200)
        self.assertNotContains(form_response, 'AI &amp; Insights')
        self.assertNotContains(form_response, 'AI Summary')

        response = self.client.post(reverse('createproject'), {
            'project_title': 'Automated analysis test project',
            'project_description': 'Build a public water supply.',
            'project_location': 'Nakuru',
            'implementing_agency': 'Water Services',
            'beneficiaries': 'Residents',
            'stakeholders': 'Local community',
            'project_status': 'upcoming',
            'priority': 'medium',
            'ai_summary': 'User supplied summary must be ignored.',
            'ai_risk_score': '0',
            'ai_completion_estimate': '2027-01-01',
        })

        self.assertEqual(response.status_code, 302)
        project = Project.objects.get(project_title='Automated analysis test project')
        self.assertEqual(project.ai_analyses.count(), len(AIProjectAnalysis.ANALYSIS_TYPES))
        self.assertTrue(project.ai_summary)
        self.assertIsNotNone(project.ai_risk_score)
        self.assertNotEqual(project.ai_summary, 'User supplied summary must be ignored.')
        self.assertNotIn('ai_summary', ProjectCreationForm().fields)
        self.assertNotIn('ai_risk_score', ProjectCreationForm().fields)
        self.assertNotIn('ai_completion_estimate', ProjectCreationForm().fields)


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

    def test_draft_dashboard_renders_without_a_single_project_context(self):
        Project.objects.create(
            project_title='Draft Drainage Plan',
            project_status='draft',
        )
        self.client.force_login(self.user)

        response = self.client.get(reverse('draft'))

        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'statuses.html')
        self.assertContains(response, 'Draft Drainage Plan')
        self.assertNotContains(response, 'Track this project to the end')

    def test_delayed_project_detail_shows_live_delay_watch(self):
        ProgressUpdate.objects.create(
            project=self.p3,
            reported_by=self.user,
            description='Work is 36% complete.',
            progress_percentage=36,
        )
        self.client.force_login(self.user)

        response = self.client.get(reverse('project_details', args=[self.p3.pk]))

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'This project is delayed')
        self.assertContains(response, 'Live · updated')
        self.assertContains(
            response,
            f'href="{reverse("project_tracking", args=[self.p3.pk])}"',
        )
        self.assertEqual(response.context['live_progress'], 36)
        self.assertContains(response, '36%')
        self.assertContains(response, 'window.setInterval(refreshProjectStatus, 15000)')


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


class ProjectTrackingWorkflowTests(TestCase):
    def setUp(self):
        self.contractor_user = User.objects.create_user(
            email='tracker@example.com',
            username='tracker',
            password='password123',
            role='contractor',
            name='Tracker Representative',
            organization='TrackCo',
        )
        self.project = Project.objects.create(
            project_title='Bridge Repair',
            project_status='ongoing',
        )
        self.contractor = Contractor.objects.create(
            email=self.contractor_user.email,
            name=self.contractor_user.full_name,
            company='TrackCo',
        )
        self.contractor.projects.add(self.project)
        self.url = reverse('project_tracking', args=[self.project.pk])

    def test_assigned_contractor_can_post_status_progress_and_note(self):
        self.project.end_date = timezone.now().date() + timedelta(days=30)
        self.project.save(update_fields=['end_date'])
        self.client.force_login(self.contractor_user)
        response = self.client.post(self.url, {
            'new_status': 'delayed',
            'progress_percentage': '45',
            'note': 'Rain stopped the site work.',
        })

        self.assertRedirects(response, self.url)
        self.project.refresh_from_db()
        self.assertEqual(self.project.project_status, 'delayed')
        self.assertTrue(ProjectStatusHistory.objects.filter(
            project=self.project,
            to_status='delayed',
            changed_by=self.contractor_user,
            note='Rain stopped the site work.',
        ).exists())
        self.assertTrue(ProgressUpdate.objects.filter(
            project=self.project,
            reported_by=self.contractor_user,
            progress_percentage=45,
            description='Rain stopped the site work.',
        ).exists())
        feed_response = self.client.get(self.url, {'format': 'json'})
        self.assertEqual(feed_response.json()['overall_progress'], 45)

    def test_non_assigned_users_cannot_post_tracking_updates(self):
        officer = User.objects.create_user(
            email='tracking-officer@example.com',
            username='tracking-officer',
            password='password123',
            role='official',
        )
        unrelated_contractor = User.objects.create_user(
            email='unrelated-tracker@example.com',
            username='unrelated-tracker',
            password='password123',
            role='contractor',
        )
        for user in (officer, unrelated_contractor):
            with self.subTest(role=user.role, email=user.email):
                self.client.force_login(user)
                response = self.client.post(self.url, {
                    'new_status': 'delayed',
                    'progress_percentage': '45',
                    'note': 'Unauthorized update.',
                })
                self.assertEqual(response.status_code, 403)
        self.project.refresh_from_db()
        self.assertEqual(self.project.project_status, 'ongoing')
        self.assertFalse(ProgressUpdate.objects.filter(project=self.project).exists())
        self.assertFalse(ProjectStatusHistory.objects.filter(project=self.project).exists())

    def test_invalid_progress_is_rejected_and_delayed_project_can_recover(self):
        self.project.project_status = 'delayed'
        self.project.save(update_fields=['project_status'])
        self.client.force_login(self.contractor_user)
        invalid_progress = self.client.post(self.url, {
            'progress_percentage': '101',
        })
        backward_status = self.client.post(self.url, {
            'new_status': 'ongoing',
        })

        self.assertRedirects(invalid_progress, self.url)
        self.assertRedirects(backward_status, self.url)
        self.project.refresh_from_db()
        self.assertEqual(self.project.project_status, 'ongoing')
        self.assertFalse(ProgressUpdate.objects.filter(project=self.project).exists())
        self.assertTrue(ProjectStatusHistory.objects.filter(
            project=self.project,
            from_status='delayed',
            to_status='ongoing',
            changed_by=self.contractor_user,
        ).exists())

    def test_terminal_project_cannot_be_updated_by_assigned_contractor(self):
        self.project.project_status = 'completed'
        self.project.save(update_fields=['project_status'])
        self.client.force_login(self.contractor_user)

        response = self.client.post(self.url, {
            'progress_percentage': '100',
            'note': 'Trying to update a closed project.',
        })

        self.assertEqual(response.status_code, 403)
        self.assertFalse(ProgressUpdate.objects.filter(project=self.project).exists())

    def test_tracking_json_feed_includes_current_status_and_timeline(self):
        history = ProjectStatusHistory.objects.create(
            project=self.project,
            from_status='upcoming',
            to_status='ongoing',
            source='assignee',
            note='Work started.',
            changed_by=self.contractor_user,
        )
        ProgressUpdate.objects.create(
            project=self.project,
            reported_by=self.contractor_user,
            description='Foundation is 30% complete.',
            progress_percentage=30,
        )
        self.client.force_login(self.contractor_user)

        page_response = self.client.get(self.url)
        response = self.client.get(self.url, {'format': 'json'})

        self.assertEqual(page_response.status_code, 200)
        self.assertContains(page_response, 'Work started.')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response['Cache-Control'], 'no-store')
        payload = response.json()
        self.assertEqual(payload['status'], 'ongoing')
        self.assertEqual(payload['status_label'], 'Ongoing')
        self.assertEqual(payload['overall_progress'], 30)
        self.assertEqual(len(payload['events']), 2)
        status_event = next(event for event in payload['events'] if event['type'] == 'status')
        self.assertEqual(status_event['note'], history.note)
        self.assertTrue(any(
            event['text'] == 'Foundation is 30% complete.'
            for event in payload['events']
        ))

        summary_response = self.client.get(
            self.url,
            {'format': 'json', 'summary': '1'},
        )
        self.assertEqual(summary_response.status_code, 200)
        self.assertEqual(summary_response['Cache-Control'], 'no-store')
        self.assertEqual(summary_response.json(), {
            'status': 'ongoing',
            'status_label': 'Ongoing',
            'overall_progress': 30,
        })


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

    def test_officer_can_rate_contractor_and_review_matching_tender_application(self):
        tender = Tender.objects.create(
            project=self.project,
            title='Clinic Construction Tender',
            status='evaluating',
        )
        TenderApplication.objects.create(
            tender=tender,
            applicant=self.contractor_user,
            company_name='BuildCo',
            company_email=self.contractor_user.email,
            bid_amount='450000.00',
        )
        officer = User.objects.create_user(
            email='rating-officer@example.com',
            username='rating-officer',
            password='password123',
            role='official',
        )
        self.client.force_login(officer)

        detail_url = reverse('contractor_detail', args=[self.contractor.pk])
        detail_response = self.client.get(detail_url)
        rating_response = self.client.post(detail_url, {
            'action': 'save_rating',
            'project': self.project.pk,
            'quality_score': '92',
            'speed_score': '85',
            'compliance_score': '96',
            'comment': 'Strong delivery.',
        })

        self.assertEqual(detail_response.status_code, 200)
        self.assertContains(detail_response, 'Add or update a project performance rating')
        self.assertContains(detail_response, 'Tender applications to review')
        self.assertContains(
            detail_response,
            f'href="{reverse("tender_detail", args=[tender.pk])}"',
        )
        self.assertRedirects(rating_response, detail_url)
        rating = ContractorRating.objects.get(
            contractor=self.contractor,
            project=self.project,
            rated_by=officer,
        )
        self.assertEqual(rating.quality_score, 92)
        self.assertEqual(rating.speed_score, 85)
        self.assertEqual(rating.compliance_score, 96)

        self.client.post(detail_url, {
            'action': 'save_rating',
            'project': self.project.pk,
            'quality_score': '80',
            'speed_score': '80',
            'compliance_score': '80',
            'comment': 'Updated assessment.',
        })
        self.assertEqual(
            ContractorRating.objects.filter(
                contractor=self.contractor,
                project=self.project,
                rated_by=officer,
            ).count(),
            1,
        )

    def test_contractor_can_upload_compliance_document_from_own_detail(self):
        self.client.force_login(self.contractor_user)
        detail_url = reverse('contractor_detail', args=[self.contractor.pk])
        detail_response = self.client.get(detail_url)

        self.assertEqual(detail_response.status_code, 200)
        self.assertContains(detail_response, 'Upload compliance document')
        upload_url = reverse('contractor_document_upload')
        self.assertContains(
            detail_response,
            f'{upload_url}?contractor={self.contractor.pk}&next={detail_url}',
        )
        response = self.client.post(
            upload_url,
            {
                'doc_type': 'registration',
                'contractor': self.contractor.pk,
                'next': detail_url,
                'file': SimpleUploadedFile(
                    'registration.pdf',
                    b'%PDF-1.4 registration',
                    content_type='application/pdf',
                ),
            },
        )

        self.assertRedirects(response, detail_url)
        self.assertTrue(ContractorDocument.objects.filter(
            contractor=self.contractor,
            doc_type='registration',
        ).exists())

    def test_contractor_cannot_rate_contractor_or_upload_for_another_profile(self):
        another_contractor = Contractor.objects.create(
            company='Other BuildCo',
            email='other-buildco@example.com',
        )
        another_contractor.projects.add(self.project)
        self.client.force_login(self.contractor_user)

        rate_response = self.client.post(
            reverse('contractor_detail', args=[self.contractor.pk]),
            {
                'action': 'save_rating',
                'project': self.project.pk,
                'quality_score': '100',
                'speed_score': '100',
                'compliance_score': '100',
            },
        )
        other_profile_response = self.client.get(
            reverse('contractor_detail', args=[another_contractor.pk])
        )

        self.assertEqual(rate_response.status_code, 403)
        self.assertEqual(other_profile_response.status_code, 200)
        self.assertNotContains(other_profile_response, 'Upload compliance document')
        self.assertFalse(ContractorRating.objects.filter(
            contractor=self.contractor,
            rated_by=self.contractor_user,
        ).exists())

    def test_assigned_contractor_can_manage_milestone(self):
        milestone = Milestone.objects.create(
            project=self.project,
            title='Foundation inspection',
            description='Complete the foundation.',
        )
        self.client.force_login(self.contractor_user)

        detail_response = self.client.get(
            reverse('milestone_detail', args=[milestone.pk])
        )
        list_response = self.client.get(reverse('milestone_list'))
        update_response = self.client.get(
            reverse('milestone_update', args=[milestone.pk])
        )
        delete_response = self.client.get(
            reverse('milestone_delete', args=[milestone.pk])
        )

        self.assertEqual(detail_response.status_code, 200)
        self.assertContains(detail_response, 'Edit Milestone')
        self.assertContains(detail_response, 'Delete')
        self.assertContains(list_response, 'Edit Full Milestone')
        self.assertContains(list_response, 'title="Delete"')
        self.assertEqual(update_response.status_code, 200)
        self.assertEqual(delete_response.status_code, 200)
        self.assertTemplateUsed(delete_response, 'milestone_confirm_delete.html')
        delete_response = self.client.post(
            reverse('milestone_delete', args=[milestone.pk])
        )
        self.assertEqual(delete_response.status_code, 302)
        self.assertFalse(Milestone.objects.filter(pk=milestone.pk).exists())

    def test_non_contractor_cannot_edit_or_delete_milestone(self):
        milestone = Milestone.objects.create(
            project=self.project,
            title='Foundation inspection',
            description='Complete the foundation.',
        )
        officer = User.objects.create_user(
            email='milestone-officer@example.com',
            username='milestone-officer',
            password='password123',
            role='official',
        )
        self.client.force_login(officer)

        detail_response = self.client.get(
            reverse('milestone_detail', args=[milestone.pk])
        )
        list_response = self.client.get(reverse('milestone_list'))
        update_get = self.client.get(
            reverse('milestone_update', args=[milestone.pk])
        )
        update_post = self.client.post(
            reverse('milestone_update', args=[milestone.pk]),
            {'title': 'Officer changed title'},
        )
        delete_get = self.client.get(
            reverse('milestone_delete', args=[milestone.pk])
        )
        delete_post = self.client.post(
            reverse('milestone_delete', args=[milestone.pk])
        )
        quick_update = self.client.post(
            reverse('milestone_quick_update', args=[milestone.pk]),
            {'progress_percentage': '100', 'status': 'completed'},
        )
        submit_verification = self.client.post(
            reverse('submit_milestone_verification', args=[milestone.pk]),
        )

        self.assertEqual(detail_response.status_code, 200)
        self.assertNotContains(detail_response, 'Edit Milestone')
        self.assertNotContains(
            detail_response,
            reverse('milestone_delete', args=[milestone.pk]),
        )
        self.assertNotContains(list_response, 'Edit Full Milestone')
        self.assertNotContains(list_response, 'title="Delete"')
        self.assertEqual(update_get.status_code, 403)
        self.assertEqual(update_post.status_code, 403)
        self.assertEqual(delete_get.status_code, 403)
        self.assertEqual(delete_post.status_code, 403)
        self.assertEqual(quick_update.status_code, 403)
        self.assertEqual(submit_verification.status_code, 403)
        self.assertTrue(Milestone.objects.filter(pk=milestone.pk).exists())
        milestone.refresh_from_db()
        self.assertEqual(milestone.title, 'Foundation inspection')

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
        edit_response = self.client.get(
            reverse('milestone_update', args=[milestone.pk])
        )
        delete_response = self.client.post(
            reverse('milestone_delete', args=[milestone.pk])
        )
        submit_response = self.client.post(
            reverse('submit_milestone_verification', args=[milestone.pk]),
        )

        self.assertEqual(update_response.status_code, 403)
        self.assertEqual(edit_response.status_code, 403)
        self.assertEqual(delete_response.status_code, 403)
        self.assertEqual(submit_response.status_code, 403)
        self.assertTrue(Milestone.objects.filter(pk=milestone.pk).exists())
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


class CitizenEvidenceAgreementTest(TestCase):
    """Endless communication between evidence provider and official until
    mutual agreement is met."""

    def setUp(self):
        self.citizen = User.objects.create_user(email='c@example.com', username='citizen', password='pass12345')
        self.official = User.objects.create_user(email='o@example.com', username='official', password='pass12345', role='official')
        self.project = Project.objects.create(
            project_title='Water Project',
            project_description='Borehole',
            project_location='Kisumu',
            project_status='ongoing',
        )
        self.stage = self.project.stages.create(stage_name='drilling', description='Borehole drilling', order=1)
        self.evidence = CitizenEvidence.objects.create(
            user=self.citizen,
            project=self.project,
            stage=self.stage,
            category='water',
            severity='high',
            evidence_type='document',
            title='Broken borehole pump',
            description='The pump has not worked for two weeks.',
            location='Village A',
        )

    def _detail_url(self):
        return reverse('citizen_evidence_detail', args=[self.evidence.pk])

    def test_official_reply_moves_pending_to_under_discussion(self):
        self.client.force_login(self.official)
        r = self.client.post(self._detail_url(), {'action': 'respond', 'response_message': 'Inspection scheduled.'})
        self.assertEqual(r.status_code, 302)
        self.evidence.refresh_from_db()
        self.assertEqual(self.evidence.status, 'under_discussion')
        self.assertEqual(self.evidence.responses.count(), 1)
        # Citizen got notified.
        self.assertTrue(Notification.objects.filter(user=self.citizen, title='New response on your evidence report').exists())

    def test_citizen_can_reply_after_rejection_reopening_discussion(self):
        self.evidence.reject(self.official, 'Photo unclear.')
        self.client.force_login(self.citizen)
        r = self.client.post(self._detail_url(), {'action': 'respond', 'response_message': 'Here are clearer photos.'})
        self.assertEqual(r.status_code, 302)
        self.evidence.refresh_from_db()
        self.assertEqual(self.evidence.status, 'under_discussion')
        self.assertIsNone(self.evidence.verified_by)
        self.assertEqual(self.evidence.responses.count(), 1)

    def test_agreement_requires_both_parties(self):
        self.client.force_login(self.citizen)
        self.client.post(self._detail_url(), {'action': 'agree'})
        self.evidence.refresh_from_db()
        self.assertTrue(self.evidence.citizen_agreed)
        self.assertFalse(self.evidence.official_agreed)
        self.assertEqual(self.evidence.status, 'pending')  # not closed yet

        self.client.logout()
        self.client.force_login(self.official)
        self.client.post(self._detail_url(), {'action': 'agree'})
        self.evidence.refresh_from_db()
        self.assertTrue(self.evidence.is_agreed)
        self.assertEqual(self.evidence.status, 'agreed')

    def test_no_messaging_after_agreement(self):
        self.evidence.set_party_agreement('citizen', True)
        self.evidence.set_party_agreement('official', True)
        self.client.force_login(self.citizen)
        r = self.client.post(self._detail_url(), {'action': 'respond', 'response_message': 'One more thing.'})
        self.assertEqual(r.status_code, 200)
        self.assertContains(r, 'Agreement was reached on this evidence, so the conversation is closed.')
        self.evidence.refresh_from_db()
        self.assertEqual(self.evidence.responses.count(), 0)  # message blocked

    def test_withdraw_agreement_reopens(self):
        self.evidence.set_party_agreement('citizen', True)
        self.evidence.set_party_agreement('official', True)
        self.client.force_login(self.citizen)
        self.client.post(self._detail_url(), {'action': 'withdraw_agreement'})
        self.evidence.refresh_from_db()
        self.assertFalse(self.evidence.citizen_agreed)
        self.assertEqual(self.evidence.status, 'under_discussion')

    def test_official_cannot_reject_after_agreement(self):
        self.evidence.set_party_agreement('citizen', True)
        self.evidence.set_party_agreement('official', True)
        self.client.force_login(self.official)
        r = self.client.post(reverse('verify_evidence', args=[self.evidence.pk]), {'action': 'reject', 'review_notes': 'no'})
        self.assertEqual(r.status_code, 302)
        self.evidence.refresh_from_db()
        self.assertEqual(self.evidence.status, 'agreed')  # unchanged
