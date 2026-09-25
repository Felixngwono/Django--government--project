from django.apps import AppConfig


class MemberConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'member'

    def ready(self):
        # Registers the status-sync signals (progress updates, stages, milestones).
        from . import signals  # noqa: F401
