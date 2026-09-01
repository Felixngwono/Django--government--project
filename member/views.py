from datetime import date, datetime, timedelta, timezone
from decimal import Decimal
from urllib.parse import quote
from xml.dom import ValidationErr

from django.db import models
import pdfkit
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db import models, transaction
from django.db.models import Avg, Count, FloatField, Q, Sum
from django.db.models.functions import Coalesce, TruncDate, TruncMonth
from django.http import HttpResponse, HttpResponseBadRequest, JsonResponse
from django.utils.timesince import timesince
from django.views.decorators.http import require_GET, require_POST
from django.shortcuts import get_object_or_404, redirect, render
from django.template.loader import get_template
from django.utils import timezone as django_timezone
from openpyxl import Workbook
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer

from .forms import ( AuditLogForm, BudgetForm, CommentForm, ContactUsForm, FeedbackForm, GovernmentRequestForm, MediaForm, MilestoneForm, MyUserCreationForm, NotificationForm, ProgressReportForm, ProjectCreationForm, ProjectDivisionForm, ProjectExpenseForm, ProjectStageForm, ProjectTypeForm, ReportIssueForm, TeamsForm, TenderApplicationForm, TenderForm, TestimonialForm, contractorForm, participationForm,)
from .models import (PDF,Announcement,AuditLog,Budget,CitizenEvidence,CitizenSubmission,Comment,Contractor,Feedback,GovernmentRequest,Media,Milestone,Notification,Participation,ProgramImpact,ProgressUpdate,Project,Project_Division,Project_type,ProjectExpense,ProjectRisk,ProjectStage,ReportIssue,StageReport,Stakeholder,Team,Tender,TenderApplication,Testimonial,User,)
from .workflow import OFFICER_ROLES, audit, notify, role_required


def get_participants_for_request(request, limit=None):
    if request.user.is_superuser:
        queryset = Participation.objects.all()
    elif request.user.is_authenticated:
        queryset = Participation.objects.filter(user=request.user)
    else:
        queryset = Participation.objects.none()

    queryset = queryset.select_related('user', 'project').order_by('-joined_at')
    if limit is not None:
        return queryset[:limit]
    return queryset


def generate_report(request):
    # Fetch data for reports
    users = User.objects.all()
    projects = Project.objects.all()
    budgets = Budget.objects.all()
    feedbacks = Feedback.objects.all()
    notifications = Notification.objects.all()
    milestones = Milestone.objects.all()
    pdfs = PDF.objects.all()
    media_files = Media.objects.all()

    # Calculate totals
    total_projects = projects.count()
    total_budget_allocated = budgets.aggregate(Sum('allocated_amount'))['allocated_amount__sum'] or 0
    total_budget_spent = budgets.aggregate(Sum('spent_amount'))['spent_amount__sum'] or 0
    total_users = users.count()
    total_feedbacks = feedbacks.count()
    total_notifications = notifications.count()

    context = {
        'users': users,
        'projects': projects,
        'budgets': budgets,
        'feedbacks': feedbacks,
        'notifications': notifications,
        'milestones': milestones,
        'pdfs': pdfs,
        'media_files': media_files,
        'total_projects': total_projects,
        'total_budget_allocated': total_budget_allocated,
        'total_budget_spent': total_budget_spent,
        'total_users': total_users,
        'total_feedbacks': total_feedbacks,
        'total_notifications': total_notifications,
    }

    return render(request, 'generate_pdf.html', context)

def export_report_pdf(request):
    if pdfkit is None:
        return HttpResponse('PDF export is unavailable. Install pdfkit and wkhtmltopdf.', status=503)
    template = get_template('generate_pdf.html')
    context = generate_report(request).context_data
    html = template.render(context)
    pdf = pdfkit.from_string(html, False)
    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="report.pdf"'
    return response



@login_required(login_url='login')
def AboutUs(request):
    participants = get_participants_for_request(request, limit=5)
    team_members = Team.objects.all()[:6]
    testimonials = Testimonial.objects.filter(is_approved=True).order_by('-is_featured', '-created_at')[:3]
    projects = Project.objects.all()

    context = {
        'participants': participants,
        'team_members': team_members,
        'testimonials': testimonials,
        'total_projects': projects.count(),
        'ongoing_count': projects.filter(project_status='ongoing').count(),
        'completed_count': projects.filter(project_status='completed').count(),
        'delayed_count': projects.filter(project_status='delayed').count(),
        'total_budget': projects.aggregate(total=Sum('project_Budgeting'))['total'] or 0,
        'total_spent': projects.aggregate(total=Sum('amount_spent'))['total'] or 0,
        'total_users': User.objects.count(),
        'total_agencies': Project_Division.objects.count(),
        'total_testimonials': Testimonial.objects.filter(is_approved=True).count(),
    }
    return render(request, 'about_us.html', context=context)


def Home(request):
    projects= Project.objects.filter(project_status='ongoing').count()
    print(projects)
    context ={'projects':projects}
    return render(request, 'home.html', context)

@login_required(login_url='login')
def Participation_details(request,pk):
    participation=get_object_or_404(Participation.objects.select_related('user', 'project'), id=pk)
    participants = get_participants_for_request(request, limit=6)

    form=participationForm(instance=participation)
    if request.method=='POST':
        form=participationForm(request.POST, instance=participation)
        if form.is_valid():
            form.save()
            messages.success(request, 'Participation details and feedback updated successfully!')
            return redirect('participation_details',pk=pk)

    context={'participation':participation, 'participants': participants,'form':form}
    return render(request,'participation_details.html',context)


@login_required(login_url='login')
def Notifications(request):

    new_projects = Project.objects.order_by('-start_date')[:4]
    new_participants = Participation.objects.order_by('-joined_at')[:4]

    notifications = []

    # build notifications list
    for project in new_projects:
        notifications.append({
            "message": f"New project: {project.project_title}",
            "link": f"/project/{project.id}/",
            "time": project.start_date
        })

    for p in new_participants:
        notifications.append({
            "message": f"{p.user.username} joined {p.project.project_title}",
            "link": f"/project/{p.project.id}/",
            "time": p.joined_at
        })

    # sort
    notifications = sorted(notifications, key=lambda x: x["time"], reverse=True)

    context = {
        "notifications": notifications,
        "notification_count": len(notifications)
    }

    return render(request, "notifications.html", context)

@login_required(login_url='login')
def dashboard(request):
    ongoingcount=Project.objects.filter(project_status__iexact='ongoing').count()
    upcomingcount=Project.objects.filter(project_status__iexact='upcoming').count()
    completedcount=Project.objects.filter(project_status__iexact='completed').count()
    delayedcount=Project.objects.filter(project_status__iexact='delayed').count()
    stalledcount=Project.objects.filter(project_status__iexact='stalled').count()
    allproject=Project.objects.all().count()
    users=User.objects.all().count()
    people=User.objects.all()
    agencies=Project_Division.objects.all().count()
    projects = Project.objects.values('project_status').annotate(total=Count('id')).order_by('-total')
    projects_by_location = (
        Project.objects.exclude(project_location__isnull=True)
        .exclude(project_location='')
        .values('project_location')
        .annotate(total=Count('id'))
        .order_by('-total')[:5]
    )
    pro = Project.objects.all().order_by('-start_date')[:5]

    # Aggregate project counts by status for the chart (case-insensitive mapping)
    status_labels = [choice[1] for choice in Project.STATUS_CHOICES]
    status_counts = [0] * len(status_labels)
    status_index_map = {choice[0].lower(): idx for idx, choice in enumerate(Project.STATUS_CHOICES)}

    unspecified_count = 0
    for item in projects:
        raw_key = (item['project_status'] or '').strip()
        key_lower = raw_key.lower()
        if key_lower in status_index_map:
            status_counts[status_index_map[key_lower]] += item['total']
        else:
            unspecified_count += item['total']

    if unspecified_count > 0:
        status_labels.append('Other / Unspecified')
        status_counts.append(unspecified_count)

    # Aggregate budget per month using actual project records
    months = []
    month_labels = []
    allocated = [0] * 12
    used = [0] * 12
    today = datetime.today()
    month_date = today.replace(day=1)
    for _ in range(12):
        months.append((month_date.year, month_date.month))
        month_labels.append(month_date.strftime('%b %Y'))
        month_date = (
            month_date.replace(year=month_date.year - 1, month=12)
            if month_date.month == 1
            else month_date.replace(month=month_date.month - 1)
        )
    months.reverse()
    month_labels.reverse()

    monthly_projects = (
        Project.objects
        .annotate(eff_date=Coalesce('start_date', TruncDate('created_at')))
        .filter(eff_date__isnull=False, eff_date__gte=(today - timedelta(days=365)).date())
        .annotate(month=TruncMonth('eff_date'))
        .values('month')
        .annotate(
            total_budget=Sum('project_Budgeting'),
            used_budget=Sum('amount_spent')
        )
        .order_by('month')
    )

    monthly_map = {(item['month'].year, item['month'].month): {'allocated': float(item['total_budget'] or 0), 'used': float(item['used_budget'] or 0)} for item in monthly_projects if item['month']}
    for idx, month_key in enumerate(months):
        month_data = monthly_map.get(month_key, {'allocated': 0.0, 'used': 0.0})
        allocated[idx] = month_data['allocated']
        used[idx] = month_data['used']

    # Count projects started during the last twelve months for the dashboard line chart.
    project_months = (
        Project.objects
        .annotate(eff_date=Coalesce('start_date', TruncDate('created_at')))
        .filter(eff_date__isnull=False, eff_date__gte=(today - timedelta(days=365)).date())
        .annotate(month=TruncMonth('eff_date'))
        .values('month')
        .annotate(count=Count('id'))
    )
    project_counts_by_month = {(item['month'].year, item['month'].month): item['count'] for item in project_months if item['month']}
    project_counts = [project_counts_by_month.get(month_key, 0) for month_key in months]

    participants = get_participants_for_request(request, limit=5)
    attention_projects = Project.objects.filter(
        Q(project_status__iexact='delayed') |
        Q(project_status__iexact='suspended') |
        Q(project_status__iexact='stalled') |
        Q(end_date__lt=today.date(), project_status__in=['ongoing', 'Ongoing', 'upcoming', 'Upcoming'])
    ).order_by('end_date')[:4]
    open_issues = ReportIssue.objects.exclude(status__in=['resolved', 'dismissed'])
    recent_issues = open_issues.select_related('project').order_by('-created_at')[:4]
    recent_projects = Project.objects.order_by('-created_at')[:4]

    total_budget_allocated = Project.objects.aggregate(total=Sum('project_Budgeting'))['total'] or 0
    total_budget_spent = Project.objects.aggregate(total=Sum('amount_spent'))['total'] or 0
    budget_utilization = round((float(total_budget_spent) / float(total_budget_allocated)) * 100, 1) if total_budget_allocated else 0

    context={'ongoingcount':ongoingcount,
             'upcomingcount':upcomingcount,
             'completedcount':completedcount,
             'delayedcount':delayedcount,
             'stalledcount':stalledcount,
             'allproject':allproject,
             'users':users,
             'project':projects,
             'agencies':agencies,
             'projects':projects,
             'location_labels': [item['project_location'] for item in projects_by_location],
             'location_counts': [item['total'] for item in projects_by_location],
             'people':people,
             'participants':participants,
             'projects_per_month': status_counts,
             'months': month_labels,
             'allocated': allocated,
             'used': used,
             'month_labels': month_labels,
             'project_counts': project_counts,
             'attention_projects': attention_projects,
             'open_issues_count': open_issues.count(),
             'recent_issues': recent_issues,
             'recent_projects': recent_projects,
             'project_status_labels': status_labels,
             'pro':pro,
             'total_budget_allocated': total_budget_allocated,
             'total_budget_spent': total_budget_spent,
             'budget_utilization': budget_utilization
             }
    return render(request, 'dashboard.html',context)

@login_required(login_url='login')
def ContactusPage(request):
    participants = get_participants_for_request(request, limit=4)

    form = ContactUsForm()

    if request.method == 'POST':
            form = ContactUsForm(request.POST)
            if form.is_valid():
                form.save()
                messages.success(request, 'Your message has been sent successfully. We will get back to you soon!')
                return redirect('contactus')

    context={
        'form': form,
        'participants': participants,
        'total_projects': Project.objects.count(),
        'total_users': User.objects.count(),
        'total_agencies': Project_Division.objects.count(),
        'total_testimonials': Testimonial.objects.filter(is_approved=True).count(),
    }
    return render(request, 'contact_us.html', context)

@login_required(login_url='login')
def Testimonials(request):
    query = request.GET.get('q', '').strip()
    selected_project = request.GET.get('project', '')
    selected_rating = request.GET.get('rating', '')
    testimonials = Testimonial.objects.all()


    context={
        'testimonials':testimonials,
        'projects': Project.objects.order_by('project_title'),
        'selected_project': selected_project,
        'selected_rating': selected_rating,
        'query': query,
        'pending_count': Testimonial.objects.filter(is_approved=False).count() if request.user.is_superuser else 0,
    }
    return render(request,'testimonials.html',context)

@login_required(login_url='login')
def testimonial_details(request,pk):
    testimonial=get_object_or_404(Testimonial,id=pk)
    if not testimonial.is_approved and not (request.user.is_superuser or testimonial.user_id == request.user.id):
        messages.error(request, 'This testimonial is awaiting moderation.')
        return redirect('testimonials')

    participants = get_participants_for_request(request, limit=5)

    context={'testimonial':testimonial, 'participants': participants}
    return render(request,'testimonial_details.html',context)

@login_required(login_url='login')
def add_testimonial(request):

    form=TestimonialForm()
    if request.method=='POST':
        form=TestimonialForm(request.POST, request.FILES)
        if form.is_valid():
            testimonial = form.save(commit=False)
            testimonial.user = request.user
            if not testimonial.name:
                testimonial.name = request.user.get_full_name() or request.user.username
            testimonial.is_approved = request.user.is_superuser
            testimonial.save()
            messages.success(request, 'Your testimonial has been submitted for review.' if not testimonial.is_approved else 'Testimonial published.')
            return redirect('testimonials')
    context={'form':form}
    return render(request,'add_testimonial.html',context)

@login_required(login_url='login')
def delete_testimonial(request, pk):
    testimonial = get_object_or_404(Testimonial, id=pk)
    if not (request.user.is_superuser or testimonial.user_id == request.user.id):
        messages.error(request, 'You do not have permission to delete this testimonial.')
        return redirect('testimonials')
    if request.method== 'POST':
        testimonial.delete()
        return redirect ('testimonials')
    return render(request, 'testimonial_delete.html', {'testimonial': testimonial})

@login_required(login_url='login')
def update_testimonial(request, pk):
    testimonial=get_object_or_404(Testimonial, id=pk)
    if not (request.user.is_superuser or testimonial.user_id == request.user.id):
        messages.error(request, 'You do not have permission to update this testimonial.')
        return redirect('testimonials')
    form= TestimonialForm(instance=testimonial)
    if request.method=='POST':
        form= TestimonialForm(request.POST,request.FILES,instance=testimonial)
        if form.is_valid():
            updated = form.save(commit=False)
            if not request.user.is_superuser:
                updated.is_approved = False
                updated.is_featured = False
            updated.save()
            messages.success(request, 'Testimonial updated and sent for review.' if not request.user.is_superuser else 'Testimonial updated.')
            return redirect('testimonials')
    context={'form':form, 'testimonial': testimonial}
    return render(request,'add_testimonial.html', context)

@login_required(login_url='login')
def moderate_testimonial(request, pk):
    if not request.user.is_superuser or request.method != 'POST':
        return redirect('testimonials')
    testimonial = get_object_or_404(Testimonial, id=pk)
    action = request.POST.get('action')
    testimonial.is_approved = action == 'approve'
    testimonial.is_featured = request.POST.get('featured') == 'on' and testimonial.is_approved
    testimonial.moderation_note = request.POST.get('moderation_note', '').strip()
    testimonial.save(update_fields=['is_approved', 'is_featured', 'moderation_note', 'updated_at'])
    messages.success(request, 'Testimonial approved.' if testimonial.is_approved else 'Testimonial returned to pending review.')
    return redirect('testimonial_details', pk=pk)

