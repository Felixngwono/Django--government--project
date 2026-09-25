"""Automatic, time-driven project status synchronisation.

Statuses used to change only when someone saved a progress report, stage or
milestone (see member.signals). Nothing moved them when *time* passed —
projects stayed 'upcoming' after their start date, and 'ongoing' long after
their end date.

ProjectStatusSyncMiddleware closes that gap: on the first request of each
day it runs the same sweep as ``manage.py update_project_statuses``
(member.status_sweep.sweep_project_statuses), which transitions:

    upcoming -> ongoing    once start_date arrives (or work is reported)
    ongoing  -> delayed    once end_date passes the grace period
    *        -> completed  when a 100% progress report / milestone exists

It is guarded by the Django cache (one sweep per calendar day, per process),
is fully idempotent, and never lets a sweep failure break the request.
Disable with PROJECT_STATUS_AUTO_SYNC = False in settings.
"""

import logging

from django.conf import settings
from django.core.cache import cache
from django.utils import timezone

from .status_sweep import sweep_project_statuses
from .deadline_alerts import create_deadline_alerts

logger = logging.getLogger(__name__)

SWEEP_VERSION = "v2"  # bump to force a fresh sweep after changing sweep logic


class ProjectStatusSyncMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        self._maybe_sweep()
        return self.get_response(request)

    def _maybe_sweep(self):
        if not getattr(settings, "PROJECT_STATUS_AUTO_SYNC", True):
            return

        today = timezone.localtime().date()
        cache_key = f"project-status-sweep:{SWEEP_VERSION}:{today}"
        # Claim the day first so parallel requests don't all sweep.
        if cache.add(cache_key, "done", timeout=60 * 60 * 36):
            try:
                changed, transitions = sweep_project_statuses()
                deadline_alerts = create_deadline_alerts(today=today)
                if changed:
                    logger.info(
                        "Project status auto-sync updated %d project(s): %s",
                        changed,
                        "; ".join(transitions[:20]),
                    )
                if deadline_alerts:
                    logger.info("Created %d project deadline notification(s).", deadline_alerts)
            except Exception:  # noqa: BLE001 — a failed sweep must never break a request
                logger.exception("Project status auto-sync failed; will retry after cache reset.")
