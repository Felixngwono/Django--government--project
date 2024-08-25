
from django import forms
from django.forms import ModelForm
from .models import PDF, Project_type, User, Project_type,contact,Feedback,Project,Project_Division
from django.contrib.auth.forms import UserCreationForm


class MyUserCreationForm(UserCreationForm):
    
    class Meta:
        model = User
        fields = ['name', 'username', 'email', 'bio','profile','is_enduser']
        
        
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