# models.py — GovTracker Complete

from django.db import models
from django.core.validators import MaxValueValidator, MinValueValidator
from django.contrib.auth.models import AbstractUser
from django.core.exceptions import ValidationError
from django.conf import settings
from django.utils import timezone
import uuid


# ─────────────────────────────────────────────
# USER & AUTHENTICATION
# ─────────────────────────────────────────────

class User(AbstractUser):
    ROLE_CHOICES = [
        ('citizen',    'Citizen'),
        ('official',   'Government Official'),
        ('contractor', 'Contractor'),
        ('engineer',   'Engineer'),
        ('architect',  'Architect'),
        ('surveyor',   'Surveyor'),
        ('planner',    'Urban Planner'),
        ('developer',  'Software Developer'),
        ('analyst',    'Data Analyst'),
        ('manager',    'Project Manager'),
        ('staff',      'Staff'),
        ('admin',      'Administrator'),
        ('auditor',    'Auditor'),
        ('guest',      'Guest'),
    ]

    VERIFICATION_STATUS = [
        ('unverified', 'Unverified'),
        ('pending',    'Pending Verification'),
        ('verified',   'Verified'),
        ('suspended',  'Suspended'),
    ]

    email               = models.EmailField(unique=True, default=True)
    username            = models.CharField(max_length=20, unique=True)
    name                = models.CharField(max_length=50, null=True)
    role                = models.CharField(max_length=20, choices=ROLE_CHOICES, default='citizen')
    bio                 = models.TextField(null=True, blank=True)
    avatar              = models.ImageField(null=True, blank=True, upload_to='avatars/', default='avatar.png')
    profile             = models.ImageField(null=True, blank=True, upload_to='profiles/', default='avatar.png')
    phone_number        = models.CharField(max_length=20, null=True, blank=True)
    location            = models.CharField(max_length=255, null=True, blank=True)
    organization        = models.CharField(max_length=255, null=True, blank=True)
    verification_status = models.CharField(max_length=20, choices=VERIFICATION_STATUS, default='unverified')
    is_enduser          = models.BooleanField(default=False)
    is_verified         = models.BooleanField(default=False)
    two_factor_enabled  = models.BooleanField(default=False)
    last_login_ip       = models.GenericIPAddressField(null=True, blank=True)
    updated             = models.DateTimeField(auto_now=True)
    created_at          = models.DateTimeField(auto_now_add=True, null=True)

    USERNAME_FIELD  = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.username

    @property
    def full_name(self):
        return self.name or f"{self.first_name} {self.last_name}".strip() or self.username

    @property
    def is_government(self):
        return self.role in ('official', 'staff', 'admin', 'auditor', 'manager')


class UserPermissionGroup(models.Model):
    """Fine-grained permission sets per role."""
    name        = models.CharField(max_length=100)
    roles       = models.JSONField(default=list)          # list of role strings
    permissions = models.JSONField(default=dict)          # { "can_approve_tenders": True, ... }
    created_at  = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name


class UserActivity(models.Model):
    """Track every meaningful user action for audit + AI analysis."""
    ACTION_TYPES = [
        ('login',        'Login'),
        ('logout',       'Logout'),
        ('view',         'Viewed Page'),
        ('create',       'Created Record'),
        ('update',       'Updated Record'),
        ('delete',       'Deleted Record'),
        ('download',     'Downloaded File'),
        ('submit',       'Submitted Form'),
        ('ai_query',     'AI Query'),
    ]
    user        = models.ForeignKey(User, on_delete=models.CASCADE, related_name='activity_logs')
    action      = models.CharField(max_length=20, choices=ACTION_TYPES)
    description = models.CharField(max_length=500)
    ip_address  = models.GenericIPAddressField(null=True, blank=True)
    metadata    = models.JSONField(default=dict, blank=True)  # extra context
    created_at  = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.user.username} — {self.action} @ {self.created_at}"


# ─────────────────────────────────────────────
# LOCATION & GEOGRAPHY
# ─────────────────────────────────────────────

class Region(models.Model):
    name = models.CharField(max_length=100)
    code = models.CharField(max_length=20, unique=True)

    def __str__(self):
        return self.name


class District(models.Model):
    name   = models.CharField(max_length=100)
    region = models.ForeignKey(Region, on_delete=models.CASCADE, related_name='districts')

    def __str__(self):
        return f"{self.name} — {self.region.name}"


# ─────────────────────────────────────────────
# PROJECTS
# ─────────────────────────────────────────────

class ProjectCategory(models.Model):
    name        = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    icon        = models.CharField(max_length=50, blank=True)  # CSS icon class
    color       = models.CharField(max_length=10, blank=True)  # hex color

    def __str__(self):
        return self.name