@login_required(login_url='login')
def adminview(request):
    if not (request.user.is_superuser or request.user.is_staff or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES)):
        messages.error(request, "Access restricted. You do not have permission to view the executive admin portal.")
        return redirect('dashboard')

    feedbacks = Feedback.objects.order_by('-created_at')[:10]
    impacts = ProgramImpact.objects.order_by('-id')[:10]
    updates = ProgressUpdate.objects.select_related('project', 'stage', 'reported_by').order_by('-date_reported')[:10]
    budgetings = Budget.objects.select_related('project').order_by('-last_updated')[:10]
    comments = Comment.objects.select_related('project', 'user').order_by('-created_at')[:10]
    risks = ProjectRisk.objects.select_related('project', 'owner').order_by('-created_at')[:10]
    stakeholder = Stakeholder.objects.select_related('project').order_by('-id')[:10]
    reportedissues = ReportIssue.objects.select_related('project', 'user').order_by('-created_at')[:10]
    recent_projects = Project.objects.order_by('-created_at')[:8]
    participants = get_participants_for_request(request, limit=5)

    project_stats = {
        'total': Project.objects.count(),
        'ongoing': Project.objects.filter(project_status='ongoing').count(),
        'upcoming': Project.objects.filter(project_status='upcoming').count(),
        'completed': Project.objects.filter(project_status='completed').count(),
        'delayed': Project.objects.filter(project_status='delayed').count(),
    }

    budget_rows = list(budgetings[:6])
    project_status_labels = ['Ongoing', 'Upcoming', 'Completed', 'Delayed']
    project_status_counts = [
        project_stats['ongoing'],
        project_stats['upcoming'],
        project_stats['completed'],
        project_stats['delayed'],
    ]
    budget_labels = [
        budget.project.project_title if budget.project else 'Unassigned budget'
        for budget in budget_rows
    ]
    budget_allocated = [float(budget.allocated_amount or 0) for budget in budget_rows]
    budget_spent = [float(budget.spent_amount or 0) for budget in budget_rows]

    context = {
        'feedbacks': feedbacks,
        'impacts': impacts,
        'updates': updates,
        'budgetings': budgetings,
        'comments': comments,
        'risks': risks,
        'stakeholder': stakeholder,
        'reportedissues': reportedissues,
        'recent_projects': recent_projects,
        'project_stats': project_stats,
        'participants': participants,
        'project_status_labels': project_status_labels,
        'project_status_counts': project_status_counts,
        'budget_labels': budget_labels,
        'budget_allocated': budget_allocated,
        'budget_spent': budget_spent,
        'total_budget_allocated': sum(budget_allocated),
        'total_budget_spent': sum(budget_spent),
    }
    return render(request, 'adminview.html', context)

@login_required(login_url='login')
def feedback_details(request,pk):
    feed=get_object_or_404(Feedback,id=pk)
    context={'feed':feed}
    return render(request,'feedback_details.html',context)

def reportedissuesdetails(request,pk):
    issues=get_object_or_404(ReportIssue,id=pk)
    return render(request,'reportedissuesdetails.html',context={'issues':issues})

@login_required(login_url='login')
def comment(request,pk):
    comments=get_object_or_404(Comment,id=pk)
    return render(request,'comments.html',context={'comments':comments})

@login_required(login_url='login')
def notifications(request):
    notifications_qs = Notification.objects.filter(user=request.user).order_by('-created_at')
    # Mark unread as read
    Notification.objects.filter(user=request.user, is_read=False).update(is_read=True)
    return render(request, 'notifications.html', {'notifications': notifications_qs})

def welcomingpage(request):
    comment = Comment.objects.all()[:5]
    projects = (
        Project.objects
        .filter(is_public=True)
        .only('project_title', 'project_description', 'images', 'project_status')
        .order_by('-created_at')[:6]
    )
    testimonials = Testimonial.objects.filter(is_approved=True).only('name', 'content', 'image', 'rating', 'is_featured').order_by('-is_featured', '-created_at')[:5]
    return render(
        request,
        'welcoming page.html',
        context={'projects': projects, 'comment': comment, 'testimonials': testimonials},
    )

def loginpage(request):
    next_url = request.GET.get('next') or request.POST.get('next')
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        try:
            user = User.objects.get(email=email)
        except User.DoesNotExist:
            return HttpResponse('User does not exist')

        user = authenticate(request, email=email, password=password)

        if user is not None:
            login(request, user)
            messages.info(request, 'Login successful')
            if next_url:
                return redirect(next_url)
            return redirect('dashboard')
        else:
            messages.warning(request, 'Wrong username or password')
    return render(request, 'login.html', {'next': next_url})

@login_required(login_url='login')
def logoutuser(request):
    logout(request)
    messages.info(request,"Its sad to see you leave, welcome again")
    return redirect('login')

def registrationpage(request):
    form = MyUserCreationForm()
    if request.method == 'POST':
        form = MyUserCreationForm(request.POST, request.FILES)
        if form.is_valid():
            user = form.save(commit=False)
            user.save()
            messages.success(request, 'Account created successfully. Please sign in to continue.')
            return redirect('login')
        messages.warning(request, 'Please correct the highlighted fields and try again.')

    return render(request, 'register.html', {'form': form})


@login_required(login_url='login')
def updateprofile(request,pk):

    profiles = get_object_or_404(User, id=pk)
    form = MyUserCreationForm(instance=profiles)
    if request.method == 'POST':
        form = MyUserCreationForm(request.POST, request.FILES, instance=profiles)
        if form.is_valid():
            form.save()
            messages.info(request,'Profile updated successfully')
            return redirect('index')

    return render(request, 'profile.html', {'form': form, 'profiles': profiles})

@login_required(login_url='login')
def deleteprofile(request, pk):
    project= User.objects.get(id=pk)
    if request.method== 'POST':
        project.delete()
        return redirect ('index')
    return render(request, 'deleteprofile.html')



@login_required(login_url='login')
def index(request):
    ongoingcount=Project.objects.filter(project_status='ongoing').count()
    upcomingcount=Project.objects.filter(project_status='upcoming').count()
    completedcount=Project.objects.filter(project_status='completed').count()
    delayedcount=Project.objects.filter(project_status='delayed').count()
    stalledcount=Project.objects.filter(project_status='stalled').count()
    allproject=Project.objects.all().count()
    users=User.objects.all().count()
    people=User.objects.all()
    agencies=Project_Division.objects.all().count()
    projects=Project.objects.all().values('project_status').annotate(total=Count('project_status')).order_by('-total')

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user).order_by('-joined_at')[:5]

    context={'ongoingcount':ongoingcount,
             'upcomingcount':upcomingcount,
             'completedcount':completedcount,
             'delayedcount':delayedcount,
            'stalledcount':stalledcount,
             'allproject':allproject,
             'users':users,
             'project':projects,
             'agencies':agencies,
             'projects':projects,
             'people':people,
             'participants':participants
             }
    return render(request,'index.html',context)


@login_required(login_url='login')
def people(request):
    pp = User.objects.all().order_by('-date_joined')
    context = {'pp': pp}
    return render(request, 'users.html', context)

def sidebar(request):
    return render(request,'sidebar.html')

def header(request):
    return render(request,'header.html')

@login_required(login_url='login')
def jobApplication(request):
    return render(request,'job.html')

@login_required(login_url='login')
def feedback(request):

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    form= FeedbackForm()
    if request.method=='POST':
        form=FeedbackForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('index')

    context= {'form':form, 'participants': participants}
    return render(request,'feedback.html',context)




@login_required(login_url='login')
def CreateProject(request):
    form= ProjectCreationForm()
    if request.method=='POST':
        form= ProjectCreationForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('projectoverview')
    context={'form':form,}
    return render(request,'project_form.html', context)

@login_required(login_url='login')
def updateProject(request,pk):
    project=Project.objects.get(id= pk)
    form= ProjectCreationForm(instance=project)
    if request.method=='POST':
        form= ProjectCreationForm(request.POST,request.FILES,instance=project)
        if form.is_valid():
            form.save()
            return redirect('projectoverview')
    context={'form':form}
    return render(request,'project_form.html', context)

@login_required(login_url='login')
def deleteProject(request, pk):
    project= Project.objects.get(id=pk)
    if request.method== 'POST':
        project.delete()
        return redirect ('projectoverview')
    return render(request, 'delete.html')

@login_required(login_url='login')
def BudgetAnalysis(request):
    projects = Project.objects.all()
    budgets = Budget.objects.select_related('project', 'project__project_division').all()
    expenses = ProjectExpense.objects.select_related('project').all()

    # Financial Metrics
    total_allocated_budget = Budget.objects.aggregate(Sum('allocated_amount'))['allocated_amount__sum'] or Decimal('0.00')
    if not total_allocated_budget:
        total_allocated_budget = Project.objects.aggregate(Sum('project_Budgeting'))['project_Budgeting__sum'] or Decimal('0.00')

    total_spent_budget = Budget.objects.aggregate(Sum('spent_amount'))['spent_amount__sum'] or Decimal('0.00')
    total_expense_sum = expenses.aggregate(Sum('amount'))['amount__sum'] or Decimal('0.00')
    total_spent = max(total_spent_budget, total_expense_sum)

    total_remaining = total_allocated_budget - total_spent
    overall_utilization = round(float((total_spent / total_allocated_budget) * 100), 1) if total_allocated_budget else 0.0

    # Division / Sector Allocation Analysis
    division_data = []
    divisions = Project_Division.objects.all()
    for div in divisions:
        div_projects = projects.filter(project_division=div)
        div_allocated = div_projects.aggregate(Sum('project_Budgeting'))['project_Budgeting__sum'] or Decimal('0.00')
        div_spent = div_projects.aggregate(Sum('amount_spent'))['amount_spent__sum'] or Decimal('0.00')
        div_utilization = round(float((div_spent / div_allocated) * 100), 1) if div_allocated else 0.0
        division_data.append({
            'name': getattr(div, 'name', str(div)),
            'project_count': div_projects.count(),
            'allocated': div_allocated,
            'spent': div_spent,
            'remaining': div_allocated - div_spent,
            'utilization': div_utilization
        })

    # Expense Category Breakdown
    category_choices = ProjectExpense.CATEGORY_CHOICES
    category_breakdown = []
    for cat_code, cat_label in category_choices:
        cat_amount = expenses.filter(category=cat_code).aggregate(Sum('amount'))['amount__sum'] or Decimal('0.00')
        category_breakdown.append({
            'code': cat_code,
            'label': cat_label,
            'amount': cat_amount
        })

    # Top Funded Projects
    top_projects = projects.order_by('-project_Budgeting')[:10]

    # At-risk projects (utilization >= 85% or spent > budget)
    at_risk_projects = []
    for p in projects:
        if p.project_Budgeting and p.amount_spent:
            pct = (p.amount_spent / p.project_Budgeting) * 100
            if pct >= 85:
                at_risk_projects.append({
                    'project': p,
                    'utilization': round(float(pct), 1),
                    'status': 'Overrun Risk' if pct > 100 else 'High Utilization'
                })

    # JS Charts Data
    project_labels = [p.project_title[:20] for p in top_projects]
    project_allocated = [float(p.project_Budgeting or 0) for p in top_projects]
    project_spent = [float(p.amount_spent or 0) for p in top_projects]

    cat_labels = [c['label'] for c in category_breakdown]
    cat_amounts = [float(c['amount']) for c in category_breakdown]

    context = {
        'total_allocated': total_allocated_budget,
        'total_spent': total_spent,
        'total_remaining': total_remaining,
        'overall_utilization': overall_utilization,
        'division_data': division_data,
        'category_breakdown': category_breakdown,
        'top_projects': top_projects,
        'at_risk_projects': at_risk_projects,
        'project_labels': project_labels,
        'project_allocated': project_allocated,
        'project_spent': project_spent,
        'cat_labels': cat_labels,
        'cat_amounts': cat_amounts,
        'budgets': budgets,
    }
    return render(request, 'budgetanalysis.html', context)

@login_required(login_url='login')
def PerfomanceMetrix(request):
    return render(request,'perfomancematrix.html')


@login_required(login_url='login')
def completed(request):
    q = request.GET.get('q', '').strip()
    location = request.GET.get('location', '').strip()

    projects_qs = Project.objects.filter(project_status__iexact='completed').select_related('district', 'category', 'project_division')

    if q:
        projects_qs = projects_qs.filter(
            Q(project_title__icontains=q) |
            Q(project_description__icontains=q) |
            Q(project_location__icontains=q) |
            Q(implementing_agency__icontains=q) |
            Q(reference_code__icontains=q)
        )

    if location:
        projects_qs = projects_qs.filter(project_location__icontains=location)

    projects_qs = projects_qs.order_by('-updated_at', '-id')

    locations = Project.objects.filter(project_status='completed').exclude(
        project_location__isnull=True
    ).exclude(project_location='').values_list('project_location', flat=True).distinct()

    from django.db.models import DecimalField
    dec = DecimalField(max_digits=15, decimal_places=2)
    completed_aggs = Project.objects.filter(project_status='completed').aggregate(
        total_budget=Coalesce(Sum('project_Budgeting'), models.Value(0, output_field=dec)),
        total_spent=Coalesce(Sum('amount_spent'), models.Value(0, output_field=dec)),
        overdue=Count('id', filter=Q(end_date__lt=django_timezone.now().date(), actual_end_date__isnull=True)),
        featured=Count('id', filter=Q(is_featured=True)),
    )
    total_budget = completed_aggs['total_budget']
    total_spent = completed_aggs['total_spent']
    budget_utilization = round((total_spent / total_budget) * 100, 1) if total_budget else 0
    overdue_count = completed_aggs['overdue']
    featured_count = completed_aggs['featured']
    today = django_timezone.now().date()

    paginator = Paginator(projects_qs, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'projects': page_obj,
        'q': q,
        'query': q,
        'locations': locations,
        'selected_location': location,
        'total_count': paginator.count,
        'total_budget': total_budget,
        'total_spent': total_spent,
        'budget_utilization': budget_utilization,
        'overdue_count': overdue_count,
        'featured_count': featured_count,
        'today': today,
    }
    return render(request, 'completed.html', context)


@login_required(login_url='login')
def delayed(request):
    q = request.GET.get('q', '').strip()
    location = request.GET.get('location', '').strip()

    delaying_qs = Project.objects.filter(project_status__iexact='delayed').select_related('district', 'category', 'project_division')

    if q:
        delaying_qs = delaying_qs.filter(
            Q(project_title__icontains=q) |
            Q(project_description__icontains=q) |
            Q(project_location__icontains=q) |
            Q(implementing_agency__icontains=q) |
            Q(reference_code__icontains=q)
        )

    if location:
        delaying_qs = delaying_qs.filter(project_location__icontains=location)

    delaying_qs = delaying_qs.order_by('-updated_at', '-id')

    # Aggregates for delayed page summary
    total_delayed = delaying_qs.count()
    progress_count = delaying_qs.filter(amount_spent__gt=0).count()
    total_budget_delayed = delaying_qs.aggregate(total=Sum('project_Budgeting'))['total'] or 0

    locations = Project.objects.filter(project_status='delayed').exclude(
        project_location__isnull=True
    ).exclude(project_location='').values_list('project_location', flat=True).distinct()

    paginator = Paginator(delaying_qs, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'delaying': page_obj,
        'projects': page_obj,
        'q': q,
        'query': q,
        'locations': locations,
        'selected_location': location,
        'total_delayed': total_delayed,
        'progress_count': progress_count,
        'total_budget_delayed': total_budget_delayed,
    }
    return render(request, 'delayed.html', context)


@login_required(login_url='login')
def delayedstatus(request, pk):
    target_project = get_object_or_404(Project, id=pk)
    projects = [target_project]
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = target_project
            participation.save()
            messages.success(request, f"Feedback submitted for '{target_project.project_title}'.")
            return redirect('delayed')

    context = {
        'projects': projects,
        'project': target_project,
        'project_status': target_project.project_status,
        'form': form
    }
    return render(request, 'statuses.html', context)



@login_required(login_url='login')
def teams(request):
    tim=Team.objects.all()
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)

    context={
        'tim': tim,
        'participants': participants,
        'total_members': tim.count(),
        'total_roles': tim.values('role').distinct().count(),
        'total_projects': Project.objects.count(),
        'total_users': User.objects.count(),
    }
    return render(request,'team.html',context)

@login_required(login_url='login')
def add_team(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)

    form=TeamsForm()
    if request.method=='POST':
        form=TeamsForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            messages.success(request, 'Team member added successfully!')
            return redirect('team')
    return render(request,'add_team.html',context={'form':form,'participants':participants})

@login_required(login_url='login')
def update_team(request,pk):
    tim=get_object_or_404(Team,pk=pk)
    form=TeamsForm(instance=tim)
    if request.method=='POST':
        form=TeamsForm(request.POST,request.FILES,instance=tim)
        if form.is_valid():
            form.save()
            messages.success(request, 'Team member updated successfully!')
            return redirect('team')
    context={'tim':tim, 'form':form}
    return render(request,'update_team.html',context)

@login_required(login_url='login')
def delete_team(request,pk):
    deletetim=get_object_or_404(Team,pk=pk)
    if request.method=='POST':
        deletetim.delete()
        messages.success(request, 'Team member deleted successfully!')
        return redirect('team')
    return render(request,'delete_team.html',{'deletetim':deletetim})

