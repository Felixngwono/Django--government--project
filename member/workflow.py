"""Shared workflow helpers for permissions, notifications, and audit history."""

from functools import wraps

from django.contrib import messages
from django.http import HttpResponseForbidden

from .models import AuditLog, Notification


OFFICER_ROLES = {"official", "admin", "auditor", "manager", "staff"}
PROJECT_ROLES = OFFICER_ROLES | {"engineer", "architect", "surveyor", "planner"}


def has_role(user, roles):
    return user.is_authenticated and (user.is_superuser or user.role in roles)


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