class Project(models.Model):
    STATUS_CHOICES = [
        ('draft',     'Draft'),
        ('ongoing',   'Ongoing'),
        ('upcoming',  'Upcoming'),
        ('completed', 'Completed'),
        ('delayed',   'Delayed'),
        ('suspended', 'Suspended'),
        ('cancelled', 'Cancelled'),
    ]

    PRIORITY_CHOICES = [
        ('low',      'Low'),
        ('medium',   'Medium'),
        ('high',     'High'),
        ('critical', 'Critical'),
    ]

    # Identifiers
    reference_code      = models.CharField(max_length=50, unique=True, null=True, blank=True)

    # Core Info
    project_title       = models.CharField(max_length=200, null=True)
    project_description = models.TextField(null=True)
    project_location    = models.CharField(max_length=200, null=True)
    district            = models.ForeignKey(District, on_delete=models.SET_NULL, null=True, blank=True, related_name='projects')
    category            = models.ForeignKey(ProjectCategory, on_delete=models.SET_NULL, null=True, blank=True, related_name='projects')

    # Agencies
    implementing_agency = models.CharField(max_length=200, null=True)
    supervising_agency  = models.CharField(max_length=200, null=True, blank=True)

    # Financial
    project_Budgeting   = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    amount_spent        = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    funding_source      = models.CharField(max_length=255, null=True, blank=True)

    # Media
    images              = models.ImageField(null=True, blank=True, upload_to='projects/')
    cover_image         = models.ImageField(null=True, blank=True, upload_to='projects/covers/')

    # Timeline
    start_date          = models.DateField(null=True, blank=True)
    end_date            = models.DateField(null=True, blank=True)
    actual_end_date     = models.DateField(null=True, blank=True)

    # People
    beneficiaries       = models.TextField(null=True)
    stakeholders        = models.TextField(null=True)
    project_manager     = models.CharField(max_length=100, null=True, blank=True)
    project_contractor  = models.CharField(max_length=100, null=True, blank=True)
    contact_email       = models.EmailField(null=True, blank=True)

    # Status
    project_status      = models.CharField(max_length=20, choices=STATUS_CHOICES, null=True, default='draft')
    priority            = models.CharField(max_length=10, choices=PRIORITY_CHOICES, default='medium')
    is_public           = models.BooleanField(default=True)
    is_featured         = models.BooleanField(default=False)

    # AI-Generated Fields
    ai_summary          = models.TextField(null=True, blank=True)  # AI-generated summary
    ai_risk_score       = models.FloatField(null=True, blank=True)  # AI-computed risk
    ai_completion_estimate = models.DateField(null=True, blank=True)  # AI prediction

    # Progress & Remarks
    impact              = models.TextField(blank=True, null=True)
    progress            = models.TextField(blank=True, null=True)
    remarks             = models.TextField(null=True, blank=True)
    progress_update     = models.DateTimeField(auto_now=True, null=True, blank=True)

    # Meta
    created_by          = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='created_projects')
    created_at          = models.DateTimeField(auto_now_add=True, null=True)
    updated_at          = models.DateTimeField(auto_now=True, null=True)

    class Meta:
        ordering = ['-start_date']

    def __str__(self):
        return self.project_title or "Untitled Project"

    @property
    def budget_remaining(self):
        return (self.project_Budgeting or 0) - (self.amount_spent or 0)

    @property
    def budget_utilization(self):
        if not self.project_Budgeting:
            return 0
        return round(float((self.amount_spent or 0) / self.project_Budgeting * 100), 2)

    @property
    def is_overdue(self):
        if self.end_date and self.project_status not in ('completed', 'cancelled'):
            return timezone.now().date() > self.end_date
        return False

    def clean(self):
        errors = {}
        if self.start_date and self.end_date and self.end_date < self.start_date:
            errors['end_date'] = 'End date cannot be before start date.'
        if self.project_Budgeting is not None and self.project_Budgeting < 0:
            errors['project_Budgeting'] = 'Budget cannot be negative.'
        if self.amount_spent is not None and self.amount_spent < 0:
            errors['amount_spent'] = 'Amount spent cannot be negative.'
        if errors:
            raise ValidationError(errors)

    def save(self, *args, **kwargs):
        if not self.reference_code:
            self.reference_code = f"PRJ-{uuid.uuid4().hex[:8].upper()}"
        super().save(*args, **kwargs)


class ProjectTag(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='tags')
    tag     = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.tag} — {self.project.project_title}"


# ─────────────────────────────────────────────
# PROJECT STAGES & PROGRESS
# ─────────────────────────────────────────────

class ProjectStage(models.Model):
    STAGES = [
        ('planning',      'Planning'),
        ('procurement',   'Procurement'),
        ('construction',  'Construction'),
        ('completion',    'Completion'),
        ('monitoring',    'Monitoring & Evaluation'),
        ('handover',      'Handover'),
        ('others',        'Others'),
    ]

    project             = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='stages')
    stage_name          = models.CharField(max_length=30, choices=STAGES)
    description         = models.TextField(null=True, blank=True)
    start_date          = models.DateField(null=True, blank=True)
    end_date            = models.DateField(null=True, blank=True)
    progress_percentage = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)
    is_current          = models.BooleanField(default=False)
    order               = models.PositiveIntegerField(default=0)

    class Meta:
        ordering = ['order']

    def __str__(self):
        return f"{self.project.project_title} — {self.get_stage_name_display()}"

    def clean(self):
        errors = {}
        if self.start_date and self.end_date and self.end_date < self.start_date:
            errors['end_date'] = 'Stage end date cannot be before its start date.'
        if not 0 <= self.progress_percentage <= 100:
            errors['progress_percentage'] = 'Progress must be between 0 and 100.'
        if errors:
            raise ValidationError(errors)