@login_required(login_url='login')
def teams_details(request,pk):
    details=get_object_or_404(Team,id=pk)
    form=TeamsForm(instance=details)
    if request.method=='POST':
        form=TeamsForm(request.POST,request.FILES,instance=details)
        if form.is_valid():
            form.save()
            messages.success(request, 'Team member updated successfully!')
            return redirect('team')
    context={
           'details':details,
           'form':form
        }
    return render(request, 'teams_details.html',context)



@login_required(login_url='login')
def project_overview(request):
    q = request.GET.get('q', '').strip()
    status_filter = request.GET.get('status', '').strip()
    priority_filter = request.GET.get('priority', '').strip()

    projects = Project.objects.filter(
        Q(project_title__icontains=q) |
        Q(project_description__icontains=q) |
        Q(project_status__icontains=q) |
        Q(implementing_agency__icontains=q)
    )

    if status_filter:
        projects = projects.filter(project_status=status_filter)

    if priority_filter:
        projects = projects.filter(priority=priority_filter)

    projects = projects.order_by('-id')

    paginator = Paginator(projects, 6)  # number per page
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    # Summary statistics for the overview dashboard
    total_projects = Project.objects.all().count()
    ongoing_count = Project.objects.filter(project_status='ongoing').count()
    upcoming_count = Project.objects.filter(project_status='upcoming').count()
    completed_count = Project.objects.filter(project_status='completed').count()
    delayed_count = Project.objects.filter(project_status='delayed').count()
    stalled_count = Project.objects.filter(project_status='stalled').count()
    draft_count = Project.objects.filter(project_status='draft').count()
    suspended_count = Project.objects.filter(project_status='suspended').count()
    cancelled_count = Project.objects.filter(project_status='cancelled').count()

    status_counts = {
        status: Project.objects.filter(project_status=status).count()
        for status, _label in Project.STATUS_CHOICES
    }

    total_budget = Project.objects.aggregate(total=Sum('project_Budgeting'))['total'] or 0
    total_spent = Project.objects.aggregate(total=Sum('amount_spent'))['total'] or 0

    # Locations for the recent projects sidebar
    projects_by_location = (
        Project.objects.exclude(project_location__isnull=True)
        .exclude(project_location='')
        .values('project_location')
        .annotate(total=Count('id'))
        .order_by('-total')[:6]
    )

    # Recent & attention projects
    recent_projects = Project.objects.order_by('-created_at')[:5]
    attention_projects = Project.objects.filter(
        Q(project_status__in=['delayed', 'suspended']) |
        Q(end_date__lt=datetime.now().date(), project_status__in=['ongoing', 'upcoming'])
    ).order_by('end_date')[:4]

    # Query string that preserves the active filters (used in pagination links)
    base_params = []
    if q:
        base_params.append(f"q={quote(q)}")
    if status_filter:
        base_params.append(f"status={quote(status_filter)}")
    if priority_filter:
        base_params.append(f"priority={quote(priority_filter)}")
    base_query = "&".join(base_params)

    context = {
        "projects": page_obj,
        "total_projects": total_projects,
        "ongoing_count": ongoing_count,
        "upcoming_count": upcoming_count,
        "completed_count": completed_count,
        "delayed_count": delayed_count,
        "stalled_count": stalled_count,
        "draft_count": draft_count,
        "suspended_count": suspended_count,
        "cancelled_count": cancelled_count,
        "status_counts": status_counts,
        "total_budget": total_budget,
        "total_spent": total_spent,
        "budget_remaining": total_budget - total_spent,
        "budget_utilization": round(float(total_spent / total_budget * 100), 1) if total_budget else 0,
        "projects_by_location": projects_by_location,
        "recent_projects": recent_projects,
        "attention_projects": attention_projects,
        "status_filter": status_filter,
        "priority_filter": priority_filter,
        "q": q,
        "base_query": base_query,
        "status_choices": Project.STATUS_CHOICES,
        "priority_choices": Project.PRIORITY_CHOICES,
    }

    return render(request, "overview.html", context)


@login_required(login_url='login')
def project_details(request,pk):
    project= Project.objects.get(id=pk)
    form= ProjectCreationForm(instance=project)
    if request.method=='POST':
        form= ProjectCreationForm(request.POST,request.FILES,instance=project)
        if form.is_valid():
            form.save()
            return redirect('projectoverview')
    context={'form':form}
    return render(request,'project_details.html', context)

@login_required(login_url='login')
@login_required(login_url='login')
def ongoing(request):
    q = request.GET.get('q', '').strip()
    location = request.GET.get('location', '').strip()

    projects_qs = Project.objects.filter(project_status__iexact='ongoing').select_related('district', 'category', 'project_division')

    if q:
        projects_qs = projects_qs.filter(
            Q(project_title__icontains=q) |
            Q(project_description__icontains=q) |
            Q(project_location__icontains=q) |
            Q(implementing_agency__icontains=q) |
            Q(reference_code__icontains=q)
        )

    if location:
        projects_qs = projects_qs.filter(project_location__icontains=location)

    projects_qs = projects_qs.order_by('-start_date', '-id')

    locations = Project.objects.filter(project_status='ongoing').exclude(
        project_location__isnull=True
    ).exclude(project_location='').values_list('project_location', flat=True).distinct()

    paginator = Paginator(projects_qs, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'projects': page_obj,
        'q': q,
        'query': q,
        'locations': locations,
        'selected_location': location,
        'total_count': paginator.count,
    }
    return render(request, 'ongoing.html', context)


@login_required(login_url='login')
def upcoming(request):
    q = request.GET.get('q', '').strip()
    location = request.GET.get('location', '').strip()

    projects_qs = Project.objects.filter(project_status__iexact='upcoming').select_related('district', 'category', 'project_division')

    if q:
        projects_qs = projects_qs.filter(
            Q(project_title__icontains=q) |
            Q(project_description__icontains=q) |
            Q(project_location__icontains=q) |
            Q(implementing_agency__icontains=q) |
            Q(reference_code__icontains=q)
        )

    if location:
        projects_qs = projects_qs.filter(project_location__icontains=location)

    projects_qs = projects_qs.order_by('-start_date', '-id')

    locations = Project.objects.filter(project_status='upcoming').exclude(
        project_location__isnull=True
    ).exclude(project_location='').values_list('project_location', flat=True).distinct()

    paginator = Paginator(projects_qs, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'projects': page_obj,
        'q': q,
        'query': q,
        'locations': locations,
        'selected_location': location,
        'total_count': paginator.count,
    }
    return render(request, 'upcoming.html', context)


@login_required(login_url='login')
def stalled(request):
    return _render_status_page(request, 'stalled', 'Stalled Projects Dashboard')


@login_required(login_url='login')
def cancelled(request):
    return _render_status_page(request, 'cancelled', 'Cancelled Projects Dashboard')


@login_required(login_url='login')
def suspended(request):
    return _render_status_page(request, 'suspended', 'Suspended Projects Dashboard')


@login_required(login_url='login')
def draft(request):
    return _render_status_page(request, 'draft', 'Draft Projects Dashboard')


def _render_status_page(request, status_code, title_text):
    q = request.GET.get('q', '').strip()
    location = request.GET.get('location', '').strip()

    projects_qs = Project.objects.filter(project_status__iexact=status_code).select_related('district', 'category', 'project_division')

    if q:
        projects_qs = projects_qs.filter(
            Q(project_title__icontains=q) |
            Q(project_description__icontains=q) |
            Q(project_location__icontains=q) |
            Q(implementing_agency__icontains=q) |
            Q(reference_code__icontains=q)
        )

    if location:
        projects_qs = projects_qs.filter(project_location__icontains=location)

    projects_qs = projects_qs.order_by('-start_date', '-id')

    # ── Aggregate statistics for the dashboard header ──
    from datetime import date
    base_qs = Project.objects.filter(project_status__iexact=status_code)
    fin = base_qs.aggregate(
        total_budget=Sum('project_Budgeting'),
        total_spent=Sum('amount_spent'),
    )
    total_budget = fin['total_budget'] or 0
    total_spent = fin['total_spent'] or 0
    budget_utilization = round(float(total_spent) / float(total_budget) * 100, 1) if total_budget else 0
    overdue_count = base_qs.filter(end_date__lt=date.today()).exclude(
        project_status__in=['completed', 'cancelled']).count()
    featured_count = base_qs.filter(is_featured=True).count()

    locations = Project.objects.filter(project_status__iexact=status_code).exclude(
        project_location__isnull=True
    ).exclude(project_location='').values_list('project_location', flat=True).distinct()

    paginator = Paginator(projects_qs, 6)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'projects': page_obj,
        'q': q,
        'query': q,
        'locations': locations,
        'selected_location': location,
        'total_count': paginator.count,
        'project_status': status_code,
        'status_code': status_code,
        'status_title': title_text
    }
    return render(request, 'statuses.html', context)

@login_required(login_url='login')
def project(request):
    query = (request.GET.get('q') or '').strip()
    selected_status = (request.GET.get('status') or '').lower()
    projects = Project.objects.select_related('district', 'category').order_by('-updated_at')
    if query:
        projects = projects.filter(
            Q(project_title__icontains=query)
            | Q(reference_code__icontains=query)
            | Q(project_location__icontains=query)
            | Q(implementing_agency__icontains=query)
        )
    if selected_status in dict(Project.STATUS_CHOICES):
        projects = projects.filter(project_status=selected_status)

    status_counts = {
        status: Project.objects.filter(project_status=status).count()
        for status, _label in Project.STATUS_CHOICES
    }
    financials = Project.objects.aggregate(
        total_budget=Sum('project_Budgeting'),
        total_spent=Sum('amount_spent'),
    )
    total_budget = financials['total_budget'] or 0
    total_spent = financials['total_spent'] or 0
    paginator = Paginator(projects, 9)
    page_obj = paginator.get_page(request.GET.get('page'))
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)

    context = {
        'projects': page_obj,
        'participants': participants,
        'status_counts': status_counts,
        'total_projects': sum(status_counts.values()),
        'total_budget': total_budget,
        'total_spent': total_spent,
        'total_remaining': total_budget - total_spent,
        'budget_utilization': round(float(total_spent / total_budget * 100), 1) if total_budget else 0,
        'selected_status': selected_status,
        'query': query,
    }
    return render(request, "project.html",context)

@login_required(login_url='login')
def UpcomingStatuses(request, pk):
    target_project = get_object_or_404(Project, id=pk)
    projects = [target_project]
    participants = get_participants_for_request(request, limit=5)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = target_project
            participation.save()
            messages.success(request, f"Feedback submitted for '{target_project.project_title}'.")
            return redirect('upcoming')

    context = {
        'projects': projects,
        'project': target_project,
        'project_status': target_project.project_status,
        'Participants': participants,
        'today': django_timezone.now().date(),
        'form': form
    }
    return render(request, 'statuses.html', context)


@login_required(login_url='login')
def CompletedStatuses(request, pk):
    target_project = get_object_or_404(Project, id=pk)
    projects = [target_project]
    participants = get_participants_for_request(request, limit=5)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = target_project
            participation.save()
            messages.success(request, f"Feedback submitted for '{target_project.project_title}'.")
            return redirect('completed')

    completed_qs = Project.objects.filter(project_status='completed')
    total_budget = completed_qs.aggregate(t=Sum('project_Budgeting'))['t'] or 0
    total_spent = completed_qs.aggregate(t=Sum('amount_spent'))['t'] or 0
    budget_utilization = round((total_spent / total_budget) * 100, 1) if total_budget else 0
    overdue_count = completed_qs.filter(
        end_date__lt=django_timezone.now().date(),
        actual_end_date__isnull=True,
    ).count()
    locations = completed_qs.exclude(project_location__isnull=True).exclude(
        project_location=''
    ).values_list('project_location', flat=True).distinct()

    context = {
        'projects': projects,
        'project': target_project,
        'project_status': target_project.project_status,
        'status_title': 'Completed Projects',
        'total_count': 1,
        'total_budget': total_budget,
        'total_spent': total_spent,
        'budget_utilization': budget_utilization,
        'overdue_count': overdue_count,
        'locations': locations,
        'Participants': participants,
        'today': django_timezone.now().date(),
        'form': form
    }
    return render(request, 'statuses.html', context)


@login_required(login_url='login')
def OngoingStatuses(request, pk):
    target_project = get_object_or_404(Project, id=pk)
    projects = [target_project]
    participants = get_participants_for_request(request, limit=5)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = target_project
            participation.save()
            messages.success(request, f"Feedback submitted for '{target_project.project_title}'.")
            return redirect('ongoing')

    context = {
        'projects': projects,
        'project': target_project,
        'project_status': target_project.project_status,
        'Participants': participants,
        'today': django_timezone.now().date(),
        'form': form
    }
    return render(request, 'statuses.html', context)

