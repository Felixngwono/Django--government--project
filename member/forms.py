
from django import forms
from django.forms import ModelForm
from .models import PDF, AuditLog, Budget, CitizenEvidence, Contractor, GovernmentRequest, Milestone, Notification, Comment, Participation, ProgramFunding, ProgramImpact,ProgressReport, ProjectDocument,  ProjectStage, ReportIssue, Team, Tender, TenderApplication, Testimonial, User, Project_type, Contact, Feedback, Project, Project_Division, ProjectExpense
from django.contrib.auth.forms import UserCreationForm
from .models import Media

class MyUserCreationForm(UserCreationForm):

    class Meta:
        model = User
        # Publicly selectable roles. Privileged roles (admin, staff, official,
        # auditor, manager) are assigned internally only -- never at signup.
        SAFE_ROLE_CHOICES = [
            ('citizen',    'Citizen'),
            ('contractor', 'Contractor'),
            ('engineer',   'Engineer'),
            ('architect',  'Architect'),
            ('surveyor',   'Surveyor'),
            ('planner',    'Urban Planner'),
            ('developer',  'Software Developer'),
            ('analyst',    'Data Analyst'),
        ]
        fields = ['name', 'username', 'email', 'role', 'phone_number', 'bio', 'profile', 'is_enduser']
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
                'placeholder': 'Enter email or email@gmail.com'
            }),
            'phone_number': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': '+254 700 000 000'
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

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if 'role' in self.fields:
            self.fields['role'].choices = self.Meta.SAFE_ROLE_CHOICES

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
        fields = ['name', 'email', 'subject', 'message']
        widgets = {
            'name': forms.TextInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-200',
                'placeholder': 'Enter your full name'
            }),
            'email': forms.EmailInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-200',
                'placeholder': 'name@example.com'
            }),
            'subject': forms.TextInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-200',
                'placeholder': 'How can we help you?'
            }),
            'message': forms.Textarea(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-red-500 focus:ring-2 focus:ring-red-200',
                'rows': 5,
                'placeholder': 'Write your message here...'
            }),
        }


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


class MultipleImageInput(forms.ClearableFileInput):
    """File input that lets an officer select several evidence photos at once."""
    allow_multiple_selected = True


class MultipleImageField(forms.ImageField):
    """Validate every image selected by a multiple file input."""
    def clean(self, data, initial=None):
        if not data:
            return []
        files = data if isinstance(data, (list, tuple)) else [data]
        return [super(MultipleImageField, self).clean(file, initial) for file in files]


class ProjectCreationForm(ModelForm):
    evidence_images = MultipleImageField(
        required=False,
        widget=MultipleImageInput(attrs={
            'accept': 'image/*',
            'multiple': True,
        }),
        help_text='Add photos for project reference and evidence (up to 12 at a time).',
    )

    class Meta:
        model= Project
        fields='__all__'

    def clean_evidence_images(self):
        images = self.cleaned_data.get('evidence_images', [])
        if len(images) > 12:
            raise forms.ValidationError('Please upload no more than 12 images at a time.')
        return images


class ProjectDivisionForm(ModelForm):
    class Meta:
        model = Project_Division
        fields = [
            'name', 'code', 'project_type', 'description',
            'head_of_division', 'head_user', 'contact_email', 'contact_phone',
            'office_location', 'allocated_budget', 'image', 'is_active', 'project_name'
        ]
        widgets = {
            'name': forms.TextInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'placeholder': 'e.g. Infrastructure & Public Works Division'}),
            'code': forms.TextInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'placeholder': 'e.g. DIV-INFRA-01'}),
            'project_type': forms.Select(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm'}),
            'description': forms.Textarea(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'rows': 4, 'placeholder': 'Overview of division responsibilities, mandates and scope...'}),
            'head_of_division': forms.TextInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'placeholder': 'e.g. Dr. Jane Doe'}),
            'head_user': forms.Select(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm'}),
            'contact_email': forms.EmailInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'placeholder': 'division@gov.org'}),
            'contact_phone': forms.TextInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'placeholder': '+1 (555) 000-0000'}),
            'office_location': forms.TextInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'placeholder': 'Building A, Floor 4, Capital Complex'}),
            'allocated_budget': forms.NumberInput(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm', 'step': '0.01'}),
            'image': forms.FileInput(attrs={'class': 'w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100'}),
            'project_name': forms.SelectMultiple(attrs={'class': 'w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm min-h-[120px]'}),
            'is_active': forms.CheckboxInput(attrs={'class': 'w-5 h-5 text-blue-600 border-gray-300 rounded focus:ring-blue-500'}),
        }