class ProgressUpdate(models.Model):
    project             = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='progress_updates')
    stage               = models.ForeignKey(ProjectStage, on_delete=models.SET_NULL, null=True, blank=True, related_name='progress_updates')
    reported_by         = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    description         = models.TextField()
    progress_percentage = models.IntegerField(default=0)
    challenges          = models.TextField(null=True, blank=True)
    next_steps          = models.TextField(null=True, blank=True)
    date_reported       = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-date_reported']

    def __str__(self):
        return f"Progress for {self.project.project_title} — {self.progress_percentage}%"

    def clean(self):
        errors = {}
        if not 0 <= self.progress_percentage <= 100:
            errors['progress_percentage'] = 'Progress must be between 0 and 100.'
        if self.stage_id and self.stage.project_id != self.project_id:
            errors['stage'] = 'Stage must belong to this project.'
        if errors:
            raise ValidationError(errors)


class Milestone(models.Model):
    STATUS_CHOICES = [
        ('pending',     'Pending'),
        ('in_progress', 'In Progress'),
        ('completed',   'Completed'),
        ('missed',      'Missed'),
    ]

    project             = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='milestones')
    stage               = models.ForeignKey(ProjectStage, on_delete=models.SET_NULL, null=True, blank=True, related_name='milestones')
    title               = models.CharField(max_length=255)
    description         = models.TextField()
    due_date            = models.DateField(null=True, blank=True)
    completion_date     = models.DateField(null=True, blank=True)
    progress_percentage = models.IntegerField(default=0)
    status              = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f"{self.project.project_title} — {self.title}"

    def clean(self):
        errors = {}
        if not 0 <= self.progress_percentage <= 100:
            errors['progress_percentage'] = 'Progress must be between 0 and 100.'
        if self.stage_id and self.stage.project_id != self.project_id:
            errors['stage'] = 'Stage must belong to this project.'
        if errors:
            raise ValidationError(errors)


# ─────────────────────────────────────────────
# BUDGET & FINANCE
# ─────────────────────────────────────────────

class Budget(models.Model):
    project          = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='budget')
    allocated_amount = models.DecimalField(max_digits=15, decimal_places=2)
    spent_amount     = models.DecimalField(max_digits=15, decimal_places=2, default=0.00)
    fiscal_year      = models.CharField(max_length=10, null=True, blank=True)
    last_updated     = models.DateTimeField(auto_now=True)
    notes            = models.TextField(null=True, blank=True)

    def __str__(self):
        return f"Budget for {self.project.project_title}"

    @property
    def utilization_rate(self):
        if not self.allocated_amount:
            return 0
        return round(float(self.spent_amount / self.allocated_amount * 100), 2)

    def clean(self):
        errors = {}
        if self.allocated_amount < 0:
            errors['allocated_amount'] = 'Cannot be negative.'
        if self.spent_amount < 0:
            errors['spent_amount'] = 'Cannot be negative.'
        if errors:
            raise ValidationError(errors)


class BudgetRevision(models.Model):
    """Track every budget change with justification."""
    budget       = models.ForeignKey(Budget, on_delete=models.CASCADE, related_name='revisions')
    old_amount   = models.DecimalField(max_digits=15, decimal_places=2)
    new_amount   = models.DecimalField(max_digits=15, decimal_places=2)
    reason       = models.TextField()
    approved_by  = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    revised_at   = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Revision for {self.budget.project.project_title}"


class ProjectExpense(models.Model):
    CATEGORY_CHOICES = [
        ('labour',     'Labour'),
        ('materials',  'Materials'),
        ('equipment',  'Equipment'),
        ('consultancy','Consultancy'),
        ('admin',      'Administration'),
        ('other',      'Other'),
    ]

    project     = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='expenses', null=True)
    title       = models.CharField(max_length=255, null=True)
    category    = models.CharField(max_length=20, choices=CATEGORY_CHOICES, null=True)
    amount      = models.DecimalField(max_digits=15, decimal_places=2, null=True)
    description = models.TextField(blank=True, null=True)
    receipt     = models.FileField(upload_to='receipts/', null=True, blank=True)
    recorded_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    date        = models.DateField(auto_now_add=True, null=True)

    def __str__(self):
        return self.title or "Expense"


class ProgramFunding(models.Model):
    project        = models.ForeignKey(Project, related_name='funding', on_delete=models.CASCADE)
    amount         = models.DecimalField(max_digits=15, decimal_places=2)
    funding_source = models.CharField(max_length=255)
    funding_type   = models.CharField(max_length=50, choices=[
        ('grant', 'Grant'), ('loan', 'Loan'), ('internal', 'Internal'), ('donor', 'Donor')
    ], default='grant')
    date_funded    = models.DateTimeField(auto_now_add=True)
    reference      = models.CharField(max_length=100, null=True, blank=True)

    def __str__(self):
        return f"{self.funding_source} — {self.amount} for {self.project.project_title}"


# ─────────────────────────────────────────────
# TENDER MANAGEMENT
# ─────────────────────────────────────────────

