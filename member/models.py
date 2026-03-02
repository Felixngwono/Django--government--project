from django.db import models
from django.contrib.auth.models import AbstractUser

# 🔹 User Model (Custom User with Roles)
class User(AbstractUser):
    ROLE_CHOICES = [
        ('citizen', 'Citizen'),
        ('official', 'Government Official'),
        ('contractor', 'Contractor'),
        ('engineer', 'Engineer'),
        ('architect', 'Architect'),
        ('surveyor', 'Surveyor'),
        ('planner', 'Urban Planner'),
        ('developer', 'Software Developer'),
        ('analyst', 'Data Analyst'),
        ('manager', 'Project Manager'),
        ('others', 'others'),
        ('staff', 'Staff'),
        ('guest', 'Guest'),
        
        
            ]
    
    email = models.EmailField(unique=True, null=True)
    username = models.CharField(max_length=20, unique=True)
    name = models.CharField(max_length=50, null=True)
    role = models.CharField(max_length=20, choices=ROLE_CHOICES, default='citizen')
    bio = models.TextField(null=True, blank=True)
    is_enduser = models.BooleanField(default=False)
    avatar = models.ImageField(null=True, blank=True, upload_to='avatars/', default="avatar.png")
    profile = models.ImageField(null=True, blank=True, upload_to='profiles/', default="avatar.png")
    updated=models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']

    def __str__(self):
        return self.username

# 🔹 Contact Model
class contact(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    message = models.TextField()
    
    def __str__(self):
        return self.name

# 🔹 Feedback Model
class Feedback(models.Model):
    full_name = models.CharField(max_length=50, null=True)
    email = models.EmailField()
    phone_number = models.CharField(max_length=15, null=True)  # Fixed data type
    feedback = models.TextField(null=True)

    def __str__(self):
        return self.full_name if self.full_name else "Feedback"

# 🔹 Project Type Model
class Project_type(models.Model):
    name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.name

# 🔹 Project Division Model


    


# 🔹 Project Model
class Project(models.Model):
    project_status = [
        ('ongoing', 'Ongoing'),
        ('upcoming', 'Upcoming'),
        ('completed', 'Completed'),
        ('Delayed', 'Delayed'),


    ]

    project_title = models.CharField(max_length=100,null=True)
    project_description = models.TextField(null=True)
    project_location = models.CharField(max_length=100,null=True)
    implementing_agency = models.CharField(max_length=100,null=True)
    project_Budgeting = models.CharField(max_length=15,null=True)  # Improved data type
    images = models.ImageField(null=True, blank=True, upload_to='projects/')
    start_date = models.DateField(null=True, blank=True)
    end_date = models.DateField(null=True, blank=True)
    beneficiaries = models.TextField(null=True)
    stakeholders = models.TextField(null=True)  # List of agencies involved
    impact = models.TextField(blank=True, null=True)
    progress = models.TextField(blank=True, null=True)  # Ongoing updates on progress
    project_status= models.CharField(max_length=10,choices=project_status)
    project_type = models.ForeignKey(Project_type, on_delete=models.SET_NULL, null=True)
    impact = models.TextField(null=True, blank=True)
    project_manager=models.CharField(max_length=100,null=True, blank=True)
    project_contractor=models.CharField(max_length=100,null=True, blank=True)
    contact_email=models.EmailField(null=True, blank=True)
    progress_update=models.CharField(max_length=255,null=True, blank=True)
    remarks=models.TextField(null=True, blank=True)
    
    class Meta:
        ordering = ['-start_date']

    def __str__(self):
        return self.project_title
    
class Project_Division(models.Model):
    project_name = models.ManyToManyField(Project, related_name="project_list")
    project_type = models.ForeignKey(Project_type, on_delete=models.SET_NULL, null=True, related_name="divisions")

    def __str__(self):
        return self.name.first().project_title if self.name.exists() else "No Project"
class Participation(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    project = models.ForeignKey(Project, on_delete=models.CASCADE)
    content= models.TextField(null=True, blank=True)  # Optional field for user comments or feedback
    joined_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)


    def __str__(self):
        return f"{self.user.username} - {self.project.project_title}"
     


class ProjectStage(models.Model):
    STAGES = [
        ('planning', 'Planning'),
        ('procurement', 'Procurement'),
        ('construction', 'Construction'),
        ('completion', 'Completion'),
        ('monitoring', 'Monitoring'),
        ('evaluation', 'Evaluation'),
        ('others', 'Others'),

    ]

    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='stages')
    stage_name = models.CharField(max_length=20, choices=STAGES)
    description = models.TextField(null=True, blank=True)
    start_date = models.DateField(null=True, blank=True)
    end_date = models.DateField(null=True, blank=True)
    progress_percentage = models.DecimalField(max_digits=5, decimal_places=2, default=0.00)

    def __str__(self):
        return f"{self.project.project_title} - {self.get_stage_name_display()}"

# 🔹 Progress Update Model (Tracks Project Progress )
# 🔹 Program Funding Model

