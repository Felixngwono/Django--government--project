from django.contrib import admin

from .models import (
    GovernmentAgency,
    IssueResponse,
    IssueResponsePolicy,
    ProjectBaseline,
    ProjectChangeRequest,
    ProjectInspection,
)


@admin.register(GovernmentAgency)
class GovernmentAgencyAdmin(admin.ModelAdmin):
    list_display = ('name', 'code', 'contact_email', 'is_active')
    list_filter = ('is_active',)
    search_fields = ('name', 'code')


@admin.register(IssueResponsePolicy)
class IssueResponsePolicyAdmin(admin.ModelAdmin):
    list_display = ('severity', 'target_hours', 'updated_by', 'updated_at')
    list_editable = ('target_hours',)


@admin.register(ProjectBaseline)
class ProjectBaselineAdmin(admin.ModelAdmin):
    list_display = ('project', 'approved_budget', 'approved_start_date', 'approved_end_date', 'recorded_at')
    readonly_fields = ('project', 'approved_budget', 'approved_start_date', 'approved_end_date', 'approved_by', 'recorded_at')


@admin.register(ProjectChangeRequest)
class ProjectChangeRequestAdmin(admin.ModelAdmin):
    list_display = ('project', 'status', 'requested_by', 'requested_at', 'reviewed_by', 'reviewed_at')
    list_filter = ('status',)
    search_fields = ('project__project_title', 'reason')
    readonly_fields = ('project', 'requested_by', 'requested_at')


@admin.register(ProjectInspection)
class ProjectInspectionAdmin(admin.ModelAdmin):
    list_display = ('project', 'stage', 'outcome', 'inspected_by', 'inspected_at')
    list_filter = ('outcome',)
    search_fields = ('project__project_title', 'findings')
    readonly_fields = ('project', 'stage', 'inspected_by', 'inspected_at', 'outcome', 'findings', 'evidence')


@admin.register(IssueResponse)
class IssueResponseAdmin(admin.ModelAdmin):
    list_display = ('issue', 'author', 'is_internal', 'created_at')
    list_filter = ('is_internal',)
    readonly_fields = ('issue', 'author', 'response', 'is_internal', 'created_at')