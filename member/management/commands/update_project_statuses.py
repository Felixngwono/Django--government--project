"""Run date-driven project status transitions.

Projects whose end_date has passed (beyond the grace period) move to
'delayed'; projects already delayed whose end date was corrected to the
future move back to 'ongoing'; projects whose start date has arrived move
from 'upcoming' to 'ongoing'. Completed/cancelled projects are never touched.

Usage:
    python manage.py update_project_statuses            # apply changes
    python manage.py update_project_statuses --dry-run  # preview only

The same sweep runs automatically once per day via
ProjectStatusSyncMiddleware (member.middleware), so this command is mainly
for cron jobs, CI, or forcing an immediate recompute.
"""

from django.core.management.base import BaseCommand

from member.status_sweep import sweep_project_statuses
from member.deadline_alerts import create_deadline_alerts


class Command(BaseCommand):
    help = "Recompute project statuses from timeline/progress data."

    def add_arguments(self, parser):
        parser.add_argument("--dry-run", action="store_true", help="Show what would change without saving.")

    def handle(self, *args, **options):
        dry_run = options["dry_run"]
        changed, _transitions = sweep_project_statuses(dry_run=dry_run, stdout=self.stdout)
        alerts = 0 if dry_run else create_deadline_alerts()
        if dry_run:
            self.stdout.write(self.style.WARNING(f"{changed} project(s) would be updated (dry run, nothing saved)."))
        else:
            self.stdout.write(self.style.SUCCESS(f"{changed} project(s) updated."))
            self.stdout.write(self.style.SUCCESS(f"{alerts} deadline notification(s) created."))