class Tender(models.Model):
    PROCUREMENT_METHODS = [
        ('open',       'Open Tender'),
        ('restricted', 'Restricted Tender'),
        ('rfq',        'Request for Quotation'),
        ('direct',     'Direct Procurement'),
        ('sole',       'Sole Sourcing'),
    ]

    STATUS_CHOICES = [
        ('draft',      'Draft'),
        ('published',  'Published'),
        ('closed',     'Closed'),
        ('evaluating', 'Evaluating'),
        ('awarded',    'Awarded'),
        ('cancelled',  'Cancelled'),
    ]

    project              = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='tenders', null=True, blank=True)
    reference_number     = models.CharField(max_length=100, unique=True, null=True, blank=True)
    title                = models.CharField(max_length=255, null=True, blank=True)
    description          = models.TextField(null=True, blank=True)
    procurement_method   = models.CharField(max_length=20, choices=PROCUREMENT_METHODS, default='open')
    estimated_budget     = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    opening_date         = models.DateField(null=True, blank=True)
    closing_date         = models.DateField(null=True, blank=True)
    eligibility_criteria = models.TextField(null=True, blank=True)
    evaluation_criteria  = models.TextField(null=True, blank=True)
    status               = models.CharField(max_length=20, choices=STATUS_CHOICES, default='draft')
    document             = models.FileField(upload_to='tenders/', null=True, blank=True)
    created_by           = models.ForeignKey(User, null=True, related_name='created_tenders', blank=True, on_delete=models.SET_NULL)
    is_published         = models.BooleanField(default=False)
    awarded_to           = models.ForeignKey('Contractor', null=True, blank=True, on_delete=models.SET_NULL, related_name='awarded_tenders')
    award_date           = models.DateField(null=True, blank=True)
    award_amount         = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)
    created_at           = models.DateTimeField(auto_now_add=True, null=True)

    def save(self, *args, **kwargs):
        if not self.reference_number:
            self.reference_number = f"TND-{uuid.uuid4().hex[:8].upper()}"
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.reference_number} — {self.project.project_title if self.project_id else 'Unassigned'}"

    def clean(self):
        errors = {}
        if self.opening_date and self.closing_date and self.closing_date < self.opening_date:
            errors['closing_date'] = 'Closing date cannot be before opening date.'
        if self.estimated_budget is not None and self.estimated_budget < 0:
            errors['estimated_budget'] = 'Budget cannot be negative.'
        if errors:
            raise ValidationError(errors)


class TenderApplication(models.Model):
    STATUS_CHOICES = [
        ('submitted',    'Submitted'),
        ('under_review', 'Under Review'),
        ('shortlisted',  'Shortlisted'),
        ('rejected',     'Rejected'),
        ('awarded',      'Awarded'),
    ]

    tender             = models.ForeignKey(Tender, on_delete=models.CASCADE, related_name='applications', null=True)
    applicant          = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
    company_name       = models.CharField(max_length=200, null=True)
    company_email      = models.EmailField(null=True)
    company_phone      = models.CharField(max_length=20, null=True)
    proposal_document  = models.FileField(upload_to='tender_applications/', null=True)
    cover_letter       = models.FileField(upload_to='tender_coverLetter/', blank=True, null=True)
    bid_amount         = models.DecimalField(max_digits=15, decimal_places=2, null=True)
    technical_score    = models.FloatField(default=0)
    financial_score    = models.FloatField(default=0)
    total_score        = models.FloatField(default=0)
    status             = models.CharField(max_length=20, choices=STATUS_CHOICES, default='submitted')
    evaluator_notes    = models.TextField(null=True, blank=True)
    submitted_at       = models.DateTimeField(auto_now_add=True)

    # AI Evaluation
    ai_technical_assessment = models.TextField(null=True, blank=True)
    ai_financial_assessment = models.TextField(null=True, blank=True)
    ai_recommendation       = models.CharField(max_length=50, null=True, blank=True)

    def __str__(self):
        return f"{self.company_name} — {self.tender.reference_number if self.tender_id else 'N/A'}"

    def clean(self):
        if self.bid_amount is not None and self.bid_amount < 0:
            raise ValidationError({'bid_amount': 'Bid amount cannot be negative.'})


class TenderEvaluationCriteria(models.Model):
    tender      = models.ForeignKey(Tender, on_delete=models.CASCADE, related_name='evaluation_criteria_items')
    criterion   = models.CharField(max_length=255)
    weight      = models.FloatField()  # percentage weight
    description = models.TextField(blank=True)

    def __str__(self):
        return f"{self.criterion} ({self.weight}%) — {self.tender.reference_number}"


# ─────────────────────────────────────────────
# CONTRACTORS
# ─────────────────────────────────────────────

class Contractor(models.Model):
    name             = models.CharField(max_length=255, null=True)
    company          = models.CharField(max_length=255, null=True)
    phone            = models.CharField(max_length=20, null=True)
    email            = models.EmailField(blank=True, null=True)
    location         = models.CharField(max_length=255, null=True)
    profile          = models.ImageField(upload_to='contractors/', null=True, blank=True)
    registration_no  = models.CharField(max_length=100, null=True, blank=True)
    category         = models.CharField(max_length=100, null=True, blank=True)  # e.g., Class A, B, C
    is_blacklisted   = models.BooleanField(default=False)
    blacklist_reason = models.TextField(null=True, blank=True)
    projects         = models.ManyToManyField(Project, related_name='contractors', blank=True)
    created_at       = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.company or self.name or "Unnamed Contractor"

    @property
    def average_rating(self):
        ratings = self.contractorrating_set.all()
        if not ratings.exists():
            return 0
        scores = [(r.quality_score + r.speed_score + r.compliance_score) / 3 for r in ratings]
        return round(sum(scores) / len(scores), 2)


