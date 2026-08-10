
from django import forms
from django.forms import ModelForm
from .models import PDF, AuditLog, Budget, Contractor, GovernmentRequest, Milestone, Notification, Comment, Participation, ProgramFunding, ProgramImpact,ProgressReport, ProjectDocument,  ProjectStage, ReportIssue, Team, Tender, TenderApplication, Testimonial, User, Project_type, Contact, Feedback, Project, Project_Division
from django.contrib.auth.forms import UserCreationForm
from .models import Media

class MyUserCreationForm(UserCreationForm):

    class Meta:
        model = User
        fields = ['name', 'username', 'email', 'role', 'bio', 'profile', 'is_enduser']
        widgets = {
            'name': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'Enter your full name'
            }),
            'username': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'Choose a username'
            }),
            'email': forms.EmailInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'name@example.com'
            }),
            'role': forms.Select(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200'
            }),
            'bio': forms.Textarea(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'rows': 4,
                'placeholder': 'Tell us a little about yourself'
            }),
            'profile': forms.ClearableFileInput(attrs={
                'class': 'block w-full rounded-2xl border border-dashed border-slate-300 bg-slate-50 px-4 py-3 text-sm text-slate-600 file:mr-4 file:rounded-full file:border-0 file:bg-emerald-600 file:px-4 file:py-2 file:text-sm file:font-semibold file:text-white hover:file:bg-emerald-700'
            }),
            'is_enduser': forms.CheckboxInput(attrs={
                'class': 'h-4 w-4 rounded border-slate-300 text-emerald-600 focus:ring-emerald-500'
            }),
        }

    def clean_email(self):
        email = self.cleaned_data.get("email")
        if email and User.objects.filter(email=email).exclude(username=self.instance.username).exists():
            raise forms.ValidationError("This email is already taken.")
        return email

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")

        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords do not match.")
        if password1 and len(password1) < 8:
            raise forms.ValidationError("Password must be at least 8 characters long.")
        return password2
        
class participationForm(ModelForm):
    class Meta:
        model = Participation
        fields =['content']
                
class ContactUsForm(ModelForm):
    
    class Meta:
        model = Contact
        fields = '__all__'
        
        
class TestimonialForm(ModelForm):
    class Meta:
        model= Testimonial
        fields = ['name', 'phone_number', 'project', 'rating', 'content', 'image']
        widgets = {
            'content': forms.Textarea(attrs={'rows': 5}),
            'rating': forms.Select(choices=[(i, f'{i} star' + ('s' if i != 1 else '')) for i in range(1, 6)]),
        }
        
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
        

       



class MilestoneForm(forms.ModelForm):
    class Meta:
        model = Milestone
        fields = [
            'project',
            'stage',
            'title',
            'description',
            'progress_percentage'
        ]

        widgets = {
            'project': forms.Select(attrs={
                'class': 'w-full border rounded-lg p-3'
            }),
            'title': forms.TextInput(attrs={
                'class': 'w-full border rounded-lg p-3'
            }),

            'description': forms.Textarea(attrs={
                'class': 'w-full border rounded-lg p-3',
                'rows': 4
            }),

            'stage': forms.Select(attrs={
                'class': 'w-full border rounded-lg p-3'
            }),

            'progress_percentage': forms.NumberInput(attrs={
                'class': 'w-full border rounded-lg p-3',
                'min': 0,
                'max': 100
            }),
        }

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
        fields = ['project','reference_number', 'description', 'document', 'estimated_budget', 'opening_date', 'closing_date', 'eligibility_criteria', 'evaluation_criteria', 'procurement_method']

class TenderApplicationForm(forms.ModelForm):
    
    class Meta:
        model = TenderApplication
        fields = ['company_name',
            'company_email',
            'company_phone',
            'bid_amount',
            'proposal_document',
            'cover_letter',]

class ReportIssueForm(forms.ModelForm):
    class Meta:
        model = ReportIssue
        fields = ['title', 'project', 'issue_description', 'evidence']
        widgets = {
            'issue_description': forms.Textarea(attrs={'rows': 5}),
        }


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

class ProjectDocumentForm(forms.ModelForm):
    class Meta:
        model = ProjectDocument
        fields = ['name', 'file']
        
class TeamsForm(forms.ModelForm):
    class Meta:
        model = Team
        fields = '__all__'
        

class BudgetForm(forms.ModelForm):
    class Meta:
        model = Budget
        fields = '__all__'

        
class contractorForm(forms.ModelForm):
    class Meta:
        model = Contractor
        fields = '__all__'
        

class GovernmentRequestForm(forms.ModelForm):
    class Meta:
        model = GovernmentRequest
        fields = ['title', 'description', 'category', 'location', 'image']
        widgets = {
            'title': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'e.g. County Road Rehabilitation Project'
            }),
            'description': forms.Textarea(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'rows': 5,
                'placeholder': 'Describe the project scope, proposed impact, and public benefit.'
            }),
            'category': forms.Select(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200'
            }),
            'location': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'County, sub-county, ward or site'
            }),
            'image': forms.ClearableFileInput(attrs={
                'class': 'block w-full rounded-2xl border border-dashed border-slate-300 bg-slate-50 px-4 py-3 text-sm text-slate-600 file:mr-4 file:rounded-full file:border-0 file:bg-emerald-600 file:px-4 file:py-2 file:text-sm file:font-semibold file:text-white hover:file:bg-emerald-700'
            }),
        }

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)

    def save(self, commit=True):
        instance = super().save(commit=False)
        if self.request and self.request.user.is_authenticated:
            instance.citizen = self.request.user
        elif self.request:
            guest_user, _ = User.objects.get_or_create(
                username='guest-project-submitter',
                defaults={
                    'email': 'guest-project-submitter@example.com',
                    'name': 'Guest Project Submitter',
                    'role': 'citizen',
                    'is_enduser': True,
                    'is_verified': False,
                },
            )
            instance.citizen = guest_user
        if commit:
            instance.save()
        return instance
