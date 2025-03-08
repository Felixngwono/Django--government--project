
from django import forms
from django.forms import ModelForm
from .models import PDF, Notification, Comment,ProgressReport, Project_type, ProjectLocation, ReportIssue, Tender, User, Project_type,contact,Feedback,Project,Project_Division
from django.contrib.auth.forms import UserCreationForm


class MyUserCreationForm(UserCreationForm):
    
    class Meta:
        model = User
        fields = ['name', 'username', 'email', 'role','bio','profile','is_enduser']
        
        
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
        fields = ['project_title', 'Project_status', 'implementing_agency', 'pdf_file']


from django import forms
from .models import Milestone

class MilestoneForm(forms.ModelForm):
    class Meta:
        model = Milestone
        fields = ['project', 'title', 'description', 'completion_date', 'progress_percentage']

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
        fields = ['project', 'issue_description', 'evidence']

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
        
