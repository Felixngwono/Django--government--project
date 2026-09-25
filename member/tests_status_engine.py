"""Tests for the automatic project status transition engine."""

from datetime import timedelta

from django.test import TestCase
from django.utils import timezone

from member.models import Milestone, ProgressUpdate, Project, ProjectStage, User
from member.workflow import apply_status_change, compute_status, refresh_project_status


def make_project(**overrides):
    defaults = dict(
        project_title="Test Road",
        project_status="draft",
        start_date=timezone.now().date(),
    )
    defaults.update(overrides)
    return Project.objects.create(**defaults)


class ComputeStatusTests(TestCase):
    def test_progress_100_marks_completed(self):
        p = make_project(project_status="ongoing")
        ProgressUpdate.objects.create(project=p, description="done", progress_percentage=100)
        p = Project.objects.get(pk=p.pk)
        self.assertEqual(p.project_status, "completed")
        self.assertIsNotNone(p.actual_end_date)

    def test_construction_stage_means_ongoing(self):
        p = make_project(project_status="upcoming")
        ProjectStage.objects.create(project=p, stage_name="construction", progress_percentage=0)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "ongoing")

    def test_planning_stage_keeps_upcoming(self):
        p = make_project(project_status="upcoming")
        ProjectStage.objects.create(project=p, stage_name="planning", progress_percentage=0)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "upcoming")

    def test_milestone_100_completes_project(self):
        p = make_project(project_status="ongoing")
        Milestone.objects.create(project=p, title="M1", description="d", progress_percentage=100)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "completed")

    def test_overdue_beyond_grace_marks_delayed(self):
        p = make_project(
            project_status="ongoing",
            end_date=timezone.now().date() - timedelta(days=30),
        )
        refresh_project_status(p)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "delayed")

    def test_overdue_within_grace_not_delayed(self):
        p = make_project(
            project_status="ongoing",
            end_date=timezone.now().date() - timedelta(days=3),
        )
        refresh_project_status(p)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "ongoing")

    def test_suspended_and_stalled_are_preserved(self):
        for status in ("suspended", "stalled"):
            with self.subTest(status=status):
                p = make_project(project_status=status)
                ProjectStage.objects.create(project=p, stage_name="construction", progress_percentage=0)
                p.refresh_from_db()
                self.assertEqual(p.project_status, status)

    def test_manual_completed_is_terminal(self):
        p = make_project(project_status="completed")
        # new progress below 100 must NOT downgrade
        ProgressUpdate.objects.create(project=p, description="misc", progress_percentage=10)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "completed")


class ApplyStatusChangeTests(TestCase):
    def test_records_actual_end_date_and_remark(self):
        p = make_project(project_status="ongoing")
        apply_status_change(p, "completed", source="manual")
        p.refresh_from_db()
        self.assertIsNotNone(p.actual_end_date)
        # manual changes should not append the [Auto] remark
        self.assertNotIn("[Auto]", p.remarks or "")

    def test_auto_change_writes_remark(self):
        p = make_project(project_status="upcoming")
        apply_status_change(p, "delayed", source="auto")
        p.refresh_from_db()
        self.assertIn("[Auto]", p.remarks)

    def test_unpausing_clears_actual_end_date(self):
        p = make_project(project_status="completed")
        apply_status_change(p, "ongoing", source="manual")
        p.refresh_from_db()
        self.assertIsNone(p.actual_end_date)

    def test_no_change_returns_false(self):
        p = make_project(project_status="ongoing")
        self.assertFalse(apply_status_change(p, "ongoing", source="manual"))

    def test_refresh_returns_status(self):
        p = make_project(project_status="upcoming")
        self.assertEqual(refresh_project_status(p, source="manual"), p.project_status)


class SweepTests(TestCase):
    """The time-driven sweep (member.status_sweep) used by the command and middleware."""

    def _sweep(self, dry_run=False):
        from member.status_sweep import sweep_project_statuses
        return sweep_project_statuses(dry_run=dry_run)

    def test_start_date_passed_moves_upcoming_to_ongoing(self):
        p = make_project(
            project_status="upcoming",
            start_date=timezone.now().date() - timedelta(days=10),
        )
        changed, transitions = self._sweep()
        p.refresh_from_db()
        self.assertEqual(p.project_status, "ongoing")
        self.assertEqual(changed, 1)
        self.assertIn("upcoming -> ongoing", transitions[0])

    def test_end_date_passed_moves_ongoing_to_delayed(self):
        p = make_project(
            project_status="ongoing",
            end_date=timezone.now().date() - timedelta(days=30),
        )
        changed, transitions = self._sweep()
        p.refresh_from_db()
        self.assertEqual(p.project_status, "delayed")
        self.assertEqual(changed, 1)
        self.assertIn("delayed", transitions[0])

    def test_delayed_recovers_when_end_date_corrected(self):
        p = make_project(
            project_status="delayed",
            end_date=timezone.now().date() + timedelta(days=30),
        )
        changed, _transitions = self._sweep()
        p.refresh_from_db()
        self.assertEqual(p.project_status, "ongoing")
        self.assertEqual(changed, 1)

    def test_dry_run_reports_without_saving(self):
        make_project(
            project_status="ongoing",
            end_date=timezone.now().date() - timedelta(days=30),
        )
        changed, _transitions = self._sweep(dry_run=True)
        self.assertEqual(changed, 1)
        self.assertEqual(Project.objects.filter(project_status="delayed").count(), 0)
        # A real sweep then applies it exactly once.
        changed, _transitions = self._sweep()
        self.assertEqual(changed, 1)
        self.assertEqual(Project.objects.filter(project_status="delayed").count(), 1)
        # And a second sweep is a no-op (idempotent).
        changed, _transitions = self._sweep()
        self.assertEqual(changed, 0)

    def test_terminal_projects_untouched(self):
        make_project(project_status="completed", end_date=timezone.now().date() - timedelta(days=400))
        make_project(project_status="cancelled")
        changed, _transitions = self._sweep()
        self.assertEqual(changed, 0)

    def test_suspended_projects_untouched(self):
        make_project(
            project_status="suspended",
            end_date=timezone.now().date() - timedelta(days=60),
        )
        changed, _transitions = self._sweep()
        self.assertEqual(changed, 0)

    def test_command_runs_sweep(self):
        from django.core.management import call_command
        from io import StringIO

        make_project(
            project_status="ongoing",
            end_date=timezone.now().date() - timedelta(days=30),
        )
        out = StringIO()
        call_command("update_project_statuses", stdout=out)
        self.assertIn("1 project(s) updated", out.getvalue())
        self.assertEqual(Project.objects.filter(project_status="delayed").count(), 1)