class ContractorDocument(models.Model):
    DOC_TYPES = [
        ('registration', 'Registration Certificate'),
        ('tax',          'Tax Clearance'),
        ('insurance',    'Insurance'),
        ('license',      'License'),
        ('other',        'Other'),
    ]
    contractor  = models.ForeignKey(Contractor, on_delete=models.CASCADE, related_name='documents')
    doc_type    = models.CharField(max_length=20, choices=DOC_TYPES)
    file        = models.FileField(upload_to='contractor_docs/')
    expiry_date = models.DateField(null=True, blank=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.get_doc_type_display()} — {self.contractor}"


class ContractorRating(models.Model):
    contractor        = models.ForeignKey(Contractor, on_delete=models.CASCADE, null=True)
    project           = models.ForeignKey(Project, on_delete=models.CASCADE)
    rated_by          = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    quality_score     = models.IntegerField(default=0)
    speed_score       = models.IntegerField(default=0)
    compliance_score  = models.IntegerField(default=0)
    comment           = models.TextField(blank=True, null=True)
    created_at        = models.DateTimeField(auto_now_add=True, null=True)

    def average_score(self):
        return round((self.quality_score + self.speed_score + self.compliance_score) / 3, 2)

    def clean(self):
        errors = {}
        for field in ('quality_score', 'speed_score', 'compliance_score'):
            score = getattr(self, field)
            if not 0 <= score <= 100:
                errors[field] = 'Scores must be between 0 and 100.'
        if errors:
            raise ValidationError(errors)


class StageReport(models.Model):
    project             = models.ForeignKey(Project, on_delete=models.CASCADE)
    stage               = models.ForeignKey(ProjectStage, on_delete=models.CASCADE)
    contractor          = models.ForeignKey(Contractor, on_delete=models.SET_NULL, null=True, blank=True)
    reported_by         = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    description         = models.TextField()
    progress_percentage = models.IntegerField(default=0)
    location            = models.CharField(max_length=255)
    photo               = models.ImageField(upload_to='stage_reports/', blank=True, null=True)
    weather_conditions  = models.CharField(max_length=100, null=True, blank=True)
    workforce_count     = models.IntegerField(null=True, blank=True)
    created_at          = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.project.project_title} — {self.stage.get_stage_name_display()}"

    def clean(self):
        errors = {}
        if not 0 <= self.progress_percentage <= 100:
            errors['progress_percentage'] = 'Progress must be between 0 and 100.'
        if self.stage_id and self.stage.project_id != self.project_id:
            errors['stage'] = 'Stage must belong to this project.'
        if errors:
            raise ValidationError(errors)


# ─────────────────────────────────────────────
# CITIZEN ENGAGEMENT
# ─────────────────────────────────────────────

class CitizenSubmission(models.Model):
    CATEGORY_CHOICES = [
        ('suggestion', 'Suggestion'),
        ('complaint',  'Complaint'),
        ('report',     'Report Issue'),
        ('commendation','Commendation'),
    ]

    STATUS_CHOICES = [
        ('pending',   'Pending'),
        ('reviewed',  'Reviewed'),
        ('approved',  'Approved'),
        ('rejected',  'Rejected'),
        ('resolved',  'Resolved'),
    ]

    user       = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    title      = models.CharField(max_length=255)
    message    = models.TextField()
    category   = models.CharField(max_length=20, choices=CATEGORY_CHOICES)
    status     = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    project    = models.ForeignKey(Project, on_delete=models.SET_NULL, null=True, blank=True, related_name='citizen_submissions')
    attachment = models.FileField(upload_to='submissions/', null=True, blank=True)
    response   = models.TextField(null=True, blank=True)   # official response
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title


class GovernmentRequest(models.Model):
    CATEGORY_CHOICES = [
        ('infrastructure', 'Infrastructure'),
        ('water',          'Water & Sanitation'),
        ('health',         'Health Services'),
        ('education',      'Education'),
        ('security',       'Security'),
        ('corruption',     'Corruption Report'),
        ('other',          'Other'),
    ]

    STATUS_CHOICES = [
        ('pending',     'Pending'),
        ('in_progress', 'In Progress'),
        ('resolved',    'Resolved'),
        ('rejected',    'Rejected'),
    ]

    citizen     = models.ForeignKey(User, on_delete=models.CASCADE)
    title       = models.CharField(max_length=255)
    description = models.TextField()
    category    = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    location    = models.CharField(max_length=255)
    image       = models.ImageField(upload_to='requests/', blank=True, null=True)
    status      = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    assigned_to = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='assigned_requests')
    ai_category_suggestion = models.CharField(max_length=50, null=True, blank=True)
    created_at  = models.DateTimeField(auto_now_add=True)
    updated_at  = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title


