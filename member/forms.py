
from django import forms
from django.forms import ModelForm
from .models import PDF, AuditLog, Milestone, Notification, Comment, ProgramFunding, ProgramImpact,ProgressReport, Project_type, ProjectLocation, ProjectStage, ReportIssue, Tender, User, Project_type,contact,Feedback,Project,Project_Division
from django.contrib.auth.forms import UserCreationForm


class MyUserCreationForm(UserCreationForm):
    
    class Meta:
        model = User
        fields = ['name', 'username', 'email', 'role','bio','profile','is_enduser']

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if User.objects.filter(email=email).exclude(username=self.instance.username).exists():
            raise forms.ValidationError("This email is already taken.")
        return email
        
        
class ContactUsForm(ModelForm):
    
    class Meta:
        model = contact
        fields = '__all__'
        
class FeedbackForm(ModelForm):
    class Meta:
        model= Feedback
        fields= '__all__'
        
        
class ProjectCreationForm(ModelForm):
    class Meta:
        model= Project
        fields='__all__'
        
        
class ProjectDivisionForm(ModelForm):
    class Meta:
        model= Project_Division
        fields='__all__'
        
        
class ProjectTypeForm(ModelForm):
    class Meta:
        model= Project_type
        fields='__all__'
        

class PdfForm(ModelForm):
    class Meta:
        model=PDF
        fields='__all__'
        

       

class PdfForm(ModelForm):
    class Meta:
        model = PDF
        fields = ['project_title', 'project_status', 'implementing_agency', 'pdf_file']



class MilestoneForm(ModelForm):
    class Meta:
        model = Milestone
        fields = '__all__'

from django import forms
from .models import Media

class MediaForm(ModelForm):
    class Meta:
        model = Media
        fields = '__all__'

class NotificationForm(ModelForm):
    
    class Meta:
        model = Notification
        fields = "__all__"



class ProgressReportForm(forms.ModelForm):
    class Meta:
        model = ProgressReport
        fields = ['report_title', 'description', 'report_file']

class TenderForm(forms.ModelForm):
    class Meta:
        model = Tender
        fields = ['title', 'description', 'document']

class ReportIssueForm(forms.ModelForm):
    class Meta:
        model = ReportIssue
        fields = '__all__'
class ProjectLocationForm(forms.ModelForm):
    class Meta:
        model = ProjectLocation
        fields = ['name', 'description', 'latitude', 'longitude']

from django import forms
from .models import Comment

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = '__all__'
        
class AuditLogForm(ModelForm):
    class Meta:
        model= AuditLog
        fields='__all__'

class ProjectStageForm(forms.ModelForm):
    class Meta:
        model = ProjectStage
        fields = '__all__'

class ProgramFundingForm(forms.ModelForm):
    class Meta:
        model = ProgramFunding
        fields = '__all__'

class ProgramImpactForm(forms.ModelForm):
    class Meta:
        model = ProgramImpact
        fields = '__all__'