# 🔹 Model for tracking progress and impact metrics for programs
class ProgramImpact(models.Model):
    project = models.ForeignKey(Project, related_name="impacts", on_delete=models.CASCADE)
    metric_name = models.CharField(max_length=255)
    metric_value = models.FloatField()
    measurement_date = models.DateField()

    def __str__(self):
        return f"Impact: {self.metric_name} for {self.project.project_title}"
    


class ProgressUpdate(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='progress_updates')
    stage = models.ForeignKey(ProjectStage, on_delete=models.CASCADE, related_name='progress_updates', null=True, blank=True)
    description = models.TextField()
    date_reported = models.DateTimeField(auto_now_add=True)
    progress_percentage = models.IntegerField(default=0)

    def __str__(self):
        return f"Progress for {self.project.project_title} - {self.progress_percentage}%"

# 🔹 Milestone Model (Tracks Project Progress)
class Milestone(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='milestones')
    stage = models.ForeignKey(ProjectStage, on_delete=models.CASCADE, related_name='milestones', null=True, blank=True)
    title = models.CharField(max_length=255)
    description = models.TextField()
    completion_date = models.DateField(auto_now=True,null=True, blank=True)
    progress_percentage = models.IntegerField(default=0)

    def __str__(self):
        return f"{self.project.project_title} - {self.title}"


# 🔹 Notification Model (Alerts for Users)
class Notification(models.Model):
    recipient = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    message = models.TextField()
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Notification for {self.recipient.username}"

# 🔹 Budget Model (For Tracking Expenses)
class Budget(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='budget')
    allocated_amount = models.DecimalField(max_digits=15, decimal_places=2)
    spent_amount = models.DecimalField(max_digits=15, decimal_places=2, default=0.00)
    last_updated = models.DateTimeField(auto_now=True)

    def remaining_budget(self):
        return self.allocated_amount - self.spent_amount
    
    def __str__(self):
        return f"Budget for {self.project.project_title}"



# 🔹 Media & Documents Model (Stores PDFs, Images, Videos)
class Media(models.Model):
    MEDIA_TYPES = [
        ('image', 'Image'),
        ('video', 'Video'),
        ('pdf', 'PDF Document'),
    ]
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='media',null=True)

    file = models.FileField(upload_to='project_media/')
    media_type = models.CharField(max_length=10, choices=MEDIA_TYPES, default='image')
    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Media for {self.project.project_title}"

# 🔹 PDF Model (Official Project Documents)
class PDF(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='pdfs', null=True, blank=True)
    title = models.CharField(max_length=255,null=True)
    document = models.FileField(upload_to='pdfs/document', blank=True, null=True)
    uploaded_at = models.DateTimeField(auto_now_add=True,null=True)
    project_title = models.CharField(max_length=255, null=True)
    project_status = models.CharField(max_length=100 ,null=True)
    implementing_agency = models.CharField(max_length=255, null=True)
    
    # Field to store the actual PDF file
    pdf_file = models.FileField(upload_to='pdfs/', blank=True, null=True)
    def __str__(self):
        return self.title


class AuditLog(models.Model):
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    action = models.CharField(max_length=255)  # e.g., "Project Updated"
    timestamp = models.DateTimeField(auto_now_add=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=True, blank=True)

    class Meta:
        ordering = ['-timestamp']

    def __str__(self):
        return f"{self.user} - {self.action} - {self.timestamp}"


class Comment(models.Model):
    name=models.CharField(max_length=1000,null=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering=['-created_at']

    def __str__(self):
        return f"Comment by {self.user.username} on {self.project.project_title}"

class ProjectDocument(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='documents')
    name = models.CharField(max_length=200)
    file = models.FileField(upload_to='project_docs/')
    uploaded_at = models.DateTimeField(auto_now_add=True)


class ProgressReport(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='progress_reports')
    description = models.TextField()
    report_title = models.CharField(max_length=255)
    report_file = models.FileField(upload_to='progress_reports/')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Report: {self.report_title} - {self.project.project_title}"

class Tender(models.Model):

    PROCUREMENT_METHODS = [
        ('open', 'Open Tender'),
        ('restricted', 'Restricted Tender'),
        ('rfq', 'Request for Quotation'),
        ('direct', 'Direct Procurement'),
    ]

    STATUS_CHOICES = [
        ('draft', 'Draft'),
        ('published', 'Published'),
        ('closed', 'Closed'),
        ('evaluating', 'Evaluating'),
        ('awarded', 'Awarded'),
        ('cancelled', 'Cancelled'),
    ]

    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='tenders',null=True, blank=True)
    reference_number = models.CharField(max_length=100, unique=True, null=True, blank=True, default=None)

    description = models.TextField(null=True, blank=True)

    procurement_method = models.CharField(max_length=20, choices=PROCUREMENT_METHODS, default='open')

    estimated_budget = models.DecimalField(max_digits=15, decimal_places=2, null=True, blank=True)

    opening_date = models.DateField(default=None, null=True, blank=True)
    closing_date = models.DateField(default=None, null=True, blank=True)

    eligibility_criteria = models.TextField(null=True, blank=True)
    evaluation_criteria = models.TextField(null=True, blank=True)

    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='draft')

    document = models.FileField(upload_to='tenders/', null=True, blank=True)

    created_by = models.ForeignKey(User, null=True, related_name='created_tenders', blank=True,on_delete=models.SET_NULL, default=None)

    is_published = models.BooleanField(default=False)

    created_at = models.DateTimeField(auto_now_add=True,null=True, blank=True)

    def __str__(self):
        return f"{self.reference_number} - {self.title}"
    