class ReportIssue(models.Model):
    STATUS_CHOICES = [
        ('pending',       'Pending'),
        ('investigating', 'Investigating'),
        ('resolved',      'Resolved'),
        ('dismissed',     'Dismissed'),
    ]

    SEVERITY_CHOICES = [
        ('low',      'Low'),
        ('moderate', 'Moderate'),
        ('high',     'High'),
        ('critical', 'Critical'),
    ]

    title             = models.CharField(max_length=255, null=True)
    project           = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='issues')
    user              = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    issue_description = models.TextField()
    evidence          = models.FileField(upload_to='issue_evidence/', null=True, blank=True)
    severity          = models.CharField(max_length=10, choices=SEVERITY_CHOICES, default='moderate')
    status            = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    resolved          = models.BooleanField(default=False)
    resolution_notes  = models.TextField(null=True, blank=True)
    resolved_by       = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='resolved_issues')
    created_at        = models.DateTimeField(auto_now_add=True)
    updated_at        = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Issue on {self.project.project_title} by {self.user.username if self.user else 'Anonymous'}"


class CitizenEvidence(models.Model):
    user        = models.ForeignKey(User, on_delete=models.CASCADE)
    project     = models.ForeignKey(Project, on_delete=models.CASCADE)
    stage       = models.ForeignKey(ProjectStage, on_delete=models.CASCADE)
    title       = models.CharField(max_length=255)
    description = models.TextField()
    location    = models.CharField(max_length=255)
    image       = models.ImageField(upload_to='citizen_evidence/', blank=True, null=True)
    is_verified = models.BooleanField(default=False)
    verified_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='verified_evidence')
    created_at  = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title

    def clean(self):
        if self.stage_id and self.stage.project_id != self.project_id:
            raise ValidationError({'stage': 'Stage must belong to this project.'})


class Participation(models.Model):
    user      = models.ForeignKey(User, on_delete=models.CASCADE)
    project   = models.ForeignKey(Project, on_delete=models.CASCADE)
    content   = models.TextField(null=True, blank=True)
    joined_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.user.username} — {self.project.project_title}"


class Comment(models.Model):
    project    = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='comments')
    user       = models.ForeignKey(User, on_delete=models.CASCADE)
    parent     = models.ForeignKey('self', on_delete=models.CASCADE, null=True, blank=True, related_name='replies')  # threaded comments
    content    = models.TextField()
    is_flagged = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"Comment by {self.user.username} on {self.project.project_title}"


class Feedback(models.Model):
    RATING_CHOICES = [(i, str(i)) for i in range(1, 6)]

    full_name    = models.CharField(max_length=50, null=True)
    email        = models.EmailField()
    phone_number = models.CharField(max_length=15, null=True)
    feedback     = models.TextField(null=True)
    rating       = models.IntegerField(choices=RATING_CHOICES, null=True, blank=True)
    project      = models.ForeignKey(Project, on_delete=models.SET_NULL, null=True, blank=True, related_name='feedback')
    created_at   = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.full_name or "Feedback"


class Testimonial(models.Model):
    name         = models.CharField(max_length=100, null=True)
    content      = models.TextField(null=True)
    user         = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    phone_number = models.CharField(max_length=15, null=True, blank=True)
    project      = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='testimonials', null=True)
    image        = models.ImageField(upload_to='testimonials/', null=True, blank=True)
    rating       = models.PositiveSmallIntegerField(default=5, validators=[MinValueValidator(1), MaxValueValidator(5)])
    is_approved  = models.BooleanField(default=False)
    is_featured  = models.BooleanField(default=False)
    moderation_note = models.TextField(blank=True)
    created_at   = models.DateTimeField(auto_now_add=True)
    updated_at   = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"Testimonial by {self.name or 'Anonymous'}"


class Contact(models.Model):
    name       = models.CharField(max_length=100)
    email      = models.EmailField()
    subject    = models.CharField(max_length=255, null=True, blank=True)
    message    = models.TextField()
    is_replied = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True, null=True)

    def __str__(self):
        return self.name


# ─────────────────────────────────────────────
# MEDIA & DOCUMENTS
# ─────────────────────────────────────────────

class Media(models.Model):
    MEDIA_TYPES = [
        ('image', 'Image'),
        ('video', 'Video'),
        ('pdf',   'PDF Document'),
    ]
    project     = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='media', null=True)
    file        = models.FileField(upload_to='project_media/')
    media_type  = models.CharField(max_length=10, choices=MEDIA_TYPES, default='image')
    caption     = models.CharField(max_length=255, null=True, blank=True)
    uploaded_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Media for {self.project.project_title if self.project_id else 'N/A'}"


class ProjectDocument(models.Model):
    DOC_CATEGORIES = [
        ('contract',    'Contract'),
        ('report',      'Report'),
        ('plan',        'Plan'),
        ('certificate', 'Certificate'),
        ('other',       'Other'),
    ]
    project     = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='documents')
    name        = models.CharField(max_length=200)
    category    = models.CharField(max_length=20, choices=DOC_CATEGORIES, default='other')
    file        = models.FileField(upload_to='project_docs/')
    uploaded_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} — {self.project.project_title}"


class PDF(models.Model):
    project            = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='pdfs', null=True, blank=True)
    title              = models.CharField(max_length=255, null=True)
    document           = models.FileField(upload_to='pdfs/document', blank=True, null=True)
    pdf_file           = models.FileField(upload_to='pdfs/', blank=True, null=True)
    uploaded_at        = models.DateTimeField(auto_now_add=True, null=True)
    project_title      = models.CharField(max_length=255, null=True)
    project_status     = models.CharField(max_length=100, null=True)
    implementing_agency = models.CharField(max_length=255, null=True)

    def __str__(self):
        return self.title or self.project_title or "Untitled Document"


