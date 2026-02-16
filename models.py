# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey('MemberUser', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class DjangoSession(models.Model):
    session_key = models.CharField(primary_key=True, max_length=40)
    session_data = models.TextField()
    expire_date = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_session'


class MemberAuditlog(models.Model):
    id = models.BigAutoField(primary_key=True)
    action = models.CharField(max_length=255)
    timestamp = models.DateTimeField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey('MemberUser', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_auditlog'


class MemberBudget(models.Model):
    id = models.BigAutoField(primary_key=True)
    allocated_amount = models.DecimalField(max_digits=15, decimal_places=2)
    spent_amount = models.DecimalField(max_digits=15, decimal_places=2)
    last_updated = models.DateTimeField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_budget'


class MemberComment(models.Model):
    id = models.BigAutoField(primary_key=True)
    content = models.TextField()
    created_at = models.DateTimeField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING)
    user = models.ForeignKey('MemberUser', models.DO_NOTHING)
    name = models.CharField(max_length=1000, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_comment'


class MemberContact(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=254)
    message = models.TextField()

    class Meta:
        managed = False
        db_table = 'member_contact'


class MemberFeedback(models.Model):
    id = models.BigAutoField(primary_key=True)
    email = models.CharField(max_length=254)
    phone_number = models.CharField(max_length=15, blank=True, null=True)
    feedback = models.TextField(blank=True, null=True)
    full_name = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_feedback'


class MemberMedia(models.Model):
    id = models.BigAutoField(primary_key=True)
    file = models.CharField(max_length=100)
    media_type = models.CharField(max_length=10)
    uploaded_at = models.DateTimeField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_media'


class MemberMilestone(models.Model):
    id = models.BigAutoField(primary_key=True)
    title = models.CharField(max_length=255)
    description = models.TextField()
    completion_date = models.DateField(blank=True, null=True)
    progress_percentage = models.IntegerField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING)
    stage = models.ForeignKey('MemberProjectstage', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_milestone'


class MemberNotification(models.Model):
    id = models.BigAutoField(primary_key=True)
    message = models.TextField()
    is_read = models.IntegerField()
    created_at = models.DateTimeField()
    recipient = models.ForeignKey('MemberUser', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_notification'


class MemberPdf(models.Model):
    id = models.BigAutoField(primary_key=True)
    project_title = models.CharField(max_length=255, blank=True, null=True)
    implementing_agency = models.CharField(max_length=255, blank=True, null=True)
    pdf_file = models.CharField(max_length=100, blank=True, null=True)
    project_status = models.CharField(max_length=100, blank=True, null=True)
    document = models.CharField(max_length=100, blank=True, null=True)
    project = models.ForeignKey('MemberProject', models.DO_NOTHING, blank=True, null=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    uploaded_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_pdf'


class MemberProgramfunding(models.Model):
    id = models.BigAutoField(primary_key=True)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    funding_source = models.CharField(max_length=255)
    date_funded = models.DateTimeField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_programfunding'


class MemberProgramimpact(models.Model):
    id = models.BigAutoField(primary_key=True)
    metric_name = models.CharField(max_length=255)
    metric_value = models.FloatField()
    measurement_date = models.DateField()
    program = models.ForeignKey('MemberProject', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_programimpact'


class MemberProgressreport(models.Model):
    id = models.BigAutoField(primary_key=True)
    description = models.TextField()
    report_title = models.CharField(max_length=255)
    report_file = models.CharField(max_length=100)
    created_at = models.DateTimeField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_progressreport'


class MemberProgressupdate(models.Model):
    id = models.BigAutoField(primary_key=True)
    description = models.TextField()
    date_reported = models.DateTimeField()
    progress_percentage = models.IntegerField()
    project = models.ForeignKey('MemberProject', models.DO_NOTHING)
    stage = models.ForeignKey('MemberProjectstage', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_progressupdate'


class MemberProject(models.Model):
    id = models.BigAutoField(primary_key=True)
    project_title = models.CharField(max_length=100, blank=True, null=True)
    project_description = models.TextField(blank=True, null=True)
    project_location = models.CharField(max_length=100, blank=True, null=True)
    implementing_agency = models.CharField(max_length=100, blank=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    division = models.ForeignKey('MemberProjectDivision', models.DO_NOTHING, blank=True, null=True)
    images = models.CharField(max_length=100, blank=True, null=True)
    project_budgeting = models.CharField(db_column='project_Budgeting', max_length=15, blank=True, null=True)  # Field name made lowercase.
    project_type = models.ForeignKey('MemberProjectType', models.DO_NOTHING, blank=True, null=True)
    project_status = models.CharField(max_length=10)
    beneficiaries = models.TextField(blank=True, null=True)
    impact = models.TextField(blank=True, null=True)
    progress = models.TextField(blank=True, null=True)
    stakeholders = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_project'


class MemberProjectDivision(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    project_type = models.ForeignKey('MemberProjectType', models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_project_division'


class MemberProjectType(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(unique=True, max_length=100)

    class Meta:
        managed = False
        db_table = 'member_project_type'


class MemberProjectbudget(models.Model):
    id = models.BigAutoField(primary_key=True)
    allocated_budget = models.DecimalField(max_digits=15, decimal_places=2)
    spent_budget = models.DecimalField(max_digits=15, decimal_places=2)
    budget_date = models.DateTimeField()
    project = models.ForeignKey(MemberProject, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_projectbudget'


class MemberProjectlocation(models.Model):
    id = models.BigAutoField(primary_key=True)
    latitude = models.DecimalField(max_digits=9, decimal_places=1, blank=True, null=True)
    longitude = models.DecimalField(max_digits=9, decimal_places=1, blank=True, null=True)
    project = models.OneToOneField(MemberProject, models.DO_NOTHING)
    description = models.TextField(blank=True, null=True)
    name = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_projectlocation'


class MemberProjectstage(models.Model):
    id = models.BigAutoField(primary_key=True)
    stage_name = models.CharField(max_length=20)
    description = models.TextField(blank=True, null=True)
    start_date = models.DateField(blank=True, null=True)
    end_date = models.DateField(blank=True, null=True)
    progress_percentage = models.DecimalField(max_digits=5, decimal_places=2)
    project = models.ForeignKey(MemberProject, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_projectstage'


class MemberReportissue(models.Model):
    id = models.BigAutoField(primary_key=True)
    issue_description = models.TextField()
    evidence = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField()
    resolved = models.IntegerField()
    project = models.ForeignKey(MemberProject, models.DO_NOTHING)
    user = models.ForeignKey('MemberUser', models.DO_NOTHING, blank=True, null=True)
    status = models.CharField(max_length=20)
    title = models.CharField(max_length=255, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_reportissue'


class MemberStakeholder(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=255)
    contact_details = models.TextField()
    role_in_program = models.TextField()
    program = models.ForeignKey(MemberProject, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_stakeholder'


class MemberTender(models.Model):
    id = models.BigAutoField(primary_key=True)
    title = models.CharField(max_length=255, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    opening_date = models.DateField(blank=True, null=True)
    closing_date = models.DateField(blank=True, null=True)
    document = models.CharField(max_length=100, blank=True, null=True)
    project = models.ForeignKey(MemberProject, models.DO_NOTHING, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'member_tender'


class MemberUser(models.Model):
    id = models.BigAutoField(primary_key=True)
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=20)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(unique=True, max_length=254, blank=True, null=True)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()
    avatar = models.CharField(max_length=100, blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    name = models.CharField(max_length=50, blank=True, null=True)
    is_enduser = models.IntegerField()
    profile = models.CharField(max_length=100, blank=True, null=True)
    role = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'member_user'


class MemberUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(MemberUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_user_groups'
        unique_together = (('user', 'group'),)


class MemberUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(MemberUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'member_user_user_permissions'
        unique_together = (('user', 'permission'),)
