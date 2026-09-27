"""Shared workflow helpers for permissions, notifications, and audit history."""

from functools import wraps

from django.contrib import messages
from django.http import HttpResponseForbidden

from .models import AuditLog, Notification


OFFICER_ROLES = {"official", "admin", "auditor", "manager", "staff"}
# Only these roles may award a tender to a contractor.
TENDER_AWARD_ROLES = {"official", "admin"}
PROJECT_ROLES = OFFICER_ROLES | {"engineer", "architect", "surveyor", "planner"}


def has_role(user, roles):
    return user.is_authenticated and (user.is_superuser or user.role in roles)


def assigned_projects(user):
    """Queryset of projects this user is assigned to work on (participant,
    project manager name match, or assigned contractor). Officers see all."""
    from django.db.models import Q
    from .models import Contractor, Participation, Project
    if not user.is_authenticated:
        return Project.objects.none()
    if user.is_superuser or getattr(user, 'role', '') in OFFICER_ROLES:
        return Project.objects.all()
    contractor = Contractor.objects.filter(
        Q(email__iexact=user.email or '__none__') |
        Q(company__iexact=user.organization or '__none__') |
        Q(name__iexact=user.organization or '__none__')
    ).first()
    q = Q(participation__user=user, participation__is_active=True)
    if user.full_name:
        q |= Q(project_manager__iexact=user.full_name.strip())
    if contractor:
        q |= Q(contractors=contractor)
    return Project.objects.filter(q).distinct()


def user_assigned_to_project(user, project):
    """True only if this user is the one working on the given project:
    listed project manager, the project's assigned contractor (by company
    name/email match), or an active participant. Superusers/officers are
    always allowed."""
    if not user.is_authenticated or project is None:
        return False
    if user.is_superuser or getattr(user, 'role', '') in OFFICER_ROLES:
        return True
    from .models import Contractor, Participation, Project
    # Project manager assignment (by name match)
    if project.project_manager and user.full_name and \
            user.full_name.strip().lower() == str(project.project_manager).strip().lower():
        return True
    # Contractor assigned to this project
    contractor = Contractor.objects.filter(projects=project).first()
    if contractor:
        email = (user.email or '').strip().lower()
        if email and contractor.email and contractor.email.strip().lower() == email:
            return True
        company_or_name = (contractor.company or contractor.name or '').strip().lower()
        if company_or_name and user.organization and \
                user.organization.strip().lower() == company_or_name:
            return True
    # Active participant on this exact project
    if Participation.objects.filter(user=user, project=project, is_active=True).exists():
        return True
    return False


def role_required(*roles):
    """Require a platform role in addition to Django authentication."""
    def decorator(view):
        @wraps(view)
        def wrapped(request, *args, **kwargs):
            if not has_role(request.user, set(roles)):
                messages.error(request, "You do not have permission to perform that action.")
                return HttpResponseForbidden("You do not have permission to perform this action.")
            return view(request, *args, **kwargs)
        return wrapped
    return decorator


def notify(user, notification_type, title, message, link=""):
    if user:
        return Notification.objects.create(
            user=user,
            notification_type=notification_type,
            title=title,
            message=message,
            link=link,
        )


def audit(request, action, obj, project=None, changes=None):
    """Record server-side workflow actions in the immutable audit history."""
    if not request.user.is_authenticated:
        return
    AuditLog.objects.create(
        user=request.user,
        action=action,
        model_name=obj.__class__.__name__,
        object_id=obj.pk,
        project=project,
        changes=changes or {},
        ip_address=request.META.get("REMOTE_ADDR"),
    )


# ─────────────────────────────────────────────
# PROJECT STATUS TRANSITION ENGINE
# Derives project status automatically from real signals:
# stages, progress updates, milestones, and timeline dates.
# ─────────────────────────────────────────────

from datetime import date

from django.db.models import Max
from django.utils import timezone

from .models import Project, ProjectStage

# Manual states that must never be overwritten automatically.
TERMINAL_STATUSES = {"completed", "cancelled"}

# Statuses that mean "work is paused" — the engine won't move them forward
# on progress alone, but a completion signal still wins.
PAUSED_STATUSES = {"suspended", "stalled"}