@login_required(login_url='login')
def divisionform(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    form = ProjectDivisionForm()
    if request.method == 'POST':
        form = ProjectDivisionForm(request.POST, request.FILES)
        if form.is_valid():
            division = form.save()
            audit(request, 'created', division, changes={'name': str(division)})
            messages.success(request, f"Project Division '{division}' created successfully!")
            return redirect('division_details')
    context = {'form': form, 'participants': participants}
    return render(request, 'division.html', context)


@login_required(login_url='login')
def Division_details(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    query = request.GET.get('q', '').strip()
    selected_type = request.GET.get('type', '').strip()

    divisions = Project_Division.objects.select_related('project_type', 'head_user').prefetch_related('project_name')

    if query:
        divisions = divisions.filter(
            Q(name__icontains=query) |
            Q(code__icontains=query) |
            Q(description__icontains=query) |
            Q(head_of_division__icontains=query)
        )

    if selected_type and selected_type.isdigit():
        divisions = divisions.filter(project_type_id=int(selected_type))

    total_divisions = divisions.count()
    active_divisions = divisions.filter(is_active=True).count()
    project_types = Project_type.objects.order_by('name')

    total_allocated = sum([float(d.total_budget_allocated or 0) for d in divisions])
    total_spent = sum([float(d.total_budget_spent or 0) for d in divisions])

    context = {
        'divisions': divisions,
        'participants': participants,
        'query': query,
        'selected_type': selected_type,
        'project_types': project_types,
        'total_divisions': total_divisions,
        'active_divisions': active_divisions,
        'total_allocated': total_allocated,
        'total_spent': total_spent,
    }
    return render(request, 'division_details.html', context)


@login_required(login_url='login')
def Division_view(request, pk):
    division = get_object_or_404(
        Project_Division.objects.select_related('project_type', 'head_user').prefetch_related('project_name'),
        id=pk
    )
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    assigned_projects = division.project_name.select_related('district', 'category').all()

    total_projects = assigned_projects.count()
    ongoing_count = assigned_projects.filter(project_status='ongoing').count()
    completed_count = assigned_projects.filter(project_status='completed').count()
    delayed_count = assigned_projects.filter(project_status='delayed').count()
    upcoming_count = assigned_projects.filter(project_status='upcoming').count()

    total_allocated = float(division.total_budget_allocated or 0)
    total_spent = float(division.total_budget_spent or 0)
    remaining_budget = total_allocated - total_spent
    utilization_rate = division.utilization_rate

    context = {
        'division': division,
        'participants': participants,
        'assigned_projects': assigned_projects,
        'total_projects': total_projects,
        'ongoing_count': ongoing_count,
        'completed_count': completed_count,
        'delayed_count': delayed_count,
        'upcoming_count': upcoming_count,
        'total_allocated': total_allocated,
        'total_spent': total_spent,
        'remaining_budget': remaining_budget,
        'utilization_rate': utilization_rate,
    }
    return render(request, 'division_view.html', context)


@login_required(login_url='login')
def edit_division(request, pk):
    editdivision = get_object_or_404(Project_Division, id=pk)
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    form = ProjectDivisionForm(instance=editdivision)
    if request.method == 'POST':
        form = ProjectDivisionForm(request.POST, request.FILES, instance=editdivision)
        if form.is_valid():
            division = form.save()
            audit(request, 'updated', division, changes={'name': str(division)})
            messages.success(request, f"Project Division '{division}' updated successfully!")
            return redirect('division_details')

    context = {'form': form, 'division': editdivision, 'participants': participants}
    return render(request, 'division.html', context)


@login_required(login_url='login')
def delete_division(request, pk):
    division = get_object_or_404(Project_Division, id=pk)
    if request.method == 'POST':
        name = str(division)
        audit(request, 'deleted', division, changes={'name': name})
        division.delete()
        messages.success(request, f"Project Division '{name}' deleted successfully!")
        return redirect('division_details')

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    context = {'division': division, 'participants': participants}
    return render(request, 'delete/delete_division.html', context)


@login_required(login_url='login')
def ProjectTypes(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    ptypes=Project_type.objects.all()


    context={'participants':participants, 'ptypes':ptypes}
    return render(request,'projectType.html',context)


@login_required(login_url='login')
def ptypes(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    form=ProjectTypeForm()
    if request.method=='POST':
        form=ProjectTypeForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('division_details')
    context={'form':form, 'participants':participants}
    return render(request,'projectTypes.html',context)

@login_required(login_url='login')
def charts(request):
    projects=Project.objects.all().values('project_status').annotate(total=Count('project_status')).order_by('-total')

    context={
        'projects':projects,
    }
    return render(request,'chart.html',context)



@login_required(login_url='login')
def milestone_list(request):
    milestones = Milestone.objects.select_related('project', 'stage').all().order_by('-due_date', '-id')

    # Search query
    query = request.GET.get('q', '').strip()
    if query:
        milestones = milestones.filter(
            Q(title__icontains=query) |
            Q(description__icontains=query) |
            Q(project__project_title__icontains=query) |
            Q(stage__name__icontains=query)
        )

    # Filter by project
    project_id = request.GET.get('project', '').strip()
    if project_id and project_id.isdigit():
        milestones = milestones.filter(project_id=int(project_id))

    # Filter by status
    status = request.GET.get('status', '').strip()
    if status:
        milestones = milestones.filter(status=status)

    # Filter by stage
    stage_id = request.GET.get('stage', '').strip()
    if stage_id and stage_id.isdigit():
        milestones = milestones.filter(stage_id=int(stage_id))

    # Key Performance Indicators (KPIs)
    all_milestones = Milestone.objects.all()
    total_milestones = all_milestones.count()
    completed_count = all_milestones.filter(status='completed').count()
    in_progress_count = all_milestones.filter(status='in_progress').count()
    pending_count = all_milestones.filter(status='pending').count()
    missed_count = all_milestones.filter(status='missed').count()

    today = date.today()
    overdue_count = all_milestones.filter(due_date__lt=today).exclude(status='completed').count()

    avg_progress_agg = all_milestones.aggregate(Avg('progress_percentage'))['progress_percentage__avg']
    avg_progress = round(avg_progress_agg, 1) if avg_progress_agg is not None else 0

    completion_rate = round((completed_count / total_milestones * 100), 1) if total_milestones > 0 else 0

    projects = Project.objects.all().order_by('project_title')
    stages = ProjectStage.objects.all().order_by('stage_name')

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    context = {
        'milestones': milestones,
        'participants': participants,
        'projects': projects,
        'stages': stages,
        'stats': {
            'total': total_milestones,
            'completed': completed_count,
            'in_progress': in_progress_count,
            'pending': pending_count,
            'missed': missed_count,
            'overdue': overdue_count,
            'avg_progress': avg_progress,
            'completion_rate': completion_rate,
        },
        'query': query,
        'selected_project': project_id,
        'selected_status': status,
        'selected_stage': stage_id,
    }
    return render(request, 'milestone_list.html', context)


@login_required(login_url='login')
def milestone_detail(request, pk):
    milestone = get_object_or_404(Milestone.objects.select_related('project', 'stage'), pk=pk)
    sibling_milestones = Milestone.objects.filter(project=milestone.project).exclude(pk=milestone.pk)

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    context = {
        'milestone': milestone,
        'project': milestone.project,
        'stage': milestone.stage,
        'sibling_milestones': sibling_milestones,
        'participants': participants,
    }
    return render(request, 'milestone_detail.html', context)


@login_required(login_url='login')
def milestone_create(request):
    initial = {}
    if request.GET.get('project'):
        initial['project'] = request.GET.get('project')

    if request.method == 'POST':
        form = MilestoneForm(request.POST)
        if form.is_valid():
            milestone_obj = form.save(commit=False)
            if milestone_obj.progress_percentage == 100 and milestone_obj.status != 'completed':
                milestone_obj.status = 'completed'
                if not milestone_obj.completion_date:
                    milestone_obj.completion_date = date.today()
            milestone_obj.save()

            audit(request, 'created', milestone_obj, project=milestone_obj.project, changes={'title': milestone_obj.title})
            messages.success(request, f"Milestone '{milestone_obj.title}' created successfully!")
            return redirect('milestone_list')
    else:
        form = MilestoneForm(initial=initial)

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    return render(request, 'milestone_form.html', {'form': form, 'title': 'Create New Milestone', 'participants': participants})


@login_required(login_url='login')
def milestone_update(request, pk):
    milestone_obj = get_object_or_404(Milestone, pk=pk)
    if request.method == 'POST':
        form = MilestoneForm(request.POST, instance=milestone_obj)
        if form.is_valid():
            milestone_obj = form.save(commit=False)
            if milestone_obj.progress_percentage == 100 and milestone_obj.status != 'completed':
                milestone_obj.status = 'completed'
                if not milestone_obj.completion_date:
                    milestone_obj.completion_date = date.today()
            milestone_obj.save()

            audit(request, 'updated', milestone_obj, project=milestone_obj.project, changes={'title': milestone_obj.title})
            messages.success(request, f"Milestone '{milestone_obj.title}' updated successfully!")
            return redirect('milestone_list')
    else:
        form = MilestoneForm(instance=milestone_obj)

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    return render(request, 'milestone_form.html', {'form': form, 'milestone': milestone_obj, 'title': 'Edit Milestone', 'participants': participants})


@login_required(login_url='login')
def milestone_quick_update(request, pk):
    milestone_obj = get_object_or_404(Milestone, pk=pk)
    if request.method == 'POST':
        status = request.POST.get('status')
        progress = request.POST.get('progress_percentage')

        if status in [choice[0] for choice in Milestone.STATUS_CHOICES]:
            milestone_obj.status = status
            if status == 'completed' and not milestone_obj.completion_date:
                milestone_obj.completion_date = date.today()
                if not progress:
                    milestone_obj.progress_percentage = 100

        if progress is not None and progress != '':
            try:
                p_val = int(progress)
                if 0 <= p_val <= 100:
                    milestone_obj.progress_percentage = p_val
                    if p_val == 100:
                        milestone_obj.status = 'completed'
                        if not milestone_obj.completion_date:
                            milestone_obj.completion_date = date.today()
            except ValueError:
                pass

        milestone_obj.save()
        audit(request, 'quick_updated', milestone_obj, project=milestone_obj.project, changes={'status': milestone_obj.status, 'progress': milestone_obj.progress_percentage})
        messages.success(request, f"Milestone '{milestone_obj.title}' updated.")
    return redirect(request.META.get('HTTP_REFERER', 'milestone_list'))


@login_required(login_url='login')
def milestone_delete(request, pk):
    milestone_obj = get_object_or_404(Milestone, pk=pk)
    if request.method == 'POST':
        title = milestone_obj.title
        audit(request, 'deleted', milestone_obj, project=milestone_obj.project, changes={'title': title})
        milestone_obj.delete()
        messages.success(request, f"Milestone '{title}' deleted.")
        return redirect('milestone_list')

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    return render(request, 'milestone_confirm_delete.html', {'milestone': milestone_obj, 'participants': participants})



@login_required(login_url='login')
def notification_list(request):
    notifications = Notification.objects.all()
    return render(request, 'notification_list.html', {'notifications': notifications})

@login_required(login_url='login')
def notification_create(request):
    form=NotificationForm()
    if request.method=='POST':
        form=NotificationForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('notification_list')

    return render(request, 'notification_create.html',{'form':form})


@login_required(login_url='login')
@require_GET
def api_unread_notifications(request):
    qs = Notification.objects.filter(user=request.user)
    unread_count = qs.filter(is_read=False).count()
    recent = list(qs.order_by('-created_at')[:10])

    data = []
    for n in recent:
        data.append({
            'id': n.id,
            'title': n.title or 'Notification',
            'message': n.message or '',
            'notification_type': n.notification_type or 'system',
            'link': n.link or '/notifications/',
            'is_read': n.is_read,
            'created_at': n.created_at.strftime('%Y-%m-%d %H:%M') if n.created_at else '',
            'timesince': f"{timesince(n.created_at)} ago" if n.created_at else 'just now',
        })

    latest_id = data[0]['id'] if data else 0
    return JsonResponse({
        'status': 'success',
        'unread_count': unread_count,
        'notifications': data,
        'latest_id': latest_id,
    })


@login_required(login_url='login')
def api_mark_notification_read(request, pk):
    try:
        notification = Notification.objects.get(id=pk, user=request.user)
        if not notification.is_read:
            notification.is_read = True
            notification.save(update_fields=['is_read'])
        return JsonResponse({'status': 'success', 'id': pk})
    except Notification.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Notification not found'}, status=404)


@login_required(login_url='login')
def api_mark_all_read(request):
    Notification.objects.filter(user=request.user, is_read=False).update(is_read=True)
    return JsonResponse({'status': 'success'})


@login_required(login_url='login')
def media_list(request):
    if request.method == 'POST':
        form = MediaForm(request.POST, request.FILES)
        if form.is_valid():
            media_item = form.save(commit=False)
            if request.user.is_authenticated:
                media_item.uploaded_by = request.user
            media_item.save()
            messages.success(request, 'Media asset uploaded successfully.')
            return redirect('media_list')
    else:
        form = MediaForm()

    media_files = Media.objects.select_related('project', 'uploaded_by').all().order_by('-uploaded_at', '-id')

    project_id = request.GET.get('project')
    media_type = request.GET.get('type')
    search_query = request.GET.get('q')

    if project_id:
        media_files = media_files.filter(project_id=project_id)
    if media_type and media_type != 'all':
        media_files = media_files.filter(media_type__iexact=media_type)
    if search_query:
        media_files = media_files.filter(
            Q(caption__icontains=search_query) |
            Q(file__icontains=search_query) |
            Q(project__project_title__icontains=search_query)
        )

    projects = Project.objects.all().order_by('project_title')

    all_media = Media.objects.all()
    total_media = all_media.count()
    total_images = all_media.filter(media_type__iexact='image').count()
    total_videos = all_media.filter(media_type__iexact='video').count()
    total_docs = all_media.filter(Q(media_type__iexact='pdf') | Q(media_type__iexact='document')).count()
    projects_count = all_media.exclude(project__isnull=True).values('project').distinct().count()

    context = {
        "media_files": media_files,
        "form": form,
        "projects": projects,
        "total_media": total_media,
        "total_images": total_images,
        "total_videos": total_videos,
        "total_docs": total_docs,
        "projects_count": projects_count,
        "selected_project": int(project_id) if project_id and project_id.isdigit() else None,
        "selected_type": media_type or 'all',
        "search_query": search_query or '',
    }

    return render(request, "media_list.html", context)

@login_required(login_url='login')
def media_upload(request):
    form = MediaForm()
    if request.method == 'POST':
        form = MediaForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('media_list')

    return render(request, 'media_upload.html', {'form': form})


def delete_media(request, id):
    media = get_object_or_404(Media, id=id)
    media.delete()
    return redirect('media_list')

@login_required(login_url='login')
def milestone(request):
    milestones=Milestone.objects.all()
    return render(request,'milestone.html',{'milestones':milestones})




# 🔹 Project Detail View
@login_required(login_url='login')
def project_detail(request, pk):
    project = get_object_or_404(
        Project.objects.select_related('category', 'district', 'project_division', 'created_by'),
        id=pk
    )
    comments = project.comments.select_related('user').order_by('-created_at')
    stages = project.stages.prefetch_related('milestones').all()
    milestones = project.milestones.all()
    expenses = project.expenses.all()
    media = project.media.all()
    documents = project.documents.all()
    progress_reports = project.progress_reports.all()
    risks = project.risks.all()
    issues = project.issues.all()
    tenders = project.tenders.all()

    # Calculate financial metrics
    b_total = float(project.project_Budgeting or 0)
    s_total = float(project.amount_spent or 0)
    remaining = max(0.0, b_total - s_total)
    utilization = round((s_total / b_total * 100), 1) if b_total > 0 else 0.0

    if request.method == "POST":
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.project = project
            comment.user = request.user
            comment.save()
            return redirect('project_details', pk=project.id)
    else:
        form = CommentForm()

    context = {
        'project': project,
        'comments': comments,
        'stages': stages,
        'milestones': milestones,
        'expenses': expenses,
        'media': media,
        'documents': documents,
        'progress_reports': progress_reports,
        'risks': risks,
        'issues': issues,
        'tenders': tenders,
        'b_total': b_total,
        's_total': s_total,
        'remaining': remaining,
        'utilization': utilization,
        'form': form,
    }
    return render(request, 'project_detail.html', context)

# 🔹 Progress Report View
@login_required(login_url='login')
def upload_progress_report(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    if request.method == "POST":
        form = ProgressReportForm(request.POST, request.FILES)
        if form.is_valid():
            report = form.save(commit=False)
            report.project = project
            report.save()
            return redirect('project_details', pk=project.id)
    else:
        form = ProgressReportForm()
    return render(request, 'upload_progress_report.html', {'form': form, 'project': project})

# 🔹 Tender View
@login_required(login_url='login')
def upload_tender(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    if request.method == "POST":
        form = TenderForm(request.POST, request.FILES)
        if form.is_valid():
            tender = form.save(commit=False)
            tender.project = project
            tender.save()
            return redirect('project_details', pk=project.id)
    else:
        form = TenderForm()
    return render(request, 'upload_tender.html', {'form': form, 'project': project})

# 🔹 Report Issue View

@login_required(login_url='login')
def issue_list(request):
    issues = ReportIssue.objects.all() if (request.user.is_superuser or request.user.role in OFFICER_ROLES) else ReportIssue.objects.filter(user=request.user)
    return render(request, 'issue_list.html', {'issues': issues})

@login_required(login_url='login')
def add_report_issue(request):
    form=ReportIssueForm()
    if request.method == "POST":
        form = ReportIssueForm(request.POST, request.FILES)
        if form.is_valid():
            issue = form.save(commit=False)
            issue.user = request.user
            issue.save()
            audit(request, 'issue_reported', issue, project=issue.project)
            if issue.project.created_by:
                notify(issue.project.created_by, 'issue', 'New project issue', issue.title, f'/issues/{issue.id}/')
            return redirect('issue_list')

    return render(request, 'report_issue.html', {'form': form})

@login_required(login_url='login')
def issue_detail(request, issue_id):
    issue = get_object_or_404(ReportIssue, id=issue_id)
    return render(request, 'issue_detail.html', {'issue': issue})



# List all tenders
@login_required(login_url='login')
def tender_list(request):
    tenders = Tender.objects.all().select_related('project', 'awarded_to').prefetch_related('applications')
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)

    is_officer = request.user.is_superuser or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES)

    return render(request, 'tender_list.html', {
        'tenders': tenders,
        'participants': participants,
        'is_officer': is_officer,
    })

# View tender details with complete bids and awarded contractor integration
@login_required(login_url='login')
def tender_detail(request, tender_id):
    tender = get_object_or_404(Tender.objects.select_related('project', 'created_by', 'awarded_to'), id=tender_id)
    applications = tender.applications.select_related('applicant').order_by('-total_score', '-submitted_at')

    context = {
        'tender': tender,
        'applications': applications,
        'applications_count': applications.count(),
        'is_officer': request.user.is_superuser or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES),
    }
    return render(request, 'tender_detail.html', context)


@login_required(login_url='login')
def apply_tender(request, pk):
    tender = get_object_or_404(Tender, id=pk)
    if tender.status == 'closed' or (tender.closing_date and tender.closing_date < django_timezone.localdate()):
        messages.error(request, 'This tender is closed for applications.')
        return redirect('tender_detail', tender_id=tender.id)

    if TenderApplication.objects.filter(tender=tender, applicant=request.user).exists():
        messages.error(request, 'You have already submitted an application for this tender.')
        return redirect('track_application')

    form = TenderApplicationForm(request.POST or None, request.FILES or None)

    if form.is_valid():
        application = form.save(commit=False)
        application.tender = tender
        application.applicant = request.user
        application.save()

        # Ensure Contractor profile exists or is created for company
        contractor, created = Contractor.objects.get_or_create(
            company=application.company_name or request.user.username,
            defaults={
                'name': request.user.get_full_name() or application.company_name or request.user.username,
                'email': application.company_email or request.user.email,
                'phone': application.company_phone or '',
                'location': tender.project.project_location if (tender.project and tender.project.project_location) else 'National',
            }
        )

        audit(request, 'tender_application_submitted', application, project=tender.project)
        notify(tender.created_by, 'tender', 'New tender application', f'{application.company_name} applied for {tender.reference_number}.', f'/tenders/{tender.id}/')
        messages.success(request, "Your tender application has been submitted successfully!")
        return redirect('track_application')

    context = {
        'tender': tender,
        'form': form,
    }
    return render(request, 'apply_tender.html', context)

def calculate_financial_scores(tender):
    applications = tender.applications.all()

    if not applications.exists():
        return

    valid_bids = [app.bid_amount for app in applications if app.bid_amount is not None]
    if not valid_bids:
        return

    lowest_bid = float(min(valid_bids))

    for app in applications:
        bid = float(app.bid_amount or 0)
        if bid > 0:
            app.financial_score = (lowest_bid / bid) * 100.0
        else:
            app.financial_score = 0.0

        app.total_score = (float(app.technical_score or 0) * 0.7) + (float(app.financial_score or 0) * 0.3)
        app.save()

@login_required(login_url='login')
@role_required(*OFFICER_ROLES)
def evaluate_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    applications = tender.applications.all()

    if tender.status in ('awarded', 'cancelled'):
        messages.error(request, 'This tender is already awarded or cancelled and cannot be evaluated.')
        return redirect('tender_detail', tender_id=tender.id)

    if request.method == "POST":
        for app in applications:
            score = request.POST.get(f"tech_{app.id}")
            if score:
                try:
                    app.technical_score = float(score)
                    app.save()
                except (ValueError, TypeError):
                    pass

        # 🔥 Auto calculate financial + total
        calculate_financial_scores(tender)
        tender.status = 'evaluating'
        tender.save(update_fields=['status'])
        audit(request, 'tender_evaluated', tender, project=tender.project)
        messages.success(request, "Tender evaluation scores updated successfully.")

        return redirect('evaluate_tender', tender_id=tender.id)

    return render(request, 'evaluate_tender.html', {
        'tender': tender,
        'applications': applications
    })

@login_required(login_url='login')
@role_required(*OFFICER_ROLES)
def award_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    if request.method != 'POST':
        return HttpResponseBadRequest('Tender awards must be submitted with POST.')

    with transaction.atomic():
        app_id = request.POST.get('application_id')
        if app_id:
            winner = get_object_or_404(TenderApplication, id=app_id, tender=tender)
        else:
            winner = tender.applications.order_by('-total_score', 'submitted_at').first()

        if not winner:
            messages.error(request, 'This tender has no applications to award.')
            return redirect('tender_detail', tender_id=tender.id)

        tender.applications.exclude(pk=winner.pk).update(status='rejected')
        winner.status = 'awarded'
        winner.save(update_fields=['status'])

        # Auto Link or Create Contractor profile
        company_name = winner.company_name or (winner.applicant.get_full_name() if winner.applicant else 'Contractor Company')
        contractor = Contractor.objects.filter(company=company_name).first()
        if not contractor and winner.applicant:
            contractor = Contractor.objects.filter(email=winner.company_email or winner.applicant.email).first()
        if not contractor:
            contractor = Contractor.objects.create(
                company=company_name,
                name=(winner.applicant.get_full_name() if winner.applicant and winner.applicant.get_full_name() else company_name),
                email=winner.company_email or (winner.applicant.email if winner.applicant else ''),
                phone=winner.company_phone or '',
                location=(tender.project.project_location if (tender.project and tender.project.project_location) else 'National'),
            )

        if tender.project:
            contractor.projects.add(tender.project)
            tender.project.project_contractor = contractor.company or contractor.name
            tender.project.save(update_fields=['project_contractor'])

        tender.status = 'awarded'
        tender.awarded_to = contractor
        tender.award_date = django_timezone.localdate()
        tender.award_amount = winner.bid_amount
        tender.save(update_fields=['status', 'awarded_to', 'award_date', 'award_amount'])

    audit(request, 'tender_awarded', tender, project=tender.project, changes={'application_id': winner.id, 'contractor_id': contractor.id})
    notify(winner.applicant, 'tender', 'Tender awarded', f'Congratulations! Your bid for {tender.reference_number} has been awarded.', '/track_application/')
    messages.success(request, f'Tender {tender.reference_number} successfully awarded to {contractor.company or contractor.name}!')
    return redirect('tender_detail', tender_id=tender.id)

# Add a new tender
@login_required(login_url='login')
def add_tender(request):
    pr = Project.objects.all()
    form = TenderForm(request.POST or None, request.FILES or None)

    if request.method == "POST" and form.is_valid():
        tender = form.save(commit=False)
        tender.created_by = request.user
        if not tender.status or tender.status == 'draft':
            tender.status = 'published'
        tender.save()
        messages.success(request, "New tender created successfully.")
        return redirect('tender_list')

    return render(request, 'tender_form.html', {'form': form, 'pr': pr, 'title': 'Add New Tender'})

# Update an existing tender
@login_required(login_url='login')
def update_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    pr = Project.objects.all()
    if request.method == "POST":
        form = TenderForm(request.POST, request.FILES, instance=tender)
        if form.is_valid():
            form.save()
            messages.success(request, "Tender updated successfully.")
            return redirect('tender_list')
    else:
        form = TenderForm(instance=tender)
    return render(request, 'tender_form.html', {'form': form, 'pr': pr, 'title': 'Update Tender', 'tender': tender})

# Delete a tender
@login_required(login_url='login')
def delete_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    if request.method == "POST":
        tender.delete()
        messages.success(request, "Tender deleted successfully.")
        return redirect('tender_list')
    return render(request, 'confirm_delete.html', {'object': tender, 'title': 'Delete Tender'})
    return render(request, 'confirm_delete.html', {'object': tender, 'title': 'Delete Tender'})


@login_required(login_url='login')
def comment_list(request):
    comments = Comment.objects.all()
    return  render(request, 'comment_list.html', { 'comments': comments})


@login_required(login_url='login')
def add_comment(request, pk):
    projects = get_object_or_404(Comment, id=pk)
    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.projects = projects
            comment.save()
            messages.success(request, 'Comment added successfully!')
            return redirect('projectoverview')  # Or redirect to a detail page for the project
    else:
        form = CommentForm()

    return render(request, "add_comment.html", {
        'project': projects,
        'form': form
    })
@login_required(login_url='login')
def AuditLogs(request):
    query = request.GET.get('q', '').strip()
    action_filter = request.GET.get('action', '').strip()
    project_filter = request.GET.get('project', '').strip()

    auditing = AuditLog.objects.select_related('user', 'project').all().order_by('-timestamp')

    if query:
        auditing = auditing.filter(
            Q(action__icontains=query) |
            Q(user__username__icontains=query) |
            Q(user__email__icontains=query) |
            Q(model_name__icontains=query) |
            Q(project__project_title__icontains=query) |
            Q(ip_address__icontains=query)
        )

    if action_filter:
        auditing = auditing.filter(action=action_filter)

    if project_filter:
        auditing = auditing.filter(project_id=project_filter)

    total_audits = auditing.count()
    today = django_timezone.now().date()
    today_count = AuditLog.objects.filter(timestamp__date=today).count()
    active_users = AuditLog.objects.values('user').distinct().count()
    unique_actions = AuditLog.objects.values('action').distinct().count()

    paginator = Paginator(auditing, 15)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    distinct_actions = AuditLog.objects.values_list('action', flat=True).distinct()
    projects = Project.objects.order_by('project_title')

    context = {
        'auditing': page_obj,
        'total_audits': total_audits,
        'today_count': today_count,
        'active_users': active_users,
        'unique_actions': unique_actions,
        'query': query,
        'action_filter': action_filter,
        'project_filter': project_filter,
        'distinct_actions': distinct_actions,
        'projects': projects,
    }
    return render(request, 'audit.html', context)


@login_required(login_url='login')
def add_audit(request):
    form = AuditLogForm(request.POST or None, request.FILES or None)
    if request.method == 'POST':
        if form.is_valid():
            audit_log = form.save(commit=False)
            if not audit_log.user and request.user.is_authenticated:
                audit_log.user = request.user
            if not audit_log.ip_address:
                x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
                if x_forwarded_for:
                    ip = x_forwarded_for.split(',')[0].strip()
                else:
                    ip = request.META.get('REMOTE_ADDR') or '127.0.0.1'
                audit_log.ip_address = ip
            audit_log.save()
            messages.success(request, 'Audit log entry created successfully.')
            return redirect('AuditLog')
        else:
            messages.error(request, 'Failed to save audit log. Please check the form errors below.')

    return render(request, 'add_audit.html', {'form': form, 'projects': Project.objects.order_by('project_title')})


@login_required(login_url='login')
def audit_details(request, pk):
    audit_item = get_object_or_404(AuditLog.objects.select_related('user', 'project'), id=pk)
    if request.method == 'POST':
        form = AuditLogForm(request.POST, request.FILES, instance=audit_item)
        if form.is_valid():
            form.save()
            messages.success(request, 'Audit log updated successfully.')
            return redirect('AuditLog')
    else:
        form = AuditLogForm(instance=audit_item)

    context = {
        'audit_details': audit_item,
        'form': form,
    }
    return render(request, 'audit_details.html', context)


@login_required(login_url='login')
def delete_audit(request, pk):
    audit_item = get_object_or_404(AuditLog, id=pk)
    if not (request.user.is_superuser or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES)):
        messages.error(request, "You do not have permission to delete audit records.")
        return redirect('AuditLog')

    if request.method == 'POST':
        audit_item.delete()
        messages.success(request, 'Audit log deleted successfully.')
        return redirect('AuditLog')

    return render(request, 'confirm_delete.html', {'object': f'Audit #{audit_item.id} - {audit_item.action}', 'title': 'Delete Audit Record'})

# 🔹 List All Project Stages

@login_required(login_url='login')
def projectstage(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    stages = ProjectStage.objects.select_related('project').all()

    # Search & Filtering
    q = request.GET.get('q', '').strip()
    project_id = request.GET.get('project', '').strip()
    stage_name = request.GET.get('stage_name', '').strip()

    if q:
        stages = stages.filter(
            Q(project__project_title__icontains=q) |
            Q(description__icontains=q) |
            Q(stage_name__icontains=q)
        )

    if project_id and project_id.isdigit():
        stages = stages.filter(project_id=int(project_id))

    if stage_name:
        stages = stages.filter(stage_name=stage_name)

    stages = stages.order_by('order', '-start_date')

    context = {
        'stages': stages,
        'participants': participants,
        'q': q,
        'selected_project': project_id,
        'selected_stage_name': stage_name,
        'projects': Project.objects.order_by('project_title'),
        'stage_choices': ProjectStage.STAGES,
    }
    return render(request, 'projectstage_list.html', context)

# 🔹 View Project Stage Details
@login_required(login_url='login')
def projectstage_details(request, pk):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    stage = get_object_or_404(ProjectStage.objects.select_related('project'), pk=pk)
    return render(request, 'projectstage_detail.html', {'stage': stage, 'participants': participants})


@login_required(login_url='login')
def ProjectStageCreate(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    initial = {}
    if request.GET.get('project'):
        initial['project'] = request.GET.get('project')

    if request.method == 'POST':
        form = ProjectStageForm(request.POST, request.FILES)
        if form.is_valid():
            stage = form.save()
            audit(request, 'created', stage, project=stage.project, changes={'stage_name': stage.stage_name})
            messages.success(request, f"Project stage '{stage.get_stage_name_display()}' created successfully.")
            return redirect('projectstage_list')
    else:
        form = ProjectStageForm(initial=initial)

    context = {'form': form, 'participants': participants}
    return render(request, 'projectstage_form.html', context)

# 🔹 Update Project Stage
@login_required(login_url='login')
def ProjectStageUpdate(request, pk):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    updatestage = get_object_or_404(ProjectStage.objects.select_related('project'), pk=pk)
    if request.method == 'POST':
        form = ProjectStageForm(request.POST, request.FILES, instance=updatestage)
        if form.is_valid():
            stage = form.save()
            audit(request, 'updated', stage, project=stage.project, changes={'stage_name': stage.stage_name})
            messages.success(request, f"Project stage '{stage.get_stage_name_display()}' updated successfully.")
            return redirect('projectstage_list')
    else:
        form = ProjectStageForm(instance=updatestage)

    context = {'form': form, 'participants': participants, 'updatestage': updatestage, 'stage': updatestage}
    return render(request, 'projectstage_update.html', context)




# 🔹 Delete Project Stage
@login_required(login_url='login')
def ProjectStageDelete(request, pk):
    stage = get_object_or_404(ProjectStage.objects.select_related('project'), id=pk)
    if request.method == 'POST':
        stage_title = f"{stage.project.project_title} - {stage.get_stage_name_display()}"
        audit(request, 'deleted', stage, project=stage.project, changes={'stage_name': stage.stage_name})
        stage.delete()
        messages.success(request, f"Project stage '{stage_title}' deleted successfully.")
        return redirect('projectstage_list')

    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)

    return render(request, 'projectstage_confirm_delete.html', {'stage': stage, 'deletestage': stage, 'participants': participants})

def sms_dashboard(request):
    return render(request, 'sms/intergration.html')


@login_required(login_url='login')
@role_required(*OFFICER_ROLES)
def send_sms_report(request):
    if request.method == "POST":
        phone = request.POST.get('phone')
        message = request.POST.get('message')
        if not phone or not message:
            messages.error(request, 'Phone number and message are required.')
            return redirect('sms_dashboard')
        # An external delivery provider is intentionally not faked. Keep a traceable
        # in-platform notification until a configured SMS gateway is connected.
        audit(request, 'sms_queued', request.user, changes={'phone': phone, 'message': message})
        messages.info(request, 'Message recorded. Configure an SMS gateway before claiming delivery.')
        return redirect('sms_dashboard')
    return redirect('sms_dashboard')


def check_project_status(request):
    code = request.GET.get('code')

    # Dummy response
    context = {
        "code": code,
        "status": "65% Complete"
    }
    return render(request, 'sms/status.html', context)

@login_required(login_url='login')
def regional_analysis(request):
    regions = list(Project.objects.exclude(project_location__isnull=True).exclude(project_location='').values_list('project_location', flat=True).distinct().order_by('project_location'))

    region1 = request.GET.get('region1')
    region2 = request.GET.get('region2')

    # Default to top regions if not specified
    if not region1 and len(regions) > 0:
        region1 = regions[0]
    if not region2 and len(regions) > 1:
        region2 = regions[1]

    def get_region_data(region_name):
        if region_name:
            projects = Project.objects.filter(project_location=region_name)
        else:
            projects = Project.objects.all()

        total_projects = projects.count()
        if total_projects == 0:
            return {
                "name": region_name or "National Average",
                "total": 0,
                "completed": 0,
                "ongoing": 0,
                "delayed": 0,
                "upcoming": 0,
                "stalled": 0,
                "suspended": 0,
                "cancelled": 0,
                "completion_rate": 0.0,
                "total_allocated": 0.0,
                "total_spent": 0.0,
                "budget_remaining": 0.0,
                "budget_utilization": 0.0,
                "avg_project_budget": 0.0,
                "avg_risk_score": 0.0,
                "high_risk_count": 0,
                "reported_issues": 0,
                "open_issues": 0,
                "resolved_issues": 0,
                "citizen_requests": 0,
                "comments_count": 0,
                "top_projects": [],
                "sector_labels": [],
                "sector_values": [],
                "projects_list": [],
            }

        completed = projects.filter(project_status='completed').count()
        ongoing = projects.filter(project_status='ongoing').count()
        delayed = projects.filter(project_status='delayed').count()
        upcoming = projects.filter(project_status='upcoming').count()
        stalled = projects.filter(project_status='stalled').count()
        suspended = projects.filter(project_status='suspended').count()
        cancelled = projects.filter(project_status='cancelled').count()

        financials = projects.aggregate(
            allocated=Coalesce(Sum('project_Budgeting'), 0.0, output_field=FloatField()),
            spent=Coalesce(Sum('amount_spent'), 0.0, output_field=FloatField()),
            avg_risk=Coalesce(Avg('ai_risk_score'), 0.0, output_field=FloatField()),
        )

        total_allocated = float(financials['allocated'] or 0)
        total_spent = float(financials['spent'] or 0)
        budget_remaining = max(0.0, total_allocated - total_spent)
        budget_utilization = round((total_spent / total_allocated * 100), 1) if total_allocated > 0 else 0.0
        completion_rate = round((completed / total_projects * 100), 1) if total_projects > 0 else 0.0
        avg_project_budget = round(total_allocated / total_projects, 2) if total_projects > 0 else 0.0

        high_risk_count = projects.filter(
            Q(priority='critical') | Q(priority='high') | Q(ai_risk_score__gte=7.0)
        ).count()

        # Issues & Engagement
        issues = ReportIssue.objects.filter(project__in=projects)
        total_issues = issues.count()
        resolved_issues = issues.filter(Q(status='resolved') | Q(resolved=True)).count()
        open_issues = total_issues - resolved_issues

        if region_name:
            requests_count = GovernmentRequest.objects.filter(location__icontains=region_name).count()
        else:
            requests_count = GovernmentRequest.objects.count()

        comments_count = Comment.objects.filter(project__in=projects).count()

        # Sector / Category distribution
        category_qs = projects.values('category__name').annotate(count=Count('id')).order_by('-count')[:6]
        sector_labels = [c['category__name'] or 'General' for c in category_qs]
        sector_values = [c['count'] for c in category_qs]

        # Top projects
        top_projects = list(projects.select_related('category').order_by('-project_Budgeting')[:5])
        projects_list = list(projects.select_related('category').order_by('-created_at')[:8])

        return {
            "name": region_name or "National Average",
            "total": total_projects,
            "completed": completed,
            "ongoing": ongoing,
            "delayed": delayed,
            "upcoming": upcoming,
            "stalled": stalled,
            "suspended": suspended,
            "cancelled": cancelled,
            "completion_rate": completion_rate,
            "total_allocated": total_allocated,
            "total_spent": total_spent,
            "budget_remaining": budget_remaining,
            "budget_utilization": budget_utilization,
            "avg_project_budget": avg_project_budget,
            "avg_risk_score": round(float(financials['avg_risk'] or 0), 1),
            "high_risk_count": high_risk_count,
            "reported_issues": total_issues,
            "open_issues": open_issues,
            "resolved_issues": resolved_issues,
            "citizen_requests": requests_count,
            "comments_count": comments_count,
            "top_projects": top_projects,
            "sector_labels": sector_labels,
            "sector_values": sector_values,
            "projects_list": projects_list,
        }

    data1 = get_region_data(region1) if region1 else None
    data2 = get_region_data(region2) if region2 else None
    national_data = get_region_data(None)

    all_regions_summary = []
    total_regional_capital = 0.0
    for reg in regions:
        reg_projects = Project.objects.filter(project_location=reg)
        c_tot = reg_projects.count()
        if c_tot == 0:
            continue
        c_comp = reg_projects.filter(project_status='completed').count()
        c_del = reg_projects.filter(project_status='delayed').count()
        c_fin = reg_projects.aggregate(
            alloc=Coalesce(Sum('project_Budgeting'), 0.0, output_field=FloatField()),
            spent=Coalesce(Sum('amount_spent'), 0.0, output_field=FloatField())
        )
        alloc_val = float(c_fin['alloc'] or 0)
        spent_val = float(c_fin['spent'] or 0)
        total_regional_capital += alloc_val
        rate = round((c_comp / c_tot) * 100, 1)
        util = round((spent_val / alloc_val * 100), 1) if alloc_val > 0 else 0.0
        iss_count = ReportIssue.objects.filter(project__in=reg_projects).count()

        all_regions_summary.append({
            'region': reg,
            'total': c_tot,
            'completed': c_comp,
            'ongoing': reg_projects.filter(project_status='ongoing').count(),
            'delayed': c_del,
            'completion_rate': rate,
            'allocated': alloc_val,
            'spent': spent_val,
            'utilization': util,
            'issues_count': iss_count,
        })

    all_regions_summary.sort(key=lambda x: (x['completion_rate'], x['allocated']), reverse=True)

    context = {
        "regions": regions,
        "region1": region1,
        "region2": region2,
        "data1": data1,
        "data2": data2,
        "national_data": national_data,
        "all_regions_summary": all_regions_summary,
        "total_tracked_regions": len(regions),
        "total_regional_capital": total_regional_capital,
    }

    return render(request, "regional_analytics/regional_analysis.html", context)

def generate_announcements():

    projects = Project.objects.all()

    # 1. Delayed Projects
    delayed = projects.filter(project_status='delayed')
    if delayed.count() > 0:
        Announcement.objects.create(
            title="Delayed Projects Alert",
            message=f"{delayed.count()} projects are currently delayed. Immediate attention required.",
            level="warning"
        )

    # 2. Completed Projects
    completed = projects.filter(project_status='completed')
    if completed.count() > 0:
        Announcement.objects.create(
            title="Project Completion Update",
            message=f"{completed.count()} projects have been successfully completed.",
            level="info"
        )

    # 3. Budget Anomalies
    for p in projects:
        if p.amount_spent and p.project_Budgeting:
            if p.amount_spent > p.project_Budgeting * 1.5:
                Announcement.objects.create(
                    title=f"Budget Overrun: {p.project_title}",
                    message="Project exceeded budget by more than 50%.",
                    level="critical"
                )

    # 4. Stalled Projects (no update in 30 days)
    for p in projects:
        if p.updated_at:
            days = (timezone.now() - p.updated_at).days
            if days > 30:
                Announcement.objects.create(
                    title=f"Stalled Project: {p.project_title}",
                    message=f"No updates for {days} days.",
                    level="warning"
                )



def announcements(request):
    announcements = Announcement.objects.all().order_by('-created_at')
    return render(request, 'announcements/list.html', {
        'announcements': announcements
    })


@login_required(login_url='login')
def citizen_portal(request):
    submissions = CitizenSubmission.objects.filter(user=request.user).order_by('-created_at')
    proje = Project.objects.all()

    # Stats for the citizen dashboard
    total_submissions = submissions.count()
    pending_count = submissions.filter(status='pending').count()
    reviewed_count = submissions.filter(status='reviewed').count()
    approved_count = submissions.filter(status='approved').count()
    rejected_count = submissions.filter(status='rejected').count()
    resolved_count = submissions.filter(status='resolved').count()

    # Category breakdown
    suggestions = submissions.filter(category='suggestion').count()
    complaints = submissions.filter(category='complaint').count()
    reports = submissions.filter(category='report').count()
    commendations = submissions.filter(category='commendation').count()

    # Recent activity
    recent_submissions = submissions[:5]

    # Public projects for participation
    public_projects = Project.objects.filter(is_public=True).order_by('-created_at')[:6]

    # Active participations
    participations = Participation.objects.filter(user=request.user).order_by('-joined_at')[:5]
    total_participations = Participation.objects.filter(user=request.user).count()

    # Evidence submitted by user
    evidence = CitizenEvidence.objects.filter(user=request.user).order_by('-created_at')
    total_evidence = evidence.count()
    verified_evidence = evidence.filter(is_verified=True).count()

    # Announcements
    announcements = Announcement.objects.all().order_by('-created_at')[:5]

    return render(request, 'public_participation/citizen.html', {
        'submissions': submissions,
        'proje': proje,
        'total_submissions': total_submissions,
        'pending_count': pending_count,
        'reviewed_count': reviewed_count,
        'approved_count': approved_count,
        'rejected_count': rejected_count,
        'resolved_count': resolved_count,
        'suggestions': suggestions,
        'complaints': complaints,
        'reports': reports,
        'commendations': commendations,
        'recent_submissions': recent_submissions,
        'public_projects': public_projects,
        'participations': participations,
        'total_participations': total_participations,
        'evidence': evidence,
        'total_evidence': total_evidence,
        'verified_evidence': verified_evidence,
        'announcements': announcements,
    })

@login_required(login_url='login')
def submit_issue(request):
    if request.method == "POST":

        title = request.POST.get('title')
        message = request.POST.get('message')
        category = request.POST.get('category')
        project_id = request.POST.get('project')

        if not title or not message:
            messages.error(request, "Please provide both a title and message.")
            return redirect('citizen_portal')

        submission = CitizenSubmission.objects.create(
            user=request.user,
            title=title,
            message=message,
            category=category or 'suggestion',
            project_id=project_id if project_id else None
        )
        audit(request, 'citizen_submission', submission, changes={'title': title, 'category': category})
        messages.success(request, "Your submission has been received successfully! An official will review it soon.")

        return redirect('citizen_portal')



@login_required(login_url='login')
def contractor_dashboard(request):
    con = Project.objects.all()
    contractors = Contractor.objects.all().prefetch_related('projects', 'awarded_tenders').order_by('-created_at')
    reports = StageReport.objects.select_related('project', 'stage', 'contractor', 'reported_by').all().order_by('-created_at')
    stages = ProjectStage.objects.all()
    form = contractorForm(request.POST or None, request.FILES or None)

    if request.method == "POST" and form.is_valid():
        form.save()
        messages.success(request, "Contractor added successfully.")
        return redirect('contractor_performance')

    return render(request, 'contractors/dashboard.html', {
        'contractors': contractors,
        'reports': reports,
        'con': con,
        'stages': stages,
        'form': form
    })


@login_required(login_url='login')
def submit_stage_report(request):
    projects = Project.objects.all()
    stages = ProjectStage.objects.all()
    contractors = Contractor.objects.all()

    if request.method == "POST":
        try:
            progress_val = request.POST.get('progress') or request.POST.get('progress_percentage') or 0
            report = StageReport(
                project_id=request.POST.get('project'), stage_id=request.POST.get('stage'),
                contractor_id=request.POST.get('contractor') or None, reported_by=request.user,
                description=request.POST.get('description'), progress_percentage=progress_val,
                location=request.POST.get('location'), photo=request.FILES.get('photo'),
            )
            report.full_clean()
            report.save()
            if report.stage:
                report.stage.progress_percentage = report.progress_percentage
                report.stage.save(update_fields=['progress_percentage'])
            audit(request, 'stage_report_submitted', report, project=report.project)
            messages.success(request, "Stage report submitted successfully.")
        except (ValueError, ValidationErr) as error:
            messages.error(request, f'Unable to submit report: {error}')
            return redirect('contractor_performance')
        return redirect('contractor_performance')

    return render(request, 'contractors/report_form.html', {
        'projects': projects,
        'stages': stages,
        'contractors': contractors
    })


@login_required
def citizen_evidence(request):

    projects = Project.objects.all()
    stages = ProjectStage.objects.all()

    evidence = CitizenEvidence.objects.filter(user=request.user).order_by('-created_at')

    return render(request, 'citizen/evidence.html', {
        'projects': projects,
        'stages': stages,
        'evidence': evidence
    })


@login_required
def submit_evidence(request):

    if request.method == "POST":

        CitizenEvidence.objects.create(
            user=request.user,
            project_id=request.POST.get('project'),
            stage_id=request.POST.get('stage'),
            title=request.POST.get('title'),
            description=request.POST.get('description'),
            location=request.POST.get('location'),
            image=request.FILES.get('image')
        )

        return redirect('citizen_evidence')


@login_required(login_url='login')
def budget_dashboard(request):
    query = request.GET.get('q', '').strip()
    start_date = request.GET.get('start_date', '')
    end_date = request.GET.get('end_date', '')

    budgets = Budget.objects.select_related('project', 'project__project_division').all()
    expenses = ProjectExpense.objects.select_related('project', 'recorded_by').order_by('-date', '-id')

    if query:
        budgets = budgets.filter(
            Q(project__project_title__icontains=query) |
            Q(notes__icontains=query) |
            Q(fiscal_year__icontains=query)
        )
        expenses = expenses.filter(
            Q(title__icontains=query) |
            Q(description__icontains=query) |
            Q(project__project_title__icontains=query) |
            Q(category__icontains=query)
        )

    if start_date:
        expenses = expenses.filter(date__gte=start_date)
    if end_date:
        expenses = expenses.filter(date__lte=end_date)

    # Aggregates
    total_budget = Budget.objects.aggregate(Sum('allocated_amount'))['allocated_amount__sum'] or Decimal('0.00')
    if not total_budget:
        total_budget = Project.objects.aggregate(Sum('project_Budgeting'))['project_Budgeting__sum'] or Decimal('0.00')

    total_spent_budget = Budget.objects.aggregate(Sum('spent_amount'))['spent_amount__sum'] or Decimal('0.00')
    total_expense_sum = expenses.aggregate(Sum('amount'))['amount__sum'] or Decimal('0.00')
    total_spent = max(total_spent_budget, total_expense_sum)

    remaining = total_budget - total_spent
    utilization_rate = round(float((total_spent / total_budget) * 100), 2) if total_budget else 0.0

    # Attach properties for template rendering
    budget_list = []
    for b in budgets:
        rem = (b.allocated_amount or Decimal('0.00')) - (b.spent_amount or Decimal('0.00'))
        pct = b.utilization_rate
        budget_list.append({
            'obj': b,
            'id': b.id,
            'project': b.project,
            'allocated_amount': b.allocated_amount,
            'spent_amount': b.spent_amount,
            'remaining_budget': rem,
            'percentage_used': pct,
            'fiscal_year': b.fiscal_year,
            'notes': b.notes,
        })

    context = {
        'budgets': budget_list,
        'spendings': expenses[:25],
        'total_budget': total_budget,
        'total_spent': total_spent,
        'remaining': remaining,
        'utilization_rate': utilization_rate,
        'query': query,
        'start_date': start_date,
        'end_date': end_date,
    }
    return render(request, 'finance/budget_dashboard.html', context)


@login_required(login_url='login')
def add_budget(request):
    if request.method == "POST":
        form = BudgetForm(request.POST, request.FILES)
        if form.is_valid():
            budget = form.save()
            if budget.project:
                budget.project.project_Budgeting = budget.allocated_amount
                budget.project.amount_spent = budget.spent_amount
                budget.project.save()
            messages.success(request, f"Budget allocated successfully for {budget.project.project_title}!")
            return redirect('budget_dashboard')
    else:
        form = BudgetForm()

    return render(request, 'finance/add_budget.html', {'form': form})


@login_required(login_url='login')
def add_expense(request):
    if request.method == "POST":
        form = ProjectExpenseForm(request.POST, request.FILES)
        if form.is_valid():
            expense = form.save(commit=False)
            if request.user.is_authenticated:
                expense.recorded_by = request.user
            expense.save()

            if expense.project:
                proj = expense.project
                proj.amount_spent = (proj.amount_spent or Decimal('0.00')) + expense.amount
                proj.save()

                budget = Budget.objects.filter(project=proj).first()
                if budget:
                    budget.spent_amount = (budget.spent_amount or Decimal('0.00')) + expense.amount
                    budget.save()
                else:
                    Budget.objects.create(
                        project=proj,
                        allocated_amount=proj.project_Budgeting or Decimal('0.00'),
                        spent_amount=expense.amount
                    )

            messages.success(request, f"Expense recorded successfully for {expense.project.project_title if expense.project else 'Project'}!")
            return redirect('budget_dashboard')
    else:
        form = ProjectExpenseForm()

    return render(request, 'finance/add_expenses.html', {'form': form})

@login_required(login_url='login')
def track_application(request):
    query = request.GET.get('q', '').strip()

    if request.user.is_superuser or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES):
        applications = TenderApplication.objects.select_related('tender', 'tender__project', 'applicant', 'tender__awarded_to').all().order_by('-submitted_at')
    else:
        applications = TenderApplication.objects.filter(applicant=request.user).select_related('tender', 'tender__project', 'tender__awarded_to').order_by('-submitted_at')

    if query:
        applications = applications.filter(
            Q(tender__title__icontains=query) |
            Q(tender__reference_number__icontains=query) |
            Q(company_name__icontains=query) |
            Q(status__icontains=query)
        )

    context = {
        'applications': applications,
        'total_applications': applications.count(),
        'awarded_count': applications.filter(status='awarded').count(),
        'pending_count': applications.filter(status__in=['submitted', 'under_review', 'shortlisted']).count(),
        'rejected_count': applications.filter(status='rejected').count(),
        'query': query,
    }

    return render(request, 'Track_Application/tracking_application.html', context)

@login_required
def my_documents(request):
    applications = (TenderApplication.objects.filter(applicant=request.user) .select_related("tender", "tender__project").order_by("-submitted_at") )

    return render(request,"My_doc/my_documents.html",context = {
    "applications": applications,
    "review_count": applications.filter(status="under_review").count(),
    "awarded_count": applications.filter(status="awarded").count(),
    "rejected_count": applications.filter(status="rejected").count(),
})

@login_required
def my_bids(request):
    query = request.GET.get('q', '').strip()
    if request.user.is_superuser or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES):
        applications = TenderApplication.objects.select_related('tender', 'tender__project', 'applicant', 'tender__awarded_to').all().order_by('-submitted_at')
    else:
        applications = TenderApplication.objects.filter(applicant=request.user).select_related('tender', 'tender__project', 'tender__awarded_to').order_by('-submitted_at')

    if query:
        applications = applications.filter(
            Q(tender__title__icontains=query) |
            Q(tender__reference_number__icontains=query) |
            Q(company_name__icontains=query)
        )

    return render(request, 'My_bids/bids.html', {
        'applications': applications,
        'query': query,
    })


@login_required(login_url='login')
def create_request(request):
    if request.method == 'POST':
        form = GovernmentRequestForm(request.POST, request.FILES)
        if form.is_valid():
            req = form.save(commit=False)
            req.citizen = request.user
            req.save()
            audit(request, 'created', req, changes={'title': req.title, 'reference_no': req.reference_no})
            messages.success(request, f"Government request '{req.reference_no}' submitted successfully!")
            return redirect('my_requests')
        else:
            messages.error(request, "Failed to submit request. Please check highlighted errors.")
    else:
        form = GovernmentRequestForm()

    return render(request, 'GovRequests/create_request.html', {'form': form})


@login_required(login_url='login')
def my_requests(request):
    query = request.GET.get('q', '').strip()
    status_filter = request.GET.get('status', '').strip()

    requests_qs = GovernmentRequest.objects.filter(citizen=request.user).order_by('-created_at')

    if query:
        requests_qs = requests_qs.filter(
            Q(title__icontains=query) |
            Q(reference_no__icontains=query) |
            Q(description__icontains=query) |
            Q(location__icontains=query)
        )

    if status_filter:
        requests_qs = requests_qs.filter(status=status_filter)

    total_count = requests_qs.count()
    pending_count = requests_qs.filter(status='pending').count()
    resolved_count = requests_qs.filter(status='resolved').count()

    context = {
        'requests': requests_qs,
        'query': query,
        'status_filter': status_filter,
        'total_count': total_count,
        'pending_count': pending_count,
        'resolved_count': resolved_count,
        'status_choices': GovernmentRequest.STATUS_CHOICES,
    }
    return render(request, 'GovRequests/my_requests.html', context)


@login_required(login_url='login')
def all_requests(request):
    query = request.GET.get('q', '').strip()
    status_filter = request.GET.get('status', '').strip()
    category_filter = request.GET.get('category', '').strip()

    requests_qs = GovernmentRequest.objects.select_related('citizen', 'assigned_to', 'responded_by').all().order_by('-created_at')

    if not (request.user.is_superuser or (hasattr(request.user, 'role') and request.user.role in OFFICER_ROLES)):
        requests_qs = requests_qs.filter(Q(citizen=request.user) | Q(assigned_to=request.user))

    if query:
        requests_qs = requests_qs.filter(
            Q(title__icontains=query) |
            Q(reference_no__icontains=query) |
            Q(description__icontains=query) |
            Q(location__icontains=query) |
            Q(citizen__username__icontains=query)
        )

    if status_filter:
        requests_qs = requests_qs.filter(status=status_filter)

    if category_filter:
        requests_qs = requests_qs.filter(category=category_filter)

    total_count = requests_qs.count()
    pending_count = requests_qs.filter(status='pending').count()
    in_progress_count = requests_qs.filter(status='in_progress').count()
    resolved_count = requests_qs.filter(status='resolved').count()

    form = GovernmentRequestForm()

    context = {
        'requests': requests_qs,
        'form': form,
        'query': query,
        'status_filter': status_filter,
        'category_filter': category_filter,
        'total_count': total_count,
        'pending_count': pending_count,
        'in_progress_count': in_progress_count,
        'resolved_count': resolved_count,
        'status_choices': GovernmentRequest.STATUS_CHOICES,
        'category_choices': GovernmentRequest.CATEGORY_CHOICES,
    }
    return render(request, 'GovRequests/all_requests.html', context)


@login_required(login_url='login')
def request_detail(request, pk):
    req = get_object_or_404(GovernmentRequest.objects.select_related('citizen', 'assigned_to', 'responded_by'), pk=pk)
    return render(request, 'GovRequests/request_detail.html', {'request': req})


@login_required(login_url='login')
def respond_request(request, pk):
    req = get_object_or_404(GovernmentRequest, pk=pk)

    if request.method == 'POST':
        response_text = request.POST.get('response') or request.POST.get('official_response')
        new_status = request.POST.get('status') or 'responded'

        req.official_response = response_text
        req.responded_by = request.user
        req.responded_at = django_timezone.now()
        req.status = new_status
        req.save()

        audit(request, 'responded_request', req, changes={'status': req.status})
        notify(req.citizen, 'system', 'Request Response', f'An official response was posted for {req.reference_no or req.title}.', f'/government-requests/{req.id}/')
        messages.success(request, f"Response saved for Request #{req.reference_no or req.id}.")
        return redirect('request_detail', pk=req.id)

    return render(request, 'GovRequests/respond_request.html', {'request': req})


@login_required(login_url='login')
def close_request(request, pk):
    req = get_object_or_404(GovernmentRequest, pk=pk)
    req.status = 'closed'
    req.save()
    audit(request, 'closed_request', req, changes={'status': 'closed'})
    messages.info(request, f"Request '{req.reference_no or req.title}' marked as closed.")
    return redirect('all_requests')

def progress_report(request):
    projects = Project.objects.all()

    total_projects = projects.count()
    completed = projects.filter(project_status='completed').count()
    ongoing = projects.filter(project_status='ongoing').count()
    delayed = projects.filter(project_status='delayed').count()
    upcoming = projects.filter(project_status='upcoming').count()

    # Progress % (basic logic)
    progress_percentage = 0
    if total_projects > 0:
        progress_percentage = int((completed / total_projects) * 100)

    context = {
        'total_projects': total_projects,
        'completed': completed,
        'ongoing': ongoing,
        'delayed': delayed,
        'upcoming': upcoming,
        'progress_percentage': progress_percentage,
        'projects': projects
    }

    return render(request, 'Reports/progress_report.html', context)

@login_required
def account_settings(request):
    user = request.user

    if request.method == 'POST':
        user.name = request.POST.get('name')
        user.email = request.POST.get('email')

        # Profile Image
        if request.FILES.get('profile'):
            user.profile = request.FILES.get('profile')

        user.save()
        messages.success(request, "Settings updated successfully")

        return redirect('account_settings')

    return render(request, 'account_settings.html', {'user': user})


def system_reports(request):
    # ── Projects ──
    projects = Project.objects.all()
    total_projects = projects.count()
    completed_projects = projects.filter(project_status='completed').count()
    ongoing_projects = projects.filter(project_status='ongoing').count()
    upcoming_projects = projects.filter(project_status='upcoming').count()
    delayed_projects = projects.filter(project_status='delayed').count()
    stalled_projects = projects.filter(project_status='stalled').count()
    draft_projects = projects.filter(project_status='draft').count()
    cancelled_projects = projects.filter(project_status='cancelled').count()
    suspended_projects = projects.filter(project_status='suspended').count()

    # ── Budget & Finance ──
    total_budget_allocated = projects.aggregate(total=Sum('project_Budgeting'))['total'] or 0
    total_budget_spent = projects.aggregate(total=Sum('amount_spent'))['total'] or 0
    total_budget_remaining = total_budget_allocated - total_budget_spent
    budget_utilization = round(float(total_budget_spent / total_budget_allocated * 100), 1) if total_budget_allocated else 0

    budgets = Budget.objects.all()
    total_budget_records = budgets.count()
    total_allocated_budget = budgets.aggregate(total=Sum('allocated_amount'))['total'] or 0
    total_spent_budget = budgets.aggregate(total=Sum('spent_amount'))['total'] or 0

    expenses = ProjectExpense.objects.all()
    total_expenses = expenses.count()
    total_expense_amount = expenses.aggregate(total=Sum('amount'))['total'] or 0

    # ── Users ──
    users = User.objects.all()
    total_users = users.count()
    verified_users = users.filter(is_verified=True).count()
    unverified_users = users.filter(is_verified=False).count()
    superusers = users.filter(is_superuser=True).count()
    citizens = users.filter(role='citizen').count()
    officials = users.filter(role__in=['official', 'staff', 'admin', 'auditor', 'manager']).count()
    contractors = users.filter(role='contractor').count()

    # ── Tenders ──
    tenders = Tender.objects.all()
    total_tenders = tenders.count()
    published_tenders = tenders.filter(status='published').count()
    closed_tenders = tenders.filter(status='closed').count()
    evaluating_tenders = tenders.filter(status='evaluating').count()
    awarded_tenders = tenders.filter(status='awarded').count()
    cancelled_tenders = tenders.filter(status='cancelled').count()
    draft_tenders = tenders.filter(status='draft').count()

    tender_applications = TenderApplication.objects.all()
    total_applications = tender_applications.count()
    submitted_apps = tender_applications.filter(status='submitted').count()
    under_review_apps = tender_applications.filter(status='under_review').count()
    shortlisted_apps = tender_applications.filter(status='shortlisted').count()
    rejected_apps = tender_applications.filter(status='rejected').count()
    awarded_apps = tender_applications.filter(status='awarded').count()

    # ── Government Requests ──
    requests = GovernmentRequest.objects.all()
    total_requests = requests.count()
    pending_requests = requests.filter(status='pending').count()
    in_progress_requests = requests.filter(status='in_progress').count()
    responded_requests = requests.filter(status='responded').count()
    resolved_requests = requests.filter(status='resolved').count()
    rejected_requests = requests.filter(status='rejected').count()
    closed_requests = requests.filter(status='closed').count()

    # ── Issues ──
    issues = ReportIssue.objects.all()
    total_issues = issues.count()
    pending_issues = issues.filter(status='pending').count()
    investigating_issues = issues.filter(status='investigating').count()
    resolved_issues = issues.filter(status='resolved').count()
    dismissed_issues = issues.filter(status='dismissed').count()
    critical_issues = issues.filter(severity='critical').count()
    high_issues = issues.filter(severity='high').count()

    # ── Milestones & Stages ──
    milestones = Milestone.objects.all()
    total_milestones = milestones.count()
    completed_milestones = milestones.filter(status='completed').count()
    pending_milestones = milestones.filter(status='pending').count()
    in_progress_milestones = milestones.filter(status='in_progress').count()
    missed_milestones = milestones.filter(status='missed').count()

    stages = ProjectStage.objects.all()
    total_stages = stages.count()

    # ── Feedback & Testimonials ──
    feedbacks = Feedback.objects.all()
    total_feedback = feedbacks.count()

    testimonials = Testimonial.objects.all()
    total_testimonials = testimonials.count()
    approved_testimonials = testimonials.filter(is_approved=True).count()
    pending_testimonials = testimonials.filter(is_approved=False).count()

    # ── Comments & Participation ──
    comments = Comment.objects.all()
    total_comments = comments.count()

    participations = Participation.objects.all()
    total_participations = participations.count()

    # ── Media & Documents ──
    media_files = Media.objects.all()
    total_media = media_files.count()

    # ── Audit Logs ──
    audit_logs = AuditLog.objects.all()
    total_audit_logs = audit_logs.count()

    # ── Notifications ──
    notifications = Notification.objects.all()
    total_notifications = notifications.count()

    # ── Announcements ──
    announcements = Announcement.objects.all()
    total_announcements = announcements.count()

    # ── Citizen Submissions & Evidence ──
    citizen_submissions = CitizenSubmission.objects.all()
    total_citizen_submissions = citizen_submissions.count()
    pending_submissions = citizen_submissions.filter(status='pending').count()
    reviewed_submissions = citizen_submissions.filter(status='reviewed').count()
    approved_submissions = citizen_submissions.filter(status='approved').count()
    rejected_submissions = citizen_submissions.filter(status='rejected').count()
    resolved_submissions = citizen_submissions.filter(status='resolved').count()
    suggestion_submissions = citizen_submissions.filter(category='suggestion').count()
    complaint_submissions = citizen_submissions.filter(category='complaint').count()
    report_submissions = citizen_submissions.filter(category='report').count()
    commendation_submissions = citizen_submissions.filter(category='commendation').count()

    citizen_evidence = CitizenEvidence.objects.all()
    total_citizen_evidence = citizen_evidence.count()
    verified_evidence = citizen_evidence.filter(is_verified=True).count()
    unverified_evidence = citizen_evidence.filter(is_verified=False).count()

    # ── Participation Activity ──
    active_participations = participations.filter(is_active=True).count()
    inactive_participations = participations.filter(is_active=False).count()
    recent_participations = participations.order_by('-joined_at')[:5]

    # ── Comments Activity ──
    flagged_comments = comments.filter(is_flagged=True).count()
    recent_comments = comments.order_by('-created_at')[:5]

    # ── Feedback & Testimonials ──
    recent_feedback = feedbacks.order_by('-created_at')[:5]
    recent_testimonials = testimonials.order_by('-created_at')[:5]

    # ── Contractors ──
    contractors_list = Contractor.objects.all()
    total_contractors = contractors_list.count()

    # ── Teams ──
    teams = Team.objects.all()
    total_teams = teams.count()

    # ── Project Risks ──
    risks = ProjectRisk.objects.all()
    total_risks = risks.count()
    high_risks = risks.filter(risk_level__in=['high', 'critical']).count()

    # ── Recent activity ──
    recent_projects = projects.order_by('-created_at')[:5]
    recent_requests = requests.order_by('-created_at')[:5]
    recent_issues = issues.order_by('-created_at')[:5]

    # ── Analytics & Charts Data ──
    # Project status distribution (for pie/donut chart)
    status_labels = [choice[1] for choice in Project.STATUS_CHOICES]
    status_counts = []
    for status, label in Project.STATUS_CHOICES:
        status_counts.append(projects.filter(project_status=status).count())

    # Category distribution of citizen submissions
    submission_category_labels = [choice[1] for choice in CitizenSubmission.CATEGORY_CHOICES]
    submission_category_counts = []
    for cat, label in CitizenSubmission.CATEGORY_CHOICES:
        submission_category_counts.append(citizen_submissions.filter(category=cat).count())

    # Monthly project starts (last 6 months)
    monthly_labels = []
    monthly_project_counts = []
    monthly_budget = []
    monthly_spent = []
    today = date.today()
    for i in range(5, -1, -1):
        # Calculate month start
        month_start = today.replace(day=1)
        if i > 0:
            month_start = datetime(today.year, today.month, 1) - timedelta(days=30 * i)
        month_start = month_start.replace(day=1)
        month_end = (month_start + timedelta(days=32)).replace(day=1) - timedelta(days=1)
        monthly_labels.append(month_start.strftime('%b %Y'))

        month_projects = Project.objects.filter(created_at__date__gte=month_start, created_at__date__lte=month_end)
        monthly_project_counts.append(month_projects.count())
        monthly_budget.append(float(month_projects.aggregate(total=Sum('project_Budgeting'))['total'] or 0))
        monthly_spent.append(float(month_projects.aggregate(total=Sum('amount_spent'))['total'] or 0))

    # Completion rate
    completion_rate = round((completed_projects / total_projects * 100), 1) if total_projects else 0

    # Request resolution rate
    resolution_rate = round((resolved_requests / total_requests * 100), 1) if total_requests else 0

    # Issue resolution rate
    issue_resolution_rate = round((resolved_issues / total_issues * 100), 1) if total_issues else 0

    # Testimonial approval rate
    testimonial_approval_rate = round((approved_testimonials / total_testimonials * 100), 1) if total_testimonials else 0

    # Submission approval rate
    submission_approval_rate = round((approved_submissions / total_citizen_submissions * 100), 1) if total_citizen_submissions else 0

    # Participation engagement rate
    participation_rate = round((active_participations / total_participations * 100), 1) if total_participations else 0

    # Evidence verification rate
    evidence_verification_rate = round((verified_evidence / total_citizen_evidence * 100), 1) if total_citizen_evidence else 0

    # Budget analysis for chart
    budget_labels = [p.project_title[:15] + '...' if len(p.project_title) > 15 else p.project_title for p in projects.order_by('-project_Budgeting')[:5]]
    budget_values = [float(p.project_Budgeting or 0) for p in projects.order_by('-project_Budgeting')[:5]]
    spent_values = [float(p.amount_spent or 0) for p in projects.order_by('-project_Budgeting')[:5]]

    context = {
        'today': django_timezone.now(),
        # Projects
        'total_projects': total_projects,
        'completed_projects': completed_projects,
        'ongoing_projects': ongoing_projects,
        'upcoming_projects': upcoming_projects,
        'delayed_projects': delayed_projects,
        'stalled_projects': stalled_projects,
        'draft_projects': draft_projects,
        'cancelled_projects': cancelled_projects,
        'suspended_projects': suspended_projects,

        # Budget & Finance
        'total_budget_allocated': total_budget_allocated,
        'total_budget_spent': total_budget_spent,
        'total_budget_remaining': total_budget_remaining,
        'budget_utilization': budget_utilization,
        'total_budget_records': total_budget_records,
        'total_allocated_budget': total_allocated_budget,
        'total_spent_budget': total_spent_budget,
        'total_expenses': total_expenses,
        'total_expense_amount': total_expense_amount,

        # Users
        'total_users': total_users,
        'verified_users': verified_users,
        'unverified_users': unverified_users,
        'superusers': superusers,
        'citizens': citizens,
        'officials': officials,
        'contractors': contractors,

        # Tenders
        'total_tenders': total_tenders,
        'published_tenders': published_tenders,
        'closed_tenders': closed_tenders,
        'evaluating_tenders': evaluating_tenders,
        'awarded_tenders': awarded_tenders,
        'cancelled_tenders': cancelled_tenders,
        'draft_tenders': draft_tenders,
        'total_applications': total_applications,
        'submitted_apps': submitted_apps,
        'under_review_apps': under_review_apps,
        'shortlisted_apps': shortlisted_apps,
        'rejected_apps': rejected_apps,
        'awarded_apps': awarded_apps,

        # Government Requests
        'total_requests': total_requests,
        'pending_requests': pending_requests,
        'in_progress_requests': in_progress_requests,
        'responded_requests': responded_requests,
        'resolved_requests': resolved_requests,
        'rejected_requests': rejected_requests,
        'closed_requests': closed_requests,

        # Issues
        'total_issues': total_issues,
        'pending_issues': pending_issues,
        'investigating_issues': investigating_issues,
        'resolved_issues': resolved_issues,
        'dismissed_issues': dismissed_issues,
        'critical_issues': critical_issues,
        'high_issues': high_issues,

        # Milestones & Stages
        'total_milestones': total_milestones,
        'completed_milestones': completed_milestones,
        'pending_milestones': pending_milestones,
        'in_progress_milestones': in_progress_milestones,
        'missed_milestones': missed_milestones,
        'total_stages': total_stages,

        # Feedback & Testimonials
        'total_feedback': total_feedback,
        'total_testimonials': total_testimonials,
        'approved_testimonials': approved_testimonials,
        'pending_testimonials': pending_testimonials,

        # Comments & Participation
        'total_comments': total_comments,
        'total_participations': total_participations,

        # Media & Documents
        'total_media': total_media,

        # Audit & Notifications
        'total_audit_logs': total_audit_logs,
        'total_notifications': total_notifications,
        'total_announcements': total_announcements,

        # Citizen Engagement
        'total_citizen_submissions': total_citizen_submissions,
        'pending_submissions': pending_submissions,
        'reviewed_submissions': reviewed_submissions,
        'approved_submissions': approved_submissions,
        'rejected_submissions': rejected_submissions,
        'resolved_submissions': resolved_submissions,
        'suggestion_submissions': suggestion_submissions,
        'complaint_submissions': complaint_submissions,
        'report_submissions': report_submissions,
        'commendation_submissions': commendation_submissions,
        'total_citizen_evidence': total_citizen_evidence,
        'verified_evidence': verified_evidence,
        'unverified_evidence': unverified_evidence,
        'active_participations': active_participations,
        'inactive_participations': inactive_participations,
        'recent_participations': recent_participations,
        'flagged_comments': flagged_comments,
        'recent_comments': recent_comments,
        'recent_feedback': recent_feedback,
        'recent_testimonials': recent_testimonials,

        # Contractors & Teams
        'total_contractors': total_contractors,
        'total_teams': total_teams,

        # Risks
        'total_risks': total_risks,
        'high_risks': high_risks,

        # Recent activity
        'recent_projects': recent_projects,
        'recent_requests': recent_requests,
        'recent_issues': recent_issues,

        # Analytics & Charts
        'status_labels': status_labels,
        'status_counts': status_counts,
        'submission_category_labels': submission_category_labels,
        'submission_category_counts': submission_category_counts,
        'monthly_labels': monthly_labels,
        'monthly_project_counts': monthly_project_counts,
        'monthly_budget': monthly_budget,
        'monthly_spent': monthly_spent,
        'completion_rate': completion_rate,
        'resolution_rate': resolution_rate,
        'issue_resolution_rate': issue_resolution_rate,
        'testimonial_approval_rate': testimonial_approval_rate,
        'submission_approval_rate': submission_approval_rate,
        'participation_rate': participation_rate,
        'evidence_verification_rate': evidence_verification_rate,
        'budget_labels': budget_labels,
        'budget_values': budget_values,
        'spent_values': spent_values,
    }

    return render(request, 'Reports/system_reports.html', context)


def export_pdf(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="system_report.pdf"'

    doc = SimpleDocTemplate(response)
    styles = getSampleStyleSheet()

    # ── Projects ──
    total_projects = Project.objects.count()
    completed_projects = Project.objects.filter(project_status='completed').count()
    ongoing_projects = Project.objects.filter(project_status='ongoing').count()
    upcoming_projects = Project.objects.filter(project_status='upcoming').count()
    delayed_projects = Project.objects.filter(project_status='delayed').count()
    stalled_projects = Project.objects.filter(project_status='stalled').count()
    draft_projects = Project.objects.filter(project_status='draft').count()
    cancelled_projects = Project.objects.filter(project_status='cancelled').count()
    suspended_projects = Project.objects.filter(project_status='suspended').count()

    # ── Budget & Finance ──
    total_budget_allocated = Project.objects.aggregate(total=Sum('project_Budgeting'))['total'] or 0
    total_budget_spent = Project.objects.aggregate(total=Sum('amount_spent'))['total'] or 0
    total_budget_remaining = total_budget_allocated - total_budget_spent
    budget_utilization = round(float(total_budget_spent / total_budget_allocated * 100), 1) if total_budget_allocated else 0
    total_expenses = ProjectExpense.objects.count()
    total_expense_amount = ProjectExpense.objects.aggregate(total=Sum('amount'))['total'] or 0

    # ── Users ──
    total_users = User.objects.count()
    verified_users = User.objects.filter(is_verified=True).count()
    citizens = User.objects.filter(role='citizen').count()
    officials = User.objects.filter(role__in=['official', 'staff', 'admin', 'auditor', 'manager']).count()
    contractors = User.objects.filter(role='contractor').count()

    # ── Tenders ──
    total_tenders = Tender.objects.count()
    published_tenders = Tender.objects.filter(status='published').count()
    awarded_tenders = Tender.objects.filter(status='awarded').count()
    total_applications = TenderApplication.objects.count()
    awarded_apps = TenderApplication.objects.filter(status='awarded').count()

    # ── Government Requests ──
    total_requests = GovernmentRequest.objects.count()
    pending_requests = GovernmentRequest.objects.filter(status='pending').count()
    resolved_requests = GovernmentRequest.objects.filter(status='resolved').count()
    in_progress_requests = GovernmentRequest.objects.filter(status='in_progress').count()

    # ── Issues ──
    total_issues = ReportIssue.objects.count()
    resolved_issues = ReportIssue.objects.filter(status='resolved').count()
    critical_issues = ReportIssue.objects.filter(severity='critical').count()

    # ── Milestones ──
    total_milestones = Milestone.objects.count()
    completed_milestones = Milestone.objects.filter(status='completed').count()
    missed_milestones = Milestone.objects.filter(status='missed').count()

    # ── Engagement ──
    total_feedback = Feedback.objects.count()
    total_testimonials = Testimonial.objects.count()
    approved_testimonials = Testimonial.objects.filter(is_approved=True).count()
    total_comments = Comment.objects.count()
    total_participations = Participation.objects.count()
    total_citizen_submissions = CitizenSubmission.objects.count()
    total_citizen_evidence = CitizenEvidence.objects.count()

    # ── System ──
    total_media = Media.objects.count()
    total_audit_logs = AuditLog.objects.count()
    total_notifications = Notification.objects.count()
    total_announcements = Announcement.objects.count()
    total_contractors = Contractor.objects.count()
    total_teams = Team.objects.count()
    total_risks = ProjectRisk.objects.count()
    high_risks = ProjectRisk.objects.filter(risk_level__in=['high', 'critical']).count()

    # 📄 Content
    content = []

    content.append(Paragraph("GovTracker Comprehensive System Report", styles['Title']))
    content.append(Paragraph(f"Generated: {django_timezone.now().strftime('%B %d, %Y %H:%M')}", styles['Normal']))
    content.append(Spacer(1, 20))

    # Projects
    content.append(Paragraph("1. PROJECTS", styles['Heading2']))
    content.append(Paragraph(f"Total Projects: {total_projects}", styles['Normal']))
    content.append(Paragraph(f"Ongoing: {ongoing_projects} | Completed: {completed_projects} | Upcoming: {upcoming_projects}", styles['Normal']))
    content.append(Paragraph(f"Delayed: {delayed_projects} | Stalled: {stalled_projects} | Draft: {draft_projects}", styles['Normal']))
    content.append(Paragraph(f"Cancelled: {cancelled_projects} | Suspended: {suspended_projects}", styles['Normal']))
    content.append(Spacer(1, 10))

    # Budget
    content.append(Paragraph("2. BUDGET & FINANCE", styles['Heading2']))
    content.append(Paragraph(f"Total Allocated: KSh {total_budget_allocated:,.0f}", styles['Normal']))
    content.append(Paragraph(f"Total Spent: KSh {total_budget_spent:,.0f}", styles['Normal']))
    content.append(Paragraph(f"Remaining: KSh {total_budget_remaining:,.0f}", styles['Normal']))
    content.append(Paragraph(f"Budget Utilization: {budget_utilization}%", styles['Normal']))
    content.append(Paragraph(f"Total Expenses: {total_expenses} (KSh {total_expense_amount:,.0f})", styles['Normal']))
    content.append(Spacer(1, 10))

    # Users
    content.append(Paragraph("3. USERS & ROLES", styles['Heading2']))
    content.append(Paragraph(f"Total Users: {total_users} | Verified: {verified_users}", styles['Normal']))
    content.append(Paragraph(f"Citizens: {citizens} | Officials: {officials} | Contractors: {contractors}", styles['Normal']))
    content.append(Spacer(1, 10))

    # Tenders
    content.append(Paragraph("4. TENDERS & PROCUREMENT", styles['Heading2']))
    content.append(Paragraph(f"Total Tenders: {total_tenders} | Published: {published_tenders} | Awarded: {awarded_tenders}", styles['Normal']))
    content.append(Paragraph(f"Total Applications: {total_applications} | Awarded Apps: {awarded_apps}", styles['Normal']))
    content.append(Spacer(1, 10))

    # Requests
    content.append(Paragraph("5. GOVERNMENT REQUESTS", styles['Heading2']))
    content.append(Paragraph(f"Total Requests: {total_requests}", styles['Normal']))
    content.append(Paragraph(f"Pending: {pending_requests} | In Progress: {in_progress_requests} | Resolved: {resolved_requests}", styles['Normal']))
    content.append(Spacer(1, 10))

    # Issues
    content.append(Paragraph("6. REPORTED ISSUES", styles['Heading2']))
    content.append(Paragraph(f"Total Issues: {total_issues} | Resolved: {resolved_issues} | Critical: {critical_issues}", styles['Normal']))
    content.append(Spacer(1, 10))

    # Milestones
    content.append(Paragraph("7. MILESTONES", styles['Heading2']))
    content.append(Paragraph(f"Total Milestones: {total_milestones} | Completed: {completed_milestones} | Missed: {missed_milestones}", styles['Normal']))
    content.append(Spacer(1, 10))

    # Engagement
    content.append(Paragraph("8. CITIZEN ENGAGEMENT", styles['Heading2']))
    content.append(Paragraph(f"Feedback: {total_feedback} | Testimonials: {total_testimonials} (Approved: {approved_testimonials})", styles['Normal']))
    content.append(Paragraph(f"Comments: {total_comments} | Participations: {total_participations}", styles['Normal']))
    content.append(Paragraph(f"Citizen Submissions: {total_citizen_submissions} | Evidence: {total_citizen_evidence}", styles['Normal']))
    content.append(Spacer(1, 10))

    # System
    content.append(Paragraph("9. SYSTEM & ADMINISTRATION", styles['Heading2']))
    content.append(Paragraph(f"Media Files: {total_media} | Audit Logs: {total_audit_logs}", styles['Normal']))
    content.append(Paragraph(f"Notifications: {total_notifications} | Announcements: {total_announcements}", styles['Normal']))
    content.append(Paragraph(f"Contractors: {total_contractors} | Team Members: {total_teams}", styles['Normal']))
    content.append(Paragraph(f"Project Risks: {total_risks} (High/Critical: {high_risks})", styles['Normal']))

    doc.build(content)

    return response


def export_excel(request):
    if Workbook is None:
        return HttpResponse('Excel export is unavailable. Install openpyxl.', status=503)
    wb = Workbook()
    ws = wb.active
    ws.title = "System Report"

    # ── Projects ──
    ws.append(["PROJECTS"])
    ws.append(["Total Projects", Project.objects.count()])
    ws.append(["Ongoing", Project.objects.filter(project_status='ongoing').count()])
    ws.append(["Completed", Project.objects.filter(project_status='completed').count()])
    ws.append(["Upcoming", Project.objects.filter(project_status='upcoming').count()])
    ws.append(["Delayed", Project.objects.filter(project_status='delayed').count()])
    ws.append(["Stalled", Project.objects.filter(project_status='stalled').count()])
    ws.append(["Draft", Project.objects.filter(project_status='draft').count()])
    ws.append(["Cancelled", Project.objects.filter(project_status='cancelled').count()])
    ws.append(["Suspended", Project.objects.filter(project_status='suspended').count()])
    ws.append([])

    # ── Budget ──
    ws.append(["BUDGET & FINANCE"])
    ws.append(["Total Allocated", Project.objects.aggregate(total=Sum('project_Budgeting'))['total'] or 0])
    ws.append(["Total Spent", Project.objects.aggregate(total=Sum('amount_spent'))['total'] or 0])
    ws.append(["Total Expenses", ProjectExpense.objects.count()])
    ws.append(["Expense Amount", ProjectExpense.objects.aggregate(total=Sum('amount'))['total'] or 0])
    ws.append([])

    # ── Users ──
    ws.append(["USERS"])
    ws.append(["Total Users", User.objects.count()])
    ws.append(["Verified", User.objects.filter(is_verified=True).count()])
    ws.append(["Citizens", User.objects.filter(role='citizen').count()])
    ws.append(["Officials", User.objects.filter(role__in=['official', 'staff', 'admin', 'auditor', 'manager']).count()])
    ws.append(["Contractors", User.objects.filter(role='contractor').count()])
    ws.append([])

    # ── Tenders ──
    ws.append(["TENDERS"])
    ws.append(["Total Tenders", Tender.objects.count()])
    ws.append(["Published", Tender.objects.filter(status='published').count()])
    ws.append(["Awarded", Tender.objects.filter(status='awarded').count()])
    ws.append(["Total Applications", TenderApplication.objects.count()])
    ws.append(["Awarded Applications", TenderApplication.objects.filter(status='awarded').count()])
    ws.append([])

    # ── Requests ──
    ws.append(["GOVERNMENT REQUESTS"])
    ws.append(["Total Requests", GovernmentRequest.objects.count()])
    ws.append(["Pending", GovernmentRequest.objects.filter(status='pending').count()])
    ws.append(["In Progress", GovernmentRequest.objects.filter(status='in_progress').count()])
    ws.append(["Resolved", GovernmentRequest.objects.filter(status='resolved').count()])
    ws.append([])

    # ── Issues ──
    ws.append(["REPORTED ISSUES"])
    ws.append(["Total Issues", ReportIssue.objects.count()])
    ws.append(["Resolved", ReportIssue.objects.filter(status='resolved').count()])
    ws.append(["Critical", ReportIssue.objects.filter(severity='critical').count()])
    ws.append([])

    # ── Milestones ──
    ws.append(["MILESTONES"])
    ws.append(["Total Milestones", Milestone.objects.count()])
    ws.append(["Completed", Milestone.objects.filter(status='completed').count()])
    ws.append(["Missed", Milestone.objects.filter(status='missed').count()])
    ws.append([])

    # ── Engagement ──
    ws.append(["CITIZEN ENGAGEMENT"])
    ws.append(["Feedback", Feedback.objects.count()])
    ws.append(["Testimonials", Testimonial.objects.count()])
    ws.append(["Approved Testimonials", Testimonial.objects.filter(is_approved=True).count()])
    ws.append(["Comments", Comment.objects.count()])
    ws.append(["Participations", Participation.objects.count()])
    ws.append(["Citizen Submissions", CitizenSubmission.objects.count()])
    ws.append(["Citizen Evidence", CitizenEvidence.objects.count()])
    ws.append([])

    # ── System ──
    ws.append(["SYSTEM & ADMINISTRATION"])
    ws.append(["Media Files", Media.objects.count()])
    ws.append(["Audit Logs", AuditLog.objects.count()])
    ws.append(["Notifications", Notification.objects.count()])
    ws.append(["Announcements", Announcement.objects.count()])
    ws.append(["Contractors", Contractor.objects.count()])
    ws.append(["Team Members", Team.objects.count()])
    ws.append(["Project Risks", ProjectRisk.objects.count()])
    ws.append(["High/Critical Risks", ProjectRisk.objects.filter(risk_level__in=['high', 'critical']).count()])

    response = HttpResponse(
        content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
    response['Content-Disposition'] = 'attachment; filename=system_report.xlsx'

    wb.save(response)
    return response
