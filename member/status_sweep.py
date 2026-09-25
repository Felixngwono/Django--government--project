"""Shared project-status sweep used by the management command and the middleware.

The sweep recomputes every non-terminal project's status from its timeline,
stages, progress reports and milestones (see member.workflow.compute_status),
so statuses move with time even when nobody saves a progress record:

    upcoming -> ongoing      (start_date reached, or stage/progress activity)
    ongoing  -> delayed      (end_date passed beyond the grace period)
    *        -> completed    (a 100% progress report / milestone exists)

Terminal statuses (completed/cancelled) and deliberate pauses
(suspended/stalled) are never overwritten automatically.
"""

from django.utils import timezone

from .models import Project
from .workflow import DELAY_GRACE_DAYS, apply_status_change, compute_status

TERMINAL_STATUSES = ("completed", "cancelled")
ACTIVE_STATUSES = ("ongoing", "upcoming", "draft")


def sweep_project_statuses(dry_run=False, stdout=None):
    """Recompute statuses for all non-terminal projects.

    Returns (changed_count, transitions) where transitions is a list of
    "(ref) old -> new" strings (useful for dry-run reporting and logging).
    """
    today = timezone.now().date()
    transitions = []
    changed_ids = set()

    candidates = Project.objects.exclude(project_status__in=TERMINAL_STATUSES).select_related("district")

    # Pass 1 — full engine recompute (stages, progress, milestones, dates).
    for project in candidates:
        old_status = project.project_status
        new_status = compute_status(project)
        if new_status == old_status:
            continue
        label = str(project.reference_code or project.pk)
        if not dry_run:
            apply_status_change(project, new_status, source="auto")
        transitions.append(f"{label}: {old_status} -> {new_status}")
        changed_ids.add(project.pk)

    # Pass 2 — force delayed any still-active project past end_date + grace.
    # Needed because the engine keeps stage-driven projects "ongoing" (e.g. an
    # active construction stage) even when the deadline has blown past.
    overdue = [
        p for p in candidates
        if p.pk not in changed_ids
        and p.end_date
        and p.project_status in ACTIVE_STATUSES
        and (today - p.end_date).days > DELAY_GRACE_DAYS
    ]
    for project in overdue:
        old_status = project.project_status
        label = str(project.reference_code or project.pk)
        if not dry_run:
            apply_status_change(project, "delayed", source="auto")
        transitions.append(f"{label}: {old_status} -> delayed (overdue)")

    if stdout is not None:
        for line in transitions:
            stdout.write(line)

    return len(transitions), transitions
