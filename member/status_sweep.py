"""Shared project-status sweep used by the management command and the middleware.

The sweep recomputes every non-terminal project's status from its timeline,
stages, progress reports and milestones (see member.workflow.compute_status),
so deadline-based statuses move with time even when nobody saves a progress record:

    upcoming -> ongoing      (awarded/assigned contractor has started work)
    ongoing  -> delayed      (end_date passed beyond the grace period)
    *        -> completed    (all milestones, or all stages when no milestones exist)

Terminal statuses (completed/cancelled) and suspensions are never overwritten automatically.
"""

from .models import Project
from .workflow import apply_status_change, compute_status

TERMINAL_STATUSES = ("completed", "cancelled")
def sweep_project_statuses(dry_run=False, stdout=None):
    """Recompute statuses for all non-terminal projects.

    Returns (changed_count, transitions) where transitions is a list of
    "(ref) old -> new" strings (useful for dry-run reporting and logging).
    """
    transitions = []

    candidates = Project.objects.exclude(project_status__in=TERMINAL_STATUSES).select_related("district")

    # Pass 1 — full engine recompute (tenders, stages, progress, milestones, dates).
    for project in candidates:
        old_status = project.project_status
        new_status = compute_status(project)
        if new_status == old_status:
            continue
        label = str(project.reference_code or project.pk)
        if not dry_run:
            apply_status_change(project, new_status, source="auto")
        transitions.append(f"{label}: {old_status} -> {new_status}")

    if stdout is not None:
        for line in transitions:
            stdout.write(line)

    return len(transitions), transitions
