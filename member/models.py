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
class Project_Division(models.Model):
    name = models.CharField(max_length=100)
    project_type = models.ForeignKey(Project_type, on_delete=models.SET_NULL, null=True, related_name="divisions")

    def __str__(self):
        return self.name

    


# 🔹 Project Model
class Project(models.Model):
    project_status = [
        ('ongoing', 'Ongoing'),
        ('upcoming', 'Upcoming'),
        ('completed', 'Completed'),
        ('stalled', 'Stalled'),
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
    division = models.ForeignKey(Project_Division, on_delete=models.SET_NULL, null=True, blank=True)

    class Meta:
        ordering = ['-start_date']

    def __str__(self):
        return self.project_title

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
class ProgramFunding(models.Model):
    project = models.ForeignKey(Project, related_name="funding", on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    funding_source = models.CharField(max_length=255)  # Government agency, partnership, etc.
    date_funded = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Funding: {self.amount} for {self.project.project_title}"

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

    def __str__(self):
        return f"Comment by {self.user.username} on {self.project.project_title}"


class ProgressReport(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='progress_reports')
    description = models.TextField()
    report_title = models.CharField(max_length=255)
    report_file = models.FileField(upload_to='progress_reports/')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Report: {self.report_title} - {self.project.project_title}"

class Tender(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='tenders',null=True)
    title = models.CharField(max_length=255,null=True)
    description = models.TextField(null=True)
    opening_date = models.DateField(null=True)
    closing_date = models.DateField(null=True)
    document = models.FileField(upload_to='tenders/', null=True, blank=True)
    def __str__(self):
        return f"Tender: {self.title} for {self.project.project_title}"


class ProjectLocation(models.Model):
    project = models.OneToOneField(Project, on_delete=models.CASCADE, related_name='location')
    latitude = models.DecimalField(max_digits=9, decimal_places=1, null=True, blank=True)
    longitude = models.DecimalField(max_digits=9, decimal_places=1, null=True, blank=True)
    name = models.CharField(max_length=255, null=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"Location for {self.project.project_title}"

    def google_maps_link(self):
        """Returns a Google Maps link for this location."""
        if self.latitude and self.longitude:
            return f"https://www.google.com/maps/search/?api=1&query={self.latitude},{self.longitude}"
        return None



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
class ProgramFunding(models.Model):
    project = models.ForeignKey(Project, related_name="funding", on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=12, decimal_places=2)
    funding_source = models.CharField(max_length=255)  # Government agency, partnership, etc.
    date_funded = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Funding: {self.amount} for {self.project.project_title}"

# Model for tracking progress and impact metrics for programs
class ProgramImpact(models.Model):
    program = models.ForeignKey(Project, related_name="impacts", on_delete=models.CASCADE)
    metric_name = models.CharField(max_length=255)
    metric_value = models.FloatField()
    measurement_date = models.DateField()

    def __str__(self):
        return f"Impact: {self.metric_name} for {self.program.name}"
    
class ProgressUpdate(models.Model):
    project = models.ForeignKey(Project, on_delete=models.CASCADE, related_name='progress_updates')
    stage = models.ForeignKey(ProjectStage, on_delete=models.CASCADE, related_name='progress_updates', null=True, blank=True)
    description = models.TextField()
    date_reported = models.DateTimeField(auto_now_add=True)
    progress_percentage = models.IntegerField(default=0)

    def __str__(self):
        return f"Progress for {self.project.project_title} - {self.progress_percentage}%"