class TenderApplication(models.Model):

    STATUS = [
        ('submitted', 'Submitted'),
        ('under_review', 'Under Review'),
        ('qualified', 'Qualified'),
        ('rejected', 'Rejected'),
        ('awarded', 'Awarded'),
    ]

    tender = models.ForeignKey(Tender, on_delete=models.CASCADE, related_name='applications')
    contractor = models.ForeignKey(User, on_delete=models.CASCADE, limit_choices_to={'role': 'contractor'})

    technical_proposal = models.FileField(upload_to='tender_applications/technical/')
    financial_proposal = models.FileField(upload_to='tender_applications/financial/')

    bid_amount = models.DecimalField(max_digits=15, decimal_places=2)

    status = models.CharField(max_length=20, choices=STATUS, default='submitted')

    submitted_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.contractor.username} - {self.tender.reference_number}"

class ReportIssue(models.Model):
    title = models.CharField(max_length=255, null=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='issues')
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    issue_description = models.TextField()
    evidence = models.FileField(upload_to='issue_evidence/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    resolved = models.BooleanField(default=False)
    status = models.CharField(
        max_length=20,
        choices=[('Pending', 'Pending'), ('Resolved', 'Resolved')],
        default='Pending'
    )
    def __str__(self):
        return f"Issue on {self.project.project_title} by {self.user.username if self.user else 'Anonymous'}"

class Stakeholder(models.Model):
    name = models.CharField(max_length=255)
    contact_details = models.TextField()
    role_in_program = models.TextField()
    program = models.ForeignKey(Project, related_name="stakeholder", on_delete=models.CASCADE)

    def __str__(self):
        return self.name

# Track the program's funding history
class ProgramFunding(models.Model):  # noqa: F811
    project = models.ForeignKey(Project, related_name="funding", on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    funding_source = models.CharField(max_length=255)  # Government agency, partnership, etc.
    date_funded = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Funding: {self.amount} for {self.project.project_title}"

# Model for tracking progress and impact metrics for programs


class Testimonial(models.Model):
    name = models.CharField(max_length=100,null=True)
    content= models.TextField(null=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, null=True, blank=True)
    phone_number = models.CharField(max_length=15, null=True, blank=True)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='testimonials',null=True)
    image = models.ImageField(upload_to='testimonials/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"Testimonial by {self.name} for {self.project.project_title}"
    
class ProjectUpdate(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='updates')
    title = models.CharField(max_length=255)
    description = models.TextField()
    update_date = models.DateTimeField(auto_now_add=True)
    image = models.ImageField(upload_to='project_updates/', null=True, blank=True)

    def __str__(self):
        return f"Update: {self.title} for {self.project.project_title}"
    
class ProjectReport(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='reports')
    report_file = models.FileField(upload_to='project_reports/')
    report_date = models.DateTimeField(auto_now_add=True)
    report_title = models.CharField(max_length=255)

    def __str__(self):
        return f"Report: {self.report_title} for {self.project.project_title}"
    
class ProjectBudget(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='budgets')
    allocated_budget = models.DecimalField(max_digits=15, decimal_places=2)
    spent_budget = models.DecimalField(max_digits=15, decimal_places=2, default=0.00)
    budget_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Budget for {self.project.project_title}"
    def remaining_budget(self):
        return self.allocated_budget - self.spent_budget
   
class ProjectExpense(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='expenses')
    amount = models.DecimalField(max_digits=15, decimal_places=2)
    description = models.TextField()
    expense_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Expense for {self.project.project_title} - {self.amount}"

class ProjectRisk(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='risks')
    risk_description = models.TextField()
    risk_level = models.CharField(max_length=20, choices=[('low', 'Low'), ('medium', 'Medium'), ('high', 'High')])
    mitigation_plan = models.TextField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Risk for {self.project.project_title} - {self.risk_level}"
    

    
class Team(models.Model):
    name=models.CharField(max_length=100)
    role=models.CharField(max_length=100)
    image=models.ImageField(upload_to='team/', null=True, blank=True)
    created_at=models.DateTimeField(auto_now_add=True,null=True,blank=True)
    description=models.TextField(null=True, blank=True)
    
    # Social media handles
    facebook = models.URLField(blank=True, null=True)
    instagram = models.URLField(blank=True, null=True)
    twitter = models.URLField(blank=True, null=True)
    linkedin = models.URLField(blank=True, null=True)
    whatsapp = models.CharField(max_length=20, blank=True, null=True)

    
    class Meta:
        ordering=['-created_at']

    def __str__(self):
        return self.name
    
class Activity(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='activities')
    title = models.CharField(max_length=255)
    description = models.TextField()
    activity_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Activity: {self.title} for {self.project.project_title}"