class ProjectTypeForm(ModelForm):
    class Meta:
        model= Project_type
        fields='__all__'


class PdfForm(ModelForm):
    class Meta:
        model=PDF
        fields='__all__'






from django import forms

INLINE_INPUT_CLASSES = (
    'w-full rounded-xl border border-slate-300 bg-white px-3.5 py-2.5 text-sm text-slate-900 '
    'shadow-sm outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-200'
)


class MilestoneForm(forms.ModelForm):
    class Meta:
        model = Milestone
        fields = [
            'project',
            'stage',
            'title',
            'description',
            'due_date',
            'completion_date',
            'progress_percentage',
            'status'
        ]

        widgets = {
            'project': forms.Select(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm'
            }),
            'stage': forms.Select(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm'
            }),
            'title': forms.TextInput(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm',
                'placeholder': 'e.g. Environmental Impact Assessment Completed'
            }),
            'description': forms.Textarea(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm',
                'rows': 4,
                'placeholder': 'Provide detailed objective and key deliverables for this milestone...'
            }),
            'due_date': forms.DateInput(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm',
                'type': 'date'
            }),
            'completion_date': forms.DateInput(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm',
                'type': 'date'
            }),
            'progress_percentage': forms.NumberInput(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm',
                'min': 0,
                'max': 100,
                'placeholder': '0 - 100'
            }),
            'status': forms.Select(attrs={
                'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-sm'
            }),
        }

class MediaForm(forms.ModelForm):
    class Meta:
        model = Media
        fields = ['project', 'media_type', 'file', 'caption']
        widgets = {
            'project': forms.Select(attrs={'class': 'w-full px-4 py-2.5 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-indigo-500 font-sans text-sm'}),
            'media_type': forms.Select(attrs={'class': 'w-full px-4 py-2.5 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-indigo-500 font-sans text-sm'}),
            'caption': forms.TextInput(attrs={'class': 'w-full px-4 py-2.5 rounded-xl border border-slate-300 dark:border-slate-600 bg-white dark:bg-slate-800 text-slate-900 dark:text-white focus:ring-2 focus:ring-indigo-500 font-sans text-sm', 'placeholder': 'Brief description (e.g., Drone survey of Phase 1 site)'}),
            'file': forms.FileInput(attrs={'class': 'w-full px-4 py-2 rounded-xl border border-slate-300 dark:border-slate-600 text-sm text-slate-500 dark:text-slate-400 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100'}),
        }

class NotificationForm(ModelForm):

    class Meta:
        model = Notification
        fields = "__all__"



class ProgressReportForm(forms.ModelForm):
    class Meta:
        model = ProgressReport
        fields = ['report_title', 'description', 'report_file']
        widgets = {
            'report_title': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'e.g. Foundation works progress report — September 2026'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 6, 'placeholder': 'Summarise completed work, current progress, issues, next steps, and supporting evidence.'}),
            'report_file': forms.ClearableFileInput(attrs={'class': 'sr-only', 'accept': '.pdf,.doc,.docx,.xls,.xlsx,.jpg,.jpeg,.png'}),
        }

    def clean_report_file(self):
        report_file = self.cleaned_data['report_file']
        allowed_extensions = {'.pdf', '.doc', '.docx', '.xls', '.xlsx', '.jpg', '.jpeg', '.png'}
        extension = '.' + report_file.name.rsplit('.', 1)[-1].lower() if '.' in report_file.name else ''
        if extension not in allowed_extensions:
            raise forms.ValidationError('Upload a PDF, Office document, spreadsheet, JPG, or PNG file.')
        if report_file.size > 20 * 1024 * 1024:
            raise forms.ValidationError('The report file must be 20 MB or smaller.')
        return report_file

