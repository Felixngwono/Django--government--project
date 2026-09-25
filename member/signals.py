"""Signals that keep Project.project_status in sync with real project activity.

Whenever a ProgressUpdate, ProjectStage, or Milestone is saved/deleted,
the owning project's status is recomputed by the transition engine.

Milestone changes additionally roll up into their stage: a stage tracks the
average progress of its milestones, so completing "Land Preparation" or
"Foundation" moves the stage's progress/status automatically — and a 100%
stage is marked completed with a completion date.
"""

from django.db.models.signals import post_delete, post_save
from django.dispatch import receiver

from .models import Milestone, ProgressUpdate, ProjectStage
from .workflow import refresh_project_status


@receiver(post_save, sender=ProgressUpdate, dispatch_uid="sync_status_progress")
def sync_status_from_progress(sender, instance, **kwargs):
    refresh_project_status(instance.project, actor=instance.reported_by)


@receiver(post_save, sender=ProjectStage, dispatch_uid="sync_status_stage")
@receiver(post_delete, sender=ProjectStage, dispatch_uid="sync_status_stage_delete")
def sync_status_from_stage(sender, instance, **kwargs):
    refresh_project_status(instance.project)


@receiver(post_save, sender=Milestone, dispatch_uid="sync_stage_from_milestone")
@receiver(post_delete, sender=Milestone, dispatch_uid="sync_stage_from_milestone_delete")
def sync_stage_from_milestone(sender, instance, **kwargs):
    """Milestones drive their stage; the stage (and everything else) drives the project."""
    if instance.stage_id:
        stage = instance.stage
        if stage.sync_progress_from_milestones():
            stage.save()
    refresh_project_status(instance.project)