class ProgressReport(models.Model):
    project      = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='progress_reports')
    report_title = models.CharField(max_length=255)
    description  = models.TextField()
    report_file  = models.FileField(upload_to='progress_reports/')
    created_by   = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    created_at   = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Report: {self.report_title} — {self.project.project_title}"


# ─────────────────────────────────────────────
# NOTIFICATIONS & AUDIT
# ─────────────────────────────────────────────

class Notification(models.Model):
    NOTIFICATION_TYPES = [
        ('project',       'New Project'),
        ('participation', 'Project Participation'),
        ('comment',       'New Comment'),
        ('update',        'Project Update'),
        ('tender',        'Tender Alert'),
        ('issue',         'Issue Reported'),
        ('ai',            'AI Recommendation'),
        ('system',        'System Alert'),
    ]

    user              = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications', null=True)
    notification_type = models.CharField(max_length=20, choices=NOTIFICATION_TYPES, null=True)
    title             = models.CharField(max_length=255, null=True)
    message           = models.TextField(null=True)
    link              = models.CharField(max_length=255, null=True, blank=True)
    is_read           = models.BooleanField(default=False)
    created_at        = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.title} -> {self.user}"


class AuditLog(models.Model):
    user       = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    action     = models.CharField(max_length=255)
    model_name = models.CharField(max_length=100, null=True, blank=True)
    object_id  = models.IntegerField(null=True, blank=True)
    changes    = models.JSONField(default=dict, blank=True)
    timestamp  = models.DateTimeField(auto_now_add=True)
    project    = models.ForeignKey(Project, on_delete=models.SET_NULL, null=True, blank=True)
    ip_address = models.GenericIPAddressField(null=True, blank=True)

    class Meta:
        ordering = ['-timestamp']

    def __str__(self):
        return f"{self.user} — {self.action} — {self.timestamp}"


class Announcement(models.Model):
    LEVEL_CHOICES = [
        ('info',     'Info'),
        ('warning',  'Warning'),
        ('critical', 'Critical'),
        ('success',  'Success'),
    ]
    title      = models.CharField(max_length=255)
    message    = models.TextField()
    level      = models.CharField(max_length=20, choices=LEVEL_CHOICES)
    is_active  = models.BooleanField(default=True)
    target_roles = models.JSONField(default=list, blank=True)  # [] = all users
    expires_at = models.DateTimeField(null=True, blank=True)
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


# ─────────────────────────────────────────────
# RISK MANAGEMENT
# ─────────────────────────────────────────────

class ProjectRisk(models.Model):
    RISK_LEVELS = [('low', 'Low'), ('medium', 'Medium'), ('high', 'High'), ('critical', 'Critical')]
    STATUS_CHOICES = [('open', 'Open'), ('mitigated', 'Mitigated'), ('closed', 'Closed')]

    project          = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='risks')
    risk_description = models.TextField(null=True)
    risk_level       = models.CharField(max_length=10, choices=RISK_LEVELS)
    likelihood       = models.CharField(max_length=10, choices=RISK_LEVELS, null=True, blank=True)
    impact_rating    = models.CharField(max_length=10, choices=RISK_LEVELS, null=True, blank=True)
    mitigation_plan  = models.TextField(null=True, blank=True)
    owner            = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    status           = models.CharField(max_length=10, choices=STATUS_CHOICES, default='open')
    created_at       = models.DateTimeField(auto_now_add=True)
    updated_at       = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Risk for {self.project.project_title} — {self.risk_level}"


# ─────────────────────────────────────────────
# STAKEHOLDERS & TEAMS
# ─────────────────────────────────────────────

class Stakeholder(models.Model):
    name            = models.CharField(max_length=255)
    contact_details = models.TextField()
    role_in_program = models.TextField()
    project         = models.ForeignKey(Project, related_name='stakeholder_list', on_delete=models.CASCADE, null=True, default=True)
    organization    = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        return self.name