class TenderForm(forms.ModelForm):
    class Meta:
        model = Tender
        fields = ['title', 'project', 'reference_number', 'description', 'document', 'estimated_budget', 'opening_date', 'closing_date', 'eligibility_criteria', 'evaluation_criteria', 'procurement_method', 'status']
        widgets = {
            'opening_date': forms.DateInput(attrs={'type': 'date'}),
            'closing_date': forms.DateInput(attrs={'type': 'date'}),
            'description': forms.Textarea(attrs={'rows': 3}),
            'eligibility_criteria': forms.Textarea(attrs={'rows': 3}),
            'evaluation_criteria': forms.Textarea(attrs={'rows': 3}),
        }

class TenderApplicationForm(forms.ModelForm):

    class Meta:
        model = TenderApplication
        fields = ['company_name',
            'company_email',
            'company_phone',
            'bid_amount',
            'proposal_document',
            'cover_letter',]

class CitizenEvidenceForm(forms.ModelForm):
    class Meta:
        model = CitizenEvidence
        fields = [
            'project', 'stage', 'category', 'severity', 'evidence_type',
            'title', 'description', 'location', 'coordinates', 'observed_at',
            'notes', 'image'
        ]
        widgets = {
            'project': forms.Select(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none'}),
            'stage': forms.Select(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none'}),
            'category': forms.Select(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none'}),
            'severity': forms.Select(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none'}),
            'evidence_type': forms.Select(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none'}),
            'title': forms.TextInput(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none', 'placeholder': 'Evidence title'}),
            'description': forms.Textarea(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none', 'rows': 4, 'placeholder': 'Describe the condition or issue in detail'}),
            'location': forms.TextInput(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none', 'placeholder': 'Site or landmark name'}),
            'coordinates': forms.TextInput(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none', 'placeholder': 'Latitude, Longitude'}),
            'observed_at': forms.DateInput(attrs={'type': 'date', 'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none'}),
            'notes': forms.Textarea(attrs={'class': 'w-full border border-slate-300 rounded-xl px-3 py-2.5 text-sm focus:ring-2 focus:ring-blue-500 outline-none', 'rows': 3, 'placeholder': 'Additional notes for officials or reviewers'}),
            'image': forms.FileInput(attrs={'class': 'block w-full text-sm text-slate-500 file:mr-4 file:py-2 file:px-4 file:rounded-xl file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100'}),
        }


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


class MilestoneInlineForm(forms.ModelForm):
    """Compact milestone form for inline use on the project details page."""

    def __init__(self, *args, project=None, **kwargs):
        super().__init__(*args, **kwargs)
        # Only allow stages that belong to the current project.
        if project is not None:
            self.fields['stage'].queryset = project.stages.all()

    class Meta:
        model = Milestone
        fields = ['stage', 'title', 'description', 'due_date', 'progress_percentage', 'status']
        widgets = {
            'stage': forms.Select(attrs={'class': INLINE_INPUT_CLASSES}),
            'title': forms.TextInput(attrs={
                'class': INLINE_INPUT_CLASSES,
                'placeholder': 'e.g. Environmental Impact Assessment Completed',
            }),
            'description': forms.Textarea(attrs={
                'class': INLINE_INPUT_CLASSES, 'rows': 3,
                'placeholder': 'Objective and key deliverables...',
            }),
            'due_date': forms.DateInput(attrs={'class': INLINE_INPUT_CLASSES, 'type': 'date'}),
            'progress_percentage': forms.NumberInput(attrs={
                'class': INLINE_INPUT_CLASSES, 'min': 0, 'max': 100, 'placeholder': '0 - 100',
            }),
            'status': forms.Select(attrs={'class': INLINE_INPUT_CLASSES}),
        }


class ExpenseInlineForm(forms.ModelForm):
    """Compact expense form for inline use on the project details page."""
    class Meta:
        model = ProjectExpense
        fields = ['title', 'category', 'amount', 'description', 'receipt']
        widgets = {
            'title': forms.TextInput(attrs={
                'class': INLINE_INPUT_CLASSES,
                'placeholder': 'Expense description/title',
            }),
            'category': forms.Select(attrs={'class': INLINE_INPUT_CLASSES}),
            'amount': forms.NumberInput(attrs={
                'class': INLINE_INPUT_CLASSES, 'step': '0.01', 'min': '0', 'placeholder': '0.00',
            }),
            'description': forms.Textarea(attrs={
                'class': INLINE_INPUT_CLASSES, 'rows': 2,
                'placeholder': 'Details of this payment or expense item (optional)',
            }),
            'receipt': forms.ClearableFileInput(attrs={'class': 'w-full text-xs text-slate-500'}),
        }


class IssueInlineForm(forms.ModelForm):
    """Compact issue form for inline use on the project details page."""
    class Meta:
        model = ReportIssue
        fields = ['title', 'severity', 'issue_description', 'evidence']
        widgets = {
            'title': forms.TextInput(attrs={
                'class': INLINE_INPUT_CLASSES,
                'placeholder': 'Short summary of the issue',
            }),
            'severity': forms.Select(attrs={'class': INLINE_INPUT_CLASSES}),
            'issue_description': forms.Textarea(attrs={
                'class': INLINE_INPUT_CLASSES, 'rows': 3,
                'placeholder': 'Describe the issue in detail...',
            }),
            'evidence': forms.ClearableFileInput(attrs={'class': 'w-full text-xs text-slate-500'}),
        }

class AuditLogForm(forms.ModelForm):
    user = forms.ModelChoiceField(
        queryset=User.objects.all(),
        required=False,
    )
    ip_address = forms.CharField(
        required=False,
        widget=forms.TextInput(attrs={'placeholder': 'e.g. 127.0.0.1 (Auto-captured if left blank)'})
    )
    changes = forms.CharField(
        required=False,
        widget=forms.Textarea(attrs={'rows': 3, 'placeholder': 'Enter audit notes or JSON payload...'}),
    )

    class Meta:
        model = AuditLog
        fields = ['user', 'action', 'project', 'model_name', 'object_id', 'changes', 'ip_address']
        widgets = {
            'action': forms.TextInput(attrs={'placeholder': 'e.g. manual_inspection_passed, compliance_verified'}),
            'model_name': forms.TextInput(attrs={'placeholder': 'e.g. Project, Budget'}),
        }

    def clean_ip_address(self):
        ip = self.cleaned_data.get('ip_address')
        if not ip:
            return None
        return ip

    def clean_changes(self):
        raw = self.cleaned_data.get('changes')
        if not raw:
            return {}
        if isinstance(raw, dict):
            return raw
        if isinstance(raw, str):
            raw_str = raw.strip()
            if not raw_str:
                return {}
            try:
                import json
                return json.loads(raw_str)
            except (json.JSONDecodeError, TypeError):
                return {"notes": raw_str}
        return {}

class ProjectStageForm(forms.ModelForm):
    class Meta:
        model = ProjectStage
        fields = ['project', 'stage_name', 'description', 'start_date', 'end_date', 'progress_percentage', 'status', 'is_current', 'order']
        widgets = {
            'project': forms.Select(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs'}),
            'stage_name': forms.Select(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs'}),
            'description': forms.Textarea(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs', 'rows': 4, 'placeholder': 'Overview of scope, objectives and deliverables for this stage...'}),
            'start_date': forms.DateInput(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs', 'type': 'date'}),
            'end_date': forms.DateInput(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs', 'type': 'date'}),
            'progress_percentage': forms.NumberInput(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs', 'min': 0, 'max': 100}),
            'status': forms.Select(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs'}),
            'order': forms.NumberInput(attrs={'class': 'w-full px-4 py-3 border border-slate-300 rounded-xl focus:ring-2 focus:ring-blue-500 outline-none text-xs', 'min': 0}),
            'is_current': forms.CheckboxInput(attrs={'class': 'w-4 h-4 text-blue-600 rounded border-slate-300 focus:ring-blue-500'}),
        }

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
        fields = ['project', 'allocated_amount', 'spent_amount', 'fiscal_year', 'notes']
        widgets = {
            'project': forms.Select(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200'
            }),
            'allocated_amount': forms.NumberInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': '0.00'
            }),
            'spent_amount': forms.NumberInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': '0.00'
            }),
            'fiscal_year': forms.TextInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'e.g. FY 2024/2025'
            }),
            'notes': forms.Textarea(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'rows': 4,
                'placeholder': 'Budget justification, source of allocation, or notes'
            }),
        }


class ProjectExpenseForm(forms.ModelForm):
    class Meta:
        model = ProjectExpense
        fields = ['project', 'title', 'category', 'amount', 'description', 'receipt']
        widgets = {
            'project': forms.Select(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200'
            }),
            'title': forms.TextInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': 'Expense description/title'
            }),
            'category': forms.Select(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200'
            }),
            'amount': forms.NumberInput(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'placeholder': '0.00'
            }),
            'description': forms.Textarea(attrs={
                'class': 'w-full rounded-xl border border-slate-300 bg-white px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-emerald-500 focus:ring-2 focus:ring-emerald-200',
                'rows': 4,
                'placeholder': 'Detailed description of payment or expense item'
            }),
            'receipt': forms.ClearableFileInput(attrs={
                'class': 'block w-full rounded-xl border border-dashed border-slate-300 bg-slate-50 px-4 py-3 text-sm text-slate-600 file:mr-4 file:rounded-full file:border-0 file:bg-emerald-600 file:px-4 file:py-2 file:text-sm file:font-semibold file:text-white hover:file:bg-emerald-700'
            }),
        }


class contractorForm(forms.ModelForm):
    name = forms.CharField(required=True, label='Contact person')
    company = forms.CharField(required=True, label='Company name')
    phone = forms.CharField(required=True, label='Phone number')
    email = forms.EmailField(required=True, label='Business email')
    location = forms.CharField(required=True, label='Business location')
    profile = forms.ImageField(
        required=True,
        label='Identification photo or company logo',
        help_text='Upload a clear face photo or company logo for the registry.',
    )
    registration_no = forms.CharField(required=True, label='Registration number')
    category = forms.CharField(required=True, label='Contractor category')

    class Meta:
        model = Contractor
        fields = [
            'profile', 'company', 'name', 'registration_no', 'category',
            'phone', 'email', 'location',
        ]


class GovernmentRequestForm(forms.ModelForm):
    class Meta:
        model = GovernmentRequest
        fields = ['title', 'description', 'category', 'location', 'priority', 'image']
        widgets = {
            'title': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-200',
                'placeholder': 'e.g. Urgent Road Rehabilitation Needed on Main Street'
            }),
            'description': forms.Textarea(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-200',
                'rows': 5,
                'placeholder': 'Describe the issue or request in detail, including affected areas, urgency, and expected public resolution...'
            }),
            'category': forms.Select(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-200'
            }),
            'location': forms.TextInput(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-200',
                'placeholder': 'County, Ward, Location or Address'
            }),
            'priority': forms.Select(attrs={
                'class': 'w-full rounded-2xl border border-slate-300 bg-white/90 px-4 py-3 text-sm text-slate-900 shadow-sm outline-none transition focus:border-blue-500 focus:ring-2 focus:ring-blue-200'
            }),
            'image': forms.ClearableFileInput(attrs={
                'class': 'block w-full rounded-2xl border border-dashed border-slate-300 bg-slate-50 px-4 py-3 text-sm text-slate-600 file:mr-4 file:rounded-full file:border-0 file:bg-blue-600 file:px-4 file:py-2 file:text-sm file:font-semibold file:text-white hover:file:bg-blue-700'
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