# Ordered workflow: a project whose latest stage is X is treated as at least Y.
STAGE_TO_STATUS = {
    "planning": "upcoming",
    "procurement": "upcoming",
    "site_clearance": "ongoing",
    "foundation": "ongoing",
    "superstructure": "ongoing",
    "finishing": "ongoing",
    "inspection": "ongoing",
    "construction": "ongoing",
    "completion": "ongoing",
    "monitoring": "ongoing",
    "handover": "ongoing",
}

# Grace period after end_date before an active project counts as delayed.
DELAY_GRACE_DAYS = 14


def compute_status(project):
    """Return the status the project should currently be in, based on its data.

    Priority (highest first):
      1. Progress/milestone completion  → 'completed'
      2. Manual paused states           → kept (suspended/stalled)
      3. Stage + progress activity      → 'ongoing'
      4. Overdue end_date               → 'delayed'
      5. No activity yet                → 'upcoming' (or 'draft' if it never had one)
    """
    today = timezone.now().date()

    # 1 — anything reported as 100% complete is completed.
    progress_updates = list(project.progress_updates.values_list("progress_percentage", flat=True))
    milestones = list(project.milestones.values_list("progress_percentage", flat=True))
    stages = ProjectStage.objects.filter(project=project)
    all_signals = [p for p in progress_updates + milestones if p is not None]
    milestones_complete = bool(milestones) and all(p >= 100 for p in milestones)
    stages_complete = stages.exists() and not stages.exclude(status="completed").exists()
    if (progress_updates and max(progress_updates) >= 100) or milestones_complete or stages_complete:
        return "completed"

    # 2 — respect deliberate pauses.
    if project.project_status in PAUSED_STATUSES:
        return project.project_status

    # 3 — real work signals: the furthest stage tells us where the project is.
    latest_stage = (
        ProjectStage.objects.filter(project=project)
        .exclude(status="not_started")
        .exclude(stage_name="others")
        .order_by("-order", "-id")
        .values_list("stage_name", flat=True)
        .first()
    )
    stage_implied = STAGE_TO_STATUS.get(latest_stage)
    if stage_implied:
        return stage_implied

    reported = max(all_signals) if all_signals else None
    if reported and reported > 0:
        return "ongoing"

    # 4 — timeline: overdue but not yet flagged.
    if project.is_overdue and (today - project.end_date).days > DELAY_GRACE_DAYS:
        return "delayed"

    # 5 — nothing happening yet.
    if project.project_status == "draft":
        return "draft"
    if project.start_date and project.start_date <= today:
        # start date reached with no progress reports → treat as ongoing
        return "ongoing"
    return "upcoming"


def apply_status_change(project, new_status, actor=None, source="auto"):
    """Set the status and keep dependent fields consistent (dates, remarks)."""
    old_status = project.project_status
    if new_status == old_status:
        return False

    # Automatic transitions must never override a manually-set terminal state.
    if source == "auto" and old_status in TERMINAL_STATUSES and new_status not in TERMINAL_STATUSES:
        return False

    project.project_status = new_status

    # Record the real finish date when a project lands on completed.
    if new_status == "completed" and not project.actual_end_date:
        project.actual_end_date = timezone.now().date()
        if not project.end_date:
            project.end_date = project.actual_end_date

    # Coming back from completed: clear the actual end date.
    if old_status == "completed" and new_status != "completed":
        project.actual_end_date = None

    if source == "auto":
        note = f"[Auto] Status changed from {old_status or 'none'} to {new_status} on {timezone.now():%Y-%m-%d %H:%M}."
        project.remarks = (project.remarks + "\n" + note).strip() if project.remarks else note

    project.save(update_fields=["project_status", "actual_end_date", "end_date", "remarks"])

    # Audit trail
    from .models import AuditLog
    AuditLog.objects.create(
        user=actor,
        action="updated",
        model_name="Project",
        object_id=project.pk,
        project=project,
        changes={"source": source, "old_status": old_status, "new_status": new_status},
    )
    return True


def refresh_project_status(project, actor=None, source="auto"):
    """Recompute and apply the derived status. Returns the new status."""
    return project.project_status if not apply_status_change(project, compute_status(project), actor, source) else project.project_status


def sync_project_from_progress(project, reported_by=None):
    """Called whenever a progress update / stage report is saved."""
    if project.project_status in TERMINAL_STATUSES:
        return project.project_status
    return refresh_project_status(project, actor=reported_by)