class Team(models.Model):
    name        = models.CharField(max_length=100)
    role        = models.CharField(max_length=100)
    image       = models.ImageField(upload_to='team/', null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    facebook    = models.URLField(blank=True, null=True)
    instagram   = models.URLField(blank=True, null=True)
    twitter     = models.URLField(blank=True, null=True)
    linkedin    = models.URLField(blank=True, null=True)
    whatsapp    = models.CharField(max_length=20, blank=True, null=True)
    created_at  = models.DateTimeField(auto_now_add=True, null=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return self.name


# ─────────────────────────────────────────────
# AI INTEGRATION
# ─────────────────────────────────────────────

class AIChatSession(models.Model):
    user       = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='ai_chat_sessions')
    title      = models.CharField(max_length=120, default='New Conversation')
    context    = models.JSONField(default=dict, blank=True)  # pinned project, filters, etc.
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-updated_at']

    def __str__(self):
        return f"{self.user.username}: {self.title}"


class AIChatMessage(models.Model):
    ROLE_CHOICES = [('user', 'User'), ('assistant', 'Assistant'), ('system', 'System')]

    session    = models.ForeignKey(AIChatSession, on_delete=models.CASCADE, related_name='messages')
    role       = models.CharField(max_length=12, choices=ROLE_CHOICES)
    content    = models.TextField()
    model      = models.CharField(max_length=100, blank=True)
    tokens     = models.IntegerField(null=True, blank=True)
    feedback   = models.CharField(max_length=10, choices=[('good', 'Good'), ('bad', 'Bad')], null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at']


class AIIssueAssessment(models.Model):
    REVIEW_CHOICES = [
        ('pending',  'Pending Staff Review'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
    ]

    issue              = models.ForeignKey(ReportIssue, on_delete=models.CASCADE, related_name='ai_assessments')
    category           = models.CharField(max_length=50)
    urgency            = models.CharField(max_length=20)
    confidence         = models.PositiveSmallIntegerField(default=0)
    summary            = models.TextField()
    recommended_action = models.TextField()
    model              = models.CharField(max_length=100, blank=True)
    provider           = models.CharField(max_length=30, default='heuristic')
    review_status      = models.CharField(max_length=20, choices=REVIEW_CHOICES, default='pending')
    reviewed_by        = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='reviewed_ai_assessments')
    reviewed_at        = models.DateTimeField(null=True, blank=True)
    created_at         = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"AI Assessment for Issue #{self.issue_id} ({self.urgency})"


class AIProjectAnalysis(models.Model):
    """AI-generated analytical insight for a project."""
    ANALYSIS_TYPES = [
        ('risk',         'Risk Analysis'),
        ('completion',   'Completion Prediction'),
        ('budget',       'Budget Analysis'),
        ('performance',  'Performance Review'),
        ('sentiment',    'Citizen Sentiment'),
    ]

    project       = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='ai_analyses')
    analysis_type = models.CharField(max_length=20, choices=ANALYSIS_TYPES)
    summary       = models.TextField()
    data          = models.JSONField(default=dict)  # structured output from AI
    confidence    = models.FloatField(default=0)
    model         = models.CharField(max_length=100, blank=True)
    created_at    = models.DateTimeField(auto_now_add=True)
    is_latest     = models.BooleanField(default=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.get_analysis_type_display()} for {self.project.project_title}"


class AISearchLog(models.Model):
    """Log AI-powered searches for improvement."""
    user       = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    query      = models.TextField()
    results    = models.JSONField(default=list)
    model      = models.CharField(max_length=100, blank=True)
    latency_ms = models.IntegerField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Search: {self.query[:50]}"


class AIReportGeneration(models.Model):
    """Track AI-generated report summaries."""
    STATUS_CHOICES = [
        ('pending',   'Pending'),
        ('generated', 'Generated'),
        ('failed',    'Failed'),
    ]

    project      = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='ai_reports', null=True)
    requested_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    report_type  = models.CharField(max_length=50)
    prompt       = models.TextField(blank=True)
    output       = models.TextField(blank=True)
    status       = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    model        = models.CharField(max_length=100, blank=True)
    created_at   = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"AI Report ({self.report_type}) — {self.project}"


# ─────────────────────────────────────────────
# ACTIVITY TRACKING & IMPACT
# ─────────────────────────────────────────────

class Activity(models.Model):
    project       = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='activities')
    title         = models.CharField(max_length=255)
    description   = models.TextField()
    activity_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Activity: {self.title} for {self.project.project_title}"


class ProgramImpact(models.Model):
    project          = models.ForeignKey(Project, related_name='impacts', on_delete=models.CASCADE)
    metric_name      = models.CharField(max_length=255)
    metric_value     = models.FloatField()
    unit             = models.CharField(max_length=50, null=True, blank=True)
    measurement_date = models.DateField()
    verified         = models.BooleanField(default=False)

    def __str__(self):
        return f"Impact: {self.metric_name} for {self.project.project_title}"


class ProjectUpdate(models.Model):
    project     = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='updates')
    title       = models.CharField(max_length=255)
    description = models.TextField()
    image       = models.ImageField(upload_to='project_updates/', null=True, blank=True)
    posted_by   = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    update_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Update: {self.title} for {self.project.project_title}"


class ProjectReport(models.Model):
    project      = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='reports')
    report_title = models.CharField(max_length=255)
    report_file  = models.FileField(upload_to='project_reports/')
    report_date  = models.DateTimeField(auto_now_add=True)
    prepared_by  = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return f"Report: {self.report_title} for {self.project.project_title}"


# ─────────────────────────────────────────────
# MISC SUPPORTING MODELS
# ─────────────────────────────────────────────

class Project_type(models.Model):
    name          = models.CharField(max_length=100)
    description   = models.TextField(blank=True)
    is_active     = models.BooleanField(default=True)
    created_by    = models.ForeignKey(User, on_delete=models.SET_NULL, blank=True, null=True, related_name='project_types_created')
    project_Types = models.ManyToManyField(Project, related_name='project_types', blank=True)
    created_at    = models.DateTimeField(auto_now_add=True, null=True)
    updated_at    = models.DateTimeField(auto_now=True, null=True)

    def __str__(self):
        return self.name


class Project_Division(models.Model):
    project_name = models.ManyToManyField(Project, related_name='project_list')
    project_type = models.ForeignKey(Project_type, on_delete=models.SET_NULL, null=True, related_name='divisions')

    def __str__(self):
        first = self.project_name.first()
        return first.project_title if first else "No Project"
