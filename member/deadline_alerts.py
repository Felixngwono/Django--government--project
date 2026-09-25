"""Create actionable, de-duplicated in-app deadline alerts for projects."""

from django.db.models import Q
from django.urls import reverse
from django.utils import timezone

from .models import Notification, Project, User


TERMINAL_PROJECT_STATUSES = ('completed', 'cancelled')


def _recipient_ids(project):
    """Return the users accountable for a project deadline."""
    recipient_ids = set(User.objects.filter(is_superuser=True).values_list('id', flat=True))
    if project.created_by_id:
        recipient_ids.add(project.created_by_id)
    if project.project_division_id and project.project_division.head_user_id:
        recipient_ids.add(project.project_division.head_user_id)
    return recipient_ids


def create_deadline_alerts(today=None):
    """Alert owners/admins when a deadline is within two days or overdue.

    Each user receives at most one approaching-deadline alert and one overdue
    alert per project. Links take the recipient directly to that project.
    """
    today = today or timezone.localdate()
    created = 0
    projects = (
        Project.objects.exclude(project_status__in=TERMINAL_PROJECT_STATUSES)
        .filter(end_date__isnull=False, end_date__lte=today + timezone.timedelta(days=2))
        .select_related('project_division')
    )

    for project in projects:
        days_remaining = (project.end_date - today).days
        if days_remaining >= 0:
            alert_kind = 'deadline'
            link = f"{reverse('project_details', args=[project.pk])}?alert=deadline"
            if days_remaining == 0:
                timing = 'is due today'
            elif days_remaining == 1:
                timing = 'is due tomorrow'
            else:
                timing = f'is due in {days_remaining} days'
            title = f"Deadline approaching: {project.project_title}"
            message = f"{project.project_title} {timing} ({project.end_date:%d %b %Y}). Review the project record and take action."
        else:
            alert_kind = 'overdue'
            link = f"{reverse('project_details', args=[project.pk])}?alert=overdue"
            overdue_days = abs(days_remaining)
            title = f"Project overdue: {project.project_title}"
            message = f"{project.project_title} missed its deadline of {project.end_date:%d %b %Y} and is {overdue_days} day{'s' if overdue_days != 1 else ''} overdue. Review the project immediately."

        for user_id in _recipient_ids(project):
            _notification, was_created = Notification.objects.get_or_create(
                user_id=user_id,
                notification_type='deadline',
                link=link,
                defaults={'title': title, 'message': message},
            )
            created += int(was_created)
    return created
