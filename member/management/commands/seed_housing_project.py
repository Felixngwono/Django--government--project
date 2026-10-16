"""Seed the showcase "Affordable Housing" project with a realistic, evolving story.

Run once to create the project at an early development stage (site works,
foundation starting). Re-run later (e.g. 6 months later) and the SAME command
advances the story: new stages start, milestones complete, monthly progress
updates are appended, and the completion % rises — so a returning visitor
clearly sees progress.

    python manage.py seed_housing_project
"""
import random
from datetime import datetime, timedelta
from zoneinfo import ZoneInfo

from django.core.management.base import BaseCommand
from django.utils import timezone

from member.models import (
    Avg, District, Milestone, Project, ProjectStage, ProgressReport, ProgressUpdate, Region, User,
)

TITLE = "Affordable Housing Program — Riverside Estate (500 Units)"
DESCRIPTION = (
    "A mixed-income affordable housing development delivering 500 residential "
    "units across 10 blocks, with community facilities, green spaces and a "
    "commercial strip. Targeted at low- and middle-income families on the "
    "housing waiting list. Funded through a blended public-private model and "
    "monitored publicly from ground-breaking to handover."
)

MONTHLY_NARRATIVE = [
    # (stage_name, stage_status, stage_progress, milestone_title, milestone_status, update_text)
    ("Site Clearance & Land Preparation", "in_progress", 20,
     "Land survey and beaconing completed", "completed",
     "Surveyors finished beaconing the 12-acre site; fencing of the compound started."),
    ("Site Clearance & Land Preparation", "in_progress", 55,
     "Demolition of old structures", "completed",
     "Old farm structures demolished and debris cleared. Access road graded."),
    ("Site Clearance & Land Preparation", "completed", 100,
     "Site handed over to the main contractor", "completed",
     "Site clearance 100% complete. The site was formally handed over to the contractor."),
    ("Foundation & Substructure", "in_progress", 35,
     "Excavation and blinding", "completed",
     "Foundation excavation started on Blocks A and B; blinding poured."),
    ("Foundation & Substructure", "in_progress", 60,
     "Reinforcement and column footing", "in_progress",
     "Reinforcement ongoing on Blocks A–D. Concrete batching plant commissioned on site."),
    ("Foundation & Substructure", "in_progress", 80,
     "Ground floor slab casting", "in_progress",
     "Ground slabs for Blocks A and B cast; steel fixing started on Block C."),
    ("Superstructure / Main Works", "in_progress", 45,
     "Walling to first floor", "in_progress",
     "Walling to first floor level reached on Blocks A and B. Block B roof trusses delivered."),
    ("Superstructure / Main Works", "completed", 100,
     "Roofing complete on 5 blocks", "completed",
     "Roofing complete on five blocks. Plumbing and electrical first-fix started."),
    ("Finishing & Fittings", "in_progress", 65,
     "Plastering and internal finishes", "in_progress",
     "Plastering and tiling underway in Blocks A–C; painting started in Block A."),
]

COSTS = [68_000_000, 124_500_000, 141_200_000, 168_900_000, 205_300_000, 238_600_000,
         262_100_000, 291_800_000, 314_500_000]