class StageMilestoneRollupTests(TestCase):
    """Milestones drive their stage; stages drive the project (member/signals)."""

    def test_completing_milestones_completes_stage(self):
        p = make_project(project_status="ongoing")
        stage = ProjectStage.objects.create(project=p, stage_name="foundation", progress_percentage=0)
        m1 = Milestone.objects.create(project=p, stage=stage, title="Land preparation", description="d", progress_percentage=100)
        m2 = Milestone.objects.create(project=p, stage=stage, title="Excavation", description="d", progress_percentage=100)
        stage.refresh_from_db()
        self.assertEqual(stage.status, "completed")
        self.assertEqual(stage.progress_percentage, 100)
        self.assertIsNotNone(stage.completed_on)
        # Milestones must have kept themselves consistent too.
        self.assertEqual(m1.status, "completed")
        self.assertIsNotNone(m1.completion_date)

    def test_partial_milestones_keep_stage_in_progress(self):
        p = make_project(project_status="ongoing")
        stage = ProjectStage.objects.create(project=p, stage_name="site_clearance", progress_percentage=0)
        Milestone.objects.create(project=p, stage=stage, title="Survey", description="d", progress_percentage=50)
        stage.refresh_from_db()
        self.assertEqual(stage.status, "in_progress")
        self.assertEqual(int(stage.progress_percentage), 50)
        self.assertIsNone(stage.completed_on)

    def test_completed_stage_marks_project_completed(self):
        p = make_project(project_status="ongoing")
        stage = ProjectStage.objects.create(project=p, stage_name="handover", progress_percentage=100, status="completed")
        refresh_project_status(p)
        p.refresh_from_db()
        self.assertEqual(p.project_status, "completed")

    def test_deleting_a_completed_milestone_reopens_stage(self):
        p = make_project(project_status="ongoing")
        stage = ProjectStage.objects.create(project=p, stage_name="foundation", progress_percentage=100, status="completed")
        m = Milestone.objects.create(project=p, stage=stage, title="Only task", description="d", progress_percentage=100)
        stage.refresh_from_db()
        self.assertEqual(stage.status, "completed")
        m.delete()
        stage.refresh_from_db()
        # No milestones left → stage keeps its stored values but loses completion signal.
        self.assertEqual(stage.milestones.count(), 0)


class DeadlineAlertTests(TestCase):
    """member.deadline_alerts: due ≤2 days / overdue → notification pointing to the project."""

    @classmethod
    def setUpTestData(cls):
        cls.owner = User.objects.create_user(username='powner', password='x', role='manager')

    def _project(self, **overrides):
        overrides.setdefault('created_by', self.owner)
        return make_project(**overrides)

    def _run(self):
        from member.deadline_alerts import create_deadline_alerts
        return create_deadline_alerts()

    def test_due_in_two_days_creates_deadline_notification(self):
        from datetime import timedelta
        p = self._project(
            project_status="ongoing",
            end_date=timezone.now().date() + timedelta(days=2),
        )
        created = self._run()
        self.assertEqual(created, 1)
        n = Notification.objects.get(notification_type="deadline")
        self.assertIn(p.project_title, n.title)
        self.assertIn(str(p.pk), n.link)
        self.assertEqual(n.user_id, p.created_by_id)

    def test_overdue_creates_overdue_notification(self):
        from datetime import timedelta
        p = self._project(
            project_status="ongoing",
            end_date=timezone.now().date() - timedelta(days=5),
        )
        created = self._run()
        self.assertEqual(created, 1)
        n = Notification.objects.get(notification_type="deadline")
        self.assertIn("overdue", n.message.lower())
        self.assertIn(str(p.pk), n.link)

    def test_no_duplicates_same_day(self):
        from datetime import timedelta
        self._project(
            project_status="ongoing",
            end_date=timezone.now().date() + timedelta(days=1),
        )
        self.assertEqual(self._run(), 1)
        self.assertEqual(self._run(), 0)

    def test_far_future_and_terminal_projects_not_alerted(self):
        from datetime import timedelta
        self._project(project_status="ongoing", end_date=timezone.now().date() + timedelta(days=90))
        self._project(project_status="completed", end_date=timezone.now().date() - timedelta(days=3))
        self.assertEqual(self._run(), 0)