class Command(BaseCommand):
    help = "Create or advance the Affordable Housing showcase project."

    def handle(self, *args, **options):
        region, _ = Region.objects.get_or_create(name="Metropolitan", code="MET")
        district, _ = District.objects.get_or_create(name="Riverside", region=region)

        project = Project.objects.filter(project_title=TITLE).first()
        created = False
        if not project:
            project = Project.objects.create(
                project_title=TITLE,
                project_description=DESCRIPTION,
                project_location="Riverside, Metropolitan",
                district=district,
                implementing_agency="State Department of Housing",
                supervising_agency="National Construction Authority",
                project_Budgeting=450_000_000,
                funding_source="Blended (Treasury 60% / PPP 40%)",
                beneficiaries="500 low- and middle-income households",
                project_manager="Eng. A. Mwangi",
                project_contractor="Marley Construction Ltd",
                project_status="ongoing",
                priority="high",
                is_featured=True,
                start_date=timezone.localdate() - timedelta(days=8 * 30),
                end_date=timezone.localdate() + timedelta(days=730),
            )
            created = True

        # How many months of the story are already recorded?
        # Each run advances the story by up to 3 months, so a visitor who
        # returns later sees clear, evident progress — not everything at once.
        done = project.progress_updates.count()
        today = timezone.localdate()

        # Disconnect the workflow signals during seeding so saving milestones
        # and progress updates doesn't recompute stage/project state mid-story;
        # one clean refresh runs at the end.
        from member import signals as sig
        from django.db.models.signals import post_save
        post_save.disconnect(sig.sync_status_from_progress, sender=ProgressUpdate)
        post_save.disconnect(sig.sync_status_from_stage, sender=ProjectStage)
        post_save.disconnect(sig.sync_stage_from_milestone, sender=Milestone)
        try:
            self._advance(project, done, today)
        finally:
            post_save.connect(sig.sync_status_from_progress, sender=ProgressUpdate, dispatch_uid="sync_status_progress")
            post_save.connect(sig.sync_status_from_stage, sender=ProjectStage, dispatch_uid="sync_status_stage")
            post_save.connect(sig.sync_stage_from_milestone, sender=Milestone, dispatch_uid="sync_stage_from_milestone")
            from member.workflow import refresh_project_status
            refresh_project_status(project, source='auto')
            project.refresh_from_db()

        # Summary output
        if created:
            self.stdout.write(self.style.SUCCESS(
                f'Created "{TITLE}" with month-1 progress.'))
        else:
            self.stdout.write(self.style.SUCCESS(
                f'Advanced "{TITLE}" to month {done + 1} of {len(MONTHLY_NARRATIVE)}.'))
        self.stdout.write(f"Overall progress now: {project.overall_progress}%")

    def _advance(self, project, done, today):
        for i in range(done, min(len(MONTHLY_NARRATIVE), done + 3)):
            stage_name, stage_status, stage_prog, ms_title, ms_status, update_text = MONTHLY_NARRATIVE[i]
            month_start = project.start_date + timedelta(days=30 * i)
            month_end = min(month_start + timedelta(days=30), today)

            stage = ProjectStage.objects.filter(project=project, stage_name=stage_name).first()
            if not stage:
                stage = ProjectStage.objects.create(
                    project=project, stage_name=stage_name,
                    start_date=month_start, end_date=month_start + timedelta(days=90),
                    order=i + 1,
                )

            # A stage is only 'completed' (and its progress 100) when the
            # programme's LAST month is reached — otherwise an early finished
            # stage would make the engine read the whole project as complete.
            final_month = (i == len(MONTHLY_NARRATIVE) - 1)
            stage.progress_percentage = 100 if final_month else min(stage_prog, 99)
            stage.status = (
                "completed" if (final_month and stage_prog >= 100)
                else ("in_progress" if stage_prog > 0 else "not_started")
            )
            stage.is_current = stage.status != "completed"
            stage.completed_on = month_end if stage.status == "completed" else None
            ProjectStage.objects.filter(project=project).update(is_current=False)
            stage.is_current = stage.status != "completed"
            stage.save()

            Milestone.objects.get_or_create(
                project=project, title=ms_title,
                defaults=dict(
                    stage=stage, description=ms_title,
                    due_date=month_end,
                    # Milestone status follows its actual recorded progress
                    # (Milestone.save keeps status/progress consistent, so a
                    # 99% milestone is genuinely 'in_progress').
                    status="completed" if (i == len(MONTHLY_NARRATIVE) - 1) else "in_progress",
                    completion_date=month_end if (i == len(MONTHLY_NARRATIVE) - 1) else None,
                    # A milestone represents one deliverable of the stage, not
                    # of the whole project: only mark it 100% when the FULL
                    # programme's last month is reached, otherwise keep it
                    # in-progress so the status engine doesn't end the project
                    # after an early stage completes.
                    progress_percentage=100 if (i == len(MONTHLY_NARRATIVE) - 1) else min(stage_prog, 99),
                ),
            )

            # Monthly progress update published by the contractor.
            # It reports OVERALL project progress — the position of this month
            # in the whole programme (stage weights from the full plan), not
            # the average of existing stages, which early on would read 100%
            # just because the first stage is done.
            reported_by = User.objects.filter(role="contractor").first() or project.created_by
            aware = datetime.combine(month_end, datetime.min.time(), tzinfo=ZoneInfo("Africa/Nairobi"))
            # Weighted programme progress: each of the planned months carries
            # 1/9 of the whole project, weighted by its stage's progress that
            # month (a completed stage earns its full share, an in-progress
            # stage earns a fraction). Truthful and monotonic across months.
            earned = sum(MONTHLY_NARRATIVE[j][2] for j in range(i + 1))
            overall = round(earned / len(MONTHLY_NARRATIVE))
            if i < len(MONTHLY_NARRATIVE) - 1:
                overall = min(overall, 99)
            upd = ProgressUpdate(
                project=project, stage=stage,
                reported_by=reported_by,
                description=f"Month {i + 1} update: {update_text}",
                progress_percentage=overall,
            )
            upd.save()
            ProgressUpdate.objects.filter(pk=upd.pk).update(date_reported=aware)

            project.amount_spent = COSTS[i]
            project.progress = update_text
            project.save()

        # If the whole programme has been told, wrap up cleanly: every stage
        # finishes, so the final refresh marks the project completed.
        if done + 3 >= len(MONTHLY_NARRATIVE):
            for s in ProjectStage.objects.filter(project=project):
                s.progress_percentage = 100
                s.status = "completed"
                s.is_current = False
                s.save()
            project.amount_spent = COSTS[-1]
            project.save()
