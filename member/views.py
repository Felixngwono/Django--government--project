from django.db.models import Count
from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseBadRequest
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from .models import Announcement, CitizenEvidence, CitizenSubmission, Comment,PDF, AuditLog, Contractor, GovernmentRequest, Participation, ProgramImpact, ProgressUpdate, Project_Division, Project_type, ProjectExpense, ProjectRisk, ProjectStage, ReportIssue,  StageReport, Stakeholder, Team, Tender, TenderApplication, Testimonial, User, Project,  Budget, Feedback, Notification, Milestone, Media
from django.contrib import messages
from .forms import AuditLogForm, BudgetForm, CommentForm, GovernmentRequestForm,  MediaForm, MilestoneForm, MyUserCreationForm, ContactUsForm,FeedbackForm, NotificationForm, ProgressReportForm, ProjectCreationForm,ProjectDivisionForm, ProjectStageForm, ProjectTypeForm, ReportIssueForm, TeamsForm, TenderApplicationForm, TenderForm, TestimonialForm, contractorForm, participationForm
from django.template.loader import get_template
from django.db.models import Sum
import pdfkit
from django.db.models import Q
from django.core.paginator import Paginator
import django.db.models.functions
from datetime import datetime, timedelta, timezone
from django.utils import timezone as django_timezone
from django.db import transaction
from django.db.models.functions import TruncMonth
from reportlab.platypus import SimpleDocTemplate, Paragraph
from reportlab.lib.styles import getSampleStyleSheet
from openpyxl import Workbook
from reportlab.platypus import  Spacer
from .workflow import OFFICER_ROLES, PROJECT_ROLES, audit, notify, role_required


def get_participants_for_request(request, limit=None):
    if request.user.is_superuser:
        queryset = Participation.objects.all()
    elif request.user.is_authenticated:
        queryset = Participation.objects.filter(user=request.user)
    else:
        queryset = Participation.objects.none()

    queryset = queryset.order_by('-joined_at')
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
    return render(request, 'about_us.html', context={'participants': participants})


def Home(request):
    projects= Project.objects.filter(project_status='ongoing').count()
    print(projects)
    context ={'projects':projects}
    return render(request, 'home.html', context)

@login_required(login_url='login')
def Participation_details(request,pk):
    participation=get_object_or_404(Participation,id=pk)
    participants = get_participants_for_request(request, limit=5)
    
    form=participationForm(instance=participation)
    if request.method=='POST':
        form=participationForm(request.POST, instance=participation)
        if form.is_valid():
            form.save()
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
    ongoingcount=Project.objects.filter(project_status='ongoing').count()
    upcomingcount=Project.objects.filter(project_status='upcoming').count()
    completedcount=Project.objects.filter(project_status='completed').count()
    delayedcount=Project.objects.filter(project_status='delayed').count()
    stalledcount=Project.objects.filter(project_status='stalled').count()
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

    # Aggregate project counts by status for the chart
    status_labels = [choice[1] for choice in Project.STATUS_CHOICES]
    status_counts = [0] * len(status_labels)
    status_lookup = {choice[0]: choice[1] for choice in Project.STATUS_CHOICES}
    for item in projects:
        status_key = item['project_status']
        if status_key in status_lookup:
            status_counts[list(status_lookup.keys()).index(status_key)] = item['total']

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
        .filter(start_date__isnull=False, start_date__gte=today.replace(day=1) - timedelta(days=365))
        .annotate(month=TruncMonth('start_date'))
        .values('month')
        .annotate(
            total_budget=Sum('project_Budgeting'),
            used_budget=Sum('amount_spent')
        )
        .order_by('month')
    )

    monthly_map = {(item['month'].year, item['month'].month): {'allocated': item['total_budget'] or 0, 'used': item['used_budget'] or 0} for item in monthly_projects}
    for idx, month_key in enumerate(months):
        month_data = monthly_map.get(month_key, {'allocated': 0, 'used': 0})
        allocated[idx] = month_data['allocated']
        used[idx] = month_data['used']

    # Count projects started during the last twelve months for the dashboard line chart.
    project_months = (
        Project.objects.filter(start_date__isnull=False, start_date__gte=(today - timedelta(days=365)).date())
        .annotate(month=TruncMonth('start_date'))
        .values('month')
        .annotate(count=Count('id'))
    )
    project_counts_by_month = {item['month'].month: item['count'] for item in project_months}
    project_counts = [project_counts_by_month.get(month, 0) for month in months]

    participants = get_participants_for_request(request, limit=5)
    attention_projects = Project.objects.filter(
        Q(project_status__in=['delayed', 'suspended']) |
        Q(end_date__lt=today.date(), project_status__in=['ongoing', 'upcoming'])
    ).order_by('end_date')[:4]
    open_issues = ReportIssue.objects.exclude(status__in=['resolved', 'dismissed'])
    recent_issues = open_issues.select_related('project').order_by('-created_at')[:4]
    recent_projects = Project.objects.order_by('-created_at')[:4]

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
             'pro':pro
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
            
            return redirect('contactus')
        
    context={'form':form, 'participants': participants}
    return render(request, 'contact_us.html',context)

@login_required(login_url='login')
def Testimonials(request):
    query = request.GET.get('q', '').strip()
    selected_project = request.GET.get('project', '')
    selected_rating = request.GET.get('rating', '')
    testimonials = Testimonial.objects.select_related('project', 'user')
    if not request.user.is_superuser:
        testimonials = testimonials.filter(is_approved=True)
    if query:
        testimonials = testimonials.filter(Q(name__icontains=query) | Q(content__icontains=query) | Q(project__project_title__icontains=query))
    if selected_project:
        testimonials = testimonials.filter(project_id=selected_project)
    if selected_rating in {'1', '2', '3', '4', '5'}:
        testimonials = testimonials.filter(rating=int(selected_rating))
    
    participants = get_participants_for_request(request, limit=4)

    context={
        'testimonials':testimonials,
        'participants': participants,
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
    return render(request, 'notifications.html')

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
    return render(request,'budgetanalysis.html')

@login_required(login_url='login')
def PerfomanceMetrix(request):
    return render(request,'perfomancematrix.html')


@login_required(login_url='login')
def completed(request):
    projects= Project.objects.filter(project_status='completed')
    q=request.GET.get('q') if request.GET.get('q') is not None else ''
    project = Project.objects.filter(
        Q(project_title__icontains=q) |
        Q(project_description__icontains=q) |
        Q(project_status__icontains=q) 
    )
    paginator = Paginator(projects, 6)  # number per page

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context= {'projects':page_obj, 'project':project}
    return render( request,'completed.html', context) 

@login_required(login_url='login')
def delayed(request):
    delaying= Project.objects.filter(project_status='delayed')
    
    paginator = Paginator(delaying, 6)  # number per page

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context= {'delaying':delaying,'projects':page_obj}
    return render( request,'delayed.html', context) 

@login_required(login_url='login')
def delayedstatus(request,pk):
    projects= Project.objects.filter(project_status='delayed', id=pk)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = projects[0]  # Assuming only one project is returned
            participation.save()
            return redirect('delayed')

    context= {'projects':projects, 'form':form}
    return render( request,'statuses.html', context)



@login_required(login_url='login')
def teams(request):
    tim=Team.objects.all()
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    context={'tim':tim, 'participants':participants}
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
            return redirect('team')
    return render(request,'add_team.html',context={'form':form,'participants':participants})

@login_required(login_url='login')
def update_team(request,pk):
    tim=get_object_or_404(Team,pk=pk)
    form=TeamsForm(instance=tim)
    if request.method=='POST':
        form=TeamsForm(request.POST,request.FILES,instance=tim)
        if request.is_valid():
            form.save()
            return redirect('team')
    context={'tim':tim}
    return render(request,'update_team.html',context)

@login_required(login_url='login')
def delete_team(request,pk):
    deletetim=get_object_or_404(Team,pk=pk)
    if request.method=='POST':
        deletetim.delete()
        return redirect('team')
    return render(request,'delete_team.html',{'deletetim':deletetim})

@login_required(login_url='login')
def teams_details(request,pk):
    details=get_object_or_404(Team,id=pk)
    form=TeamsForm(instance=details)
    if request.method=='POST':
        form=TeamsForm(request.POST,request.FILES,instance=details)
        if request.is_valid():
            form.save()
            return redirect('team')
    context={
           'details':details,
           'form':form 
        }
    return render(request, 'teams_details.html',context)
    
    
        
@login_required(login_url='login')
def project_overview(request):

    q = request.GET.get('q') if request.GET.get('q') is not None else ''

    projects = Project.objects.filter(
        Q(project_title__icontains=q) |
        Q(project_description__icontains=q) |
        Q(project_status__icontains=q) |
        Q(implementing_agency__icontains=q)
    ).order_by('-id')

    paginator = Paginator(projects, 6)  # number per page

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        "projects": page_obj
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
def ongoing(request):
    projects= Project.objects.filter(project_status='ongoing')
    q=request.GET.get('q') if request.GET.get('q') is not None else ''
    project = Project.objects.filter(
        Q(project_title__icontains=q) |
        Q(project_description__icontains=q) |
        Q(project_status__icontains=q) 
    )
    
    paginator = Paginator(projects, 6)  # 6 per page
    page_number = request.GET.get('page')
    projects = paginator.get_page(page_number)

    
    context= {'projects':projects, 'project':project}
    return render( request,'ongoing.html', context) 

@login_required(login_url='login')
def upcoming(request):
    projects= Project.objects.filter(project_status='upcoming')
    q=request.GET.get('q') if request.GET.get('q') is not None else ''
    project = Project.objects.filter(
        Q(project_title__icontains=q) |
        Q(project_description__icontains=q) |
        Q(project_status__icontains=q) 
    )
    paginator = Paginator(projects, 6)  # number per page

    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context= {'projects':page_obj, 'project':project}
    return render( request,'upcoming.html', context) 

@login_required(login_url='login')
def project(request):
    projects= Project.objects.filter(project_status='project')
    projects=Project.objects.all().order_by('-end_date')[:1]
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    context= {'projects':projects, 'participants':participants}
    return render(request, "project.html",context)

@login_required(login_url='login')
def UpcomingStatuses(request,pk):
    projects= Project.objects.filter(project_status='upcoming', id=pk)
    Participants=Participation.objects.filter(user=request.user)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = projects[0] 
            participation.save()
            return redirect('upcoming')
    context= {'projects':projects, 'Participants':Participants, 'form':form}
    return render( request,'statuses.html', context) 

@login_required(login_url='login')
def CompletedStatuses(request,pk):
    projects= Project.objects.filter(project_status='completed',id=pk)
    Participants=Participation.objects.filter(user=request.user)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = projects[0]  # Assuming only one project is returned
            participation.save()
            return redirect('completed')
    context= {'projects':projects, 'Participants':Participants, 'form':form}
    return render( request,'statuses.html', context) 



@login_required(login_url='login')
def OngoingStatuses(request, pk):

    projects = Project.objects.filter(project_status='ongoing', id=pk)

    Participants = get_participants_for_request(request, limit=5)
    form = participationForm()

    if request.method == 'POST':
        form = participationForm(request.POST)
        if form.is_valid():
            participation = form.save(commit=False)
            participation.user = request.user
            participation.project = projects[0]
            participation.save()
            return redirect('ongoing')

    context = {
        'projects': projects,
        'Participants': Participants,
        'form': form
    }

    return render(request, 'statuses.html', context)
  
@login_required(login_url='login')
def divisionform(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
        
    form= ProjectDivisionForm()
    if request.method=='POST':
        form= ProjectDivisionForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('division_details')
    context={'form':form, 'participants':participants}
    return render(request,'division.html', context)

@login_required(login_url='login')
def Division_details(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
        
    divisions=Project_Division.objects.all()
    context={'divisions':divisions, 'participants':participants}
    return render(request,'division_details.html', context)

def Division_view(request,pk):
    division=get_object_or_404(Project_Division,id=pk)
    context={'division':division}
    return render(request,'division_view.html',context)

def edit_division(request,pk):
    editdivision=get_object_or_404(Project_Division,id=pk)
    form=ProjectDivisionForm(instance=editdivision)
    if request.method=='POST':
        form=ProjectDivisionForm(request.POST,request.FILES,instance=editdivision)
        if form.is_valid():
            form.save()
            return redirect('division_details')
    context={'form':form,'division':editdivision}
    return render(request,'division.html',context)

def delete_division(request,pk):
    division=get_object_or_404(Project_Division,id=pk)
    if request.method=='POST':
        division.delete()
        return redirect('division_details')
    context={'division':division}
    return render(request,'delete/delete_division.html',context)


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
    milestones = Milestone.objects.all()
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
    context={'milestones': milestones, 'participants': participants}
    return render(request, 'milestone_list.html', context)

@login_required(login_url='login')
def milestone_create(request):
    if request.method == 'POST':
        form = MilestoneForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('milestone_list')
    else:
        form = MilestoneForm()
    return render(request, 'milestone_form.html', {'form': form})

@login_required(login_url='login')
def milestone_update(request, pk):
    milestone = get_object_or_404(Milestone, pk=pk)
    if request.method == 'POST':
        form = MilestoneForm(request.POST, instance=milestone)
        if form.is_valid():
            form.save()
            return redirect('milestone_list')
    else:
        form = MilestoneForm(instance=milestone)
    return render(request, 'milestone_form.html', {'form': form})

@login_required(login_url='login')
def milestone_delete(request, pk):
    milestone = get_object_or_404(Milestone, pk=pk)
    if request.method == 'POST':
        milestone.delete()
        return redirect('milestone_list')
    return render(request, 'milestone_confirm_delete.html', {'milestone': milestone})



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


def media_list(request):
    media_files = Media.objects.all().order_by('-id')

    context = {
        "media_files": media_files,
        "total_media": media_files.count(),
        "total_images": media_files.filter(media_type='image').count(),
        "total_videos": media_files.filter(media_type='video').count(),
        "total_docs": media_files.filter(media_type='document').count(),
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




# 🔹 Project Comments View
@login_required(login_url='login')
def project_detail(request, project_id):
    project = get_object_or_404(Project, id=project_id)
    comments = project.comments.all()
    if request.method == "POST":
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.project = project
            comment.user = request.user
            comment.save()
            return redirect('project_detail', project_id=project.id)
    else:
        form = CommentForm()
    return render(request, 'project_detail.html', {'project': project, 'comments': comments, 'form': form})

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
            return redirect('project_detail', project_id=project.id)
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
            return redirect('project_detail', project_id=project.id)
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
    tenders = Tender.objects.all()
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
      
    return render(request, 'tender_list.html', {'tenders': tenders, 'participants': participants})

# View tender details
@login_required(login_url='login')
def tender_detail(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    
    return render(request, 'tender_detail.html', {'tender': tender})

@login_required(login_url='login')
@role_required('contractor')
def apply_tender(request, pk):
    tender = get_object_or_404(Tender, id=pk)
    if tender.status != 'published' or (tender.closing_date and tender.closing_date < django_timezone.localdate()):
        messages.error(request, 'This tender is not open for applications.')
        return redirect('tender_detail', tender_id=tender.id)
    if TenderApplication.objects.filter(tender=tender, applicant=request.user).exists():
        messages.error(request, 'You have already submitted an application for this tender.')
        return redirect('my_bids')
    form = TenderApplicationForm(request.POST or None, request.FILES or None)

    if form.is_valid():
        application = form.save(commit=False)
        application.tender = tender
        application.applicant = request.user
        application.save()
        audit(request, 'tender_application_submitted', application, project=tender.project)
        notify(tender.created_by, 'tender', 'New tender application', f'{application.company_name} applied for {tender.reference_number}.', f'/tenders/{tender.id}/')
        messages.success(request, "Your application has been submitted.")
        return redirect('tender_list')

    context = {
        'tender': tender,   # <-- pass 'tender', not 'apply'
        'form': form,
    }
    return render(request, 'apply_tender.html', context)

def calculate_financial_scores(tender):
    applications = tender.applications.all()

    if not applications.exists():
        return

    lowest_bid = min(app.bid_amount for app in applications)

    for app in applications:
        if app.bid_amount > 0:
            app.financial_score = (lowest_bid / app.bid_amount) * 100
        else:
            app.financial_score = 0

        app.total_score = (app.technical_score * 0.7) + (app.financial_score * 0.3)
        app.save()
        
@login_required(login_url='login')
@role_required(*OFFICER_ROLES)
def evaluate_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    applications = tender.applications.all()

    if tender.status not in ('closed', 'evaluating'):
        messages.error(request, 'Only closed tenders can be evaluated.')
        return redirect('tender_detail', tender_id=tender.id)

    if request.method == "POST":
        for app in applications:
            score = request.POST.get(f"tech_{app.id}")
            if score:
                app.technical_score = float(score)
                app.save()

        # 🔥 Auto calculate financial + total
        calculate_financial_scores(tender)
        tender.status = 'evaluating'
        tender.save(update_fields=['status'])
        audit(request, 'tender_evaluated', tender, project=tender.project)

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
    if tender.status != 'evaluating':
        messages.error(request, 'Evaluate this tender before awarding it.')
        return redirect('tender_detail', tender_id=tender.id)

    with transaction.atomic():
        winner = tender.applications.order_by('-total_score', 'submitted_at').first()
        if not winner:
            messages.error(request, 'This tender has no applications to award.')
            return redirect('tender_detail', tender_id=tender.id)
        tender.applications.exclude(pk=winner.pk).update(status='rejected')
        winner.status = 'awarded'
        winner.save(update_fields=['status'])
        tender.status = 'awarded'
        tender.award_date = django_timezone.localdate()
        tender.award_amount = winner.bid_amount
        tender.save(update_fields=['status', 'award_date', 'award_amount'])

    audit(request, 'tender_awarded', tender, project=tender.project, changes={'application_id': winner.id})
    notify(winner.applicant, 'tender', 'Tender awarded', f'Your bid for {tender.reference_number} was awarded.', '/my-bids/')
    messages.success(request, 'Tender awarded and all other applicants were notified of the outcome.')
    return redirect('tender_detail', tender_id=tender.id)

# Add a new tender
@login_required(login_url='login')
def add_tender(request):
    pr=Project.objects.all()
    form = TenderForm()

    if request.method == "POST":
        form = TenderForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('tender_list')
    return render(request, 'tender_form.html', {'form': form, 'pr': pr})

# Update an existing tender
@login_required(login_url='login')
def update_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    if request.method == "POST":
        form = TenderForm(request.POST, request.FILES, instance=tender)
        if form.is_valid():
            form.save()
            return redirect('tender_list')
    else:
        form = TenderForm(instance=tender)
    return render(request, 'tender_form.html', {'form': form, 'title': 'Update Tender'})

# Delete a tender
@login_required(login_url='login')
def delete_tender(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    if request.method == "POST":
        tender.delete()
        return redirect('tender_list')
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
    auditing=AuditLog.objects.all()
    return render(request,'audit.html',{'auditing':auditing})

@login_required(login_url='login')
def add_audit(request):
    form=AuditLogForm()
    if request.method=='POST':
        form=AuditLogForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('AuditLog')
    return render(request,'add_audit.html',{'form':form})

@login_required(login_url='login')
def audit_details(request,pk):
    audit_details=get_object_or_404(AuditLog,id=pk)
    if request.method=='POST':
        form=AuditLogForm(request.POST,request.FILES,instance=audit_details),
        if form.is_valid():
            form.save()
            return redirect('AuditLog')
    else:
        form=AuditLogForm(instance=audit_details)
    context={'audit_details':audit_details, 'form':form}
    return render(request,'audit_details.html',context)

# 🔹 List All Project Stages

def projectstage(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    stages = ProjectStage.objects.all()
    return render(request, 'projectstage_list.html', {'stages': stages, 'participants': participants})

# 🔹 View Project Stage Details
def projectstage_details(request, pk):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    stage = get_object_or_404(ProjectStage, pk=pk)
    return render(request, 'projectstage_detail.html', {'stage': stage, 'participants': participants})



def ProjectStageCreate(request):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
    
    form=ProjectStageForm()
    if request.method=='POST':
        form=ProjectStageForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('projectstage_list')
    context={'form':form, 'participants': participants}
    return render(request,'projectstage_form.html', context)

# 🔹 Update Project Stage
@login_required(login_url='login')
def ProjectStageUpdate(request,pk):
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
        
    updatestage=get_object_or_404(ProjectStage,pk=pk)
    form=ProjectStageForm(instance=updatestage)
    if request.method=='POST':
        form=ProjectStageForm(request.POST,instance=updatestage)
        if form.is_valid():
            form.save()
            return redirect('projectstage_list')
    context={'form':form, 'participants': participants, 'updatestage':updatestage}
    return render(request,'projectstage_update.html', context)




# 🔹 Delete Project Stage
@login_required(login_url='login')
def ProjectStageDelete(request,pk):
    deletestage=get_object_or_404(ProjectStage,id=pk)
    if request.method=='POST':
        deletestage.delete()
        return redirect('projectstage_list')
    return render(request,'projectstage_confirm_delete.html',{'deletestage':deletestage})

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

    def get_data(region):
        projects = Project.objects.filter(project_location=region)
        total = projects.count()
        completed = projects.filter(project_status='completed').count()
        ongoing = projects.filter(project_status='ongoing').count()
        delayed = projects.filter(project_status='delayed').count()
        return {
            "total": total,
            "completed": completed,
            "ongoing": ongoing,
            "delayed": delayed,
            "completion_rate": round((completed / total) * 100, 1) if total else 0,
        }

    context = {
        "regions": regions,
        "region1": region1,
        "region2": region2,
        "data1": get_data(region1) if region1 else None,
        "data2": get_data(region2) if region2 else None,
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
    proje=Project.objects.all()

    return render(request, 'public_participation/citizen.html', {
        'submissions': submissions,
        'proje': proje
    })

@login_required(login_url='login')
def submit_issue(request):
    if request.method == "POST":

        title = request.POST.get('title')
        message = request.POST.get('message')
        category = request.POST.get('category')

        if not title or not message:
            return redirect('citizen_portal')

        CitizenSubmission.objects.create(
            user=request.user,
            title=title,
            message=message,
            category=category
        )
        messages.success(request, "Your submission has been received successfully!")

        return redirect('citizen_portal')
    


@login_required(login_url='login')
@role_required('contractor')
def contractor_dashboard(request):
    con=Project.objects.all()
    contractors = Contractor.objects.all().order_by('-created_at')
    reports = StageReport.objects.all().order_by('-created_at')
    
    stages = ProjectStage.objects.all()
    form = contractorForm(request.POST or None)

    if request.method == "POST":
        if form.is_valid():
            form.save()
            return redirect('contractor_performance')


    return render(request, 'contractors/dashboard.html', {
        'contractors': contractors,
        'reports': reports,
        'con':con,
        'stages': stages,
        'form': form
    })
 
@login_required(login_url='login')
@role_required('contractor')
def submit_stage_report(request):
    projects = Project.objects.all()
    stages = ProjectStage.objects.all()
    contractors = Contractor.objects.all()

    if request.method == "POST":
        try:
            report = StageReport(
                project_id=request.POST.get('project'), stage_id=request.POST.get('stage'),
                contractor_id=request.POST.get('contractor') or None, reported_by=request.user,
                description=request.POST.get('description'), progress_percentage=request.POST.get('progress'),
                location=request.POST.get('location'), photo=request.FILES.get('photo'),
            )
            report.full_clean()
            report.save()
            report.stage.progress_percentage = report.progress_percentage
            report.stage.save(update_fields=['progress_percentage'])
            audit(request, 'stage_report_submitted', report, project=report.project)
        except (ValueError, ValidationError) as error:
            messages.error(request, f'Unable to submit report: {error}')
            return redirect('submit_stage_report')
        return redirect('contractor_dashboard')

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
    
    
def budget_dashboard(request):

    budgets = Budget.objects.all()
    spending=ProjectExpense.objects.all()

    return render(request, 'finance/budget_dashboard.html', {
        'budgets': budgets,
        'spending': spending
    })
    

def add_budget(request):
    form= BudgetForm()
    if request.method == "POST":
        form = BudgetForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('dashboard')

    return render(request, 'finance/add_budget.html', {'form': form})
from django.contrib.auth.decorators import login_required
from django.shortcuts import render
from .models import TenderApplication

@login_required(login_url='login')
def track_application(request):
    applications = TenderApplication.objects.filter(
        applicant=request.user
    ).select_related('tender')

    context = {
        'applications': applications,
        'total_applications': applications.count(),
        'awarded_count': applications.filter(status='awarded').count(),
        'pending_count': applications.filter(
            status__in=['submitted', 'under_review']
        ).count(),
        'rejected_count': applications.filter(status='rejected').count(),
    }

    return render( request,'Track_application/tracking_application.html', context)

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
    applications = TenderApplication.objects.filter(applicant=request.user).select_related('tender')
    
    return render(request, 'My_bids/bids.html', {
        'applications': applications
    })
    

@login_required
def create_request(request):
    if request.method == 'POST':
        form = GovernmentRequestForm(request.POST, request.FILES)
        if form.is_valid():
            req = form.save(commit=False)
            req.citizen = request.user
            req.save()
            return redirect('all_requests')
    else:
        form = GovernmentRequestForm()

    return render(request, 'GovRequests/create_request.html', {'form': form})

@login_required
def my_requests(request):
    requests = GovernmentRequest.objects.filter(citizen=request.user)
    return render(request, 'GovRequests/my_requests.html', {'requests': requests})


@login_required(login_url='login')
def all_requests(request):
    requests = GovernmentRequest.objects.all().order_by('-created_at')
    return render(request, 'GovRequests/all_requests.html', {'requests': requests})

@login_required(login_url='login')
def request_detail(request, pk):
    req = get_object_or_404(GovernmentRequest, pk=pk)
    return render(request, 'GovRequests/request_detail.html', {'request': req})

@login_required(login_url='login')
def respond_request(request, pk):
    req = get_object_or_404(GovernmentRequest, pk=pk)

    if request.method == 'POST':
        response = request.POST.get('response')
        req.response = response
        req.status = 'responded'
        req.save()
        return redirect('all_requests')

    return render(request, 'GovRequests/respond_request.html', {'request': req})

@login_required(login_url='login')
def close_request(request, pk):
    req = get_object_or_404(GovernmentRequest, pk=pk)
    req.status = 'closed'
    req.save()
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
    projects = Project.objects.all()
    tenders = TenderApplication.objects.all()
    requests = GovernmentRequest.objects.all()

    context = {
        'total_projects': projects.count(),
        'completed_projects': projects.filter(project_status='completed').count(),
        'ongoing_projects': projects.filter(project_status='ongoing').count(),

        'total_tenders': tenders.count(),
        'awarded_tenders': tenders.filter(status='awarded').count(),

        'total_requests': requests.count(),
        'resolved_requests': requests.filter(status='resolved').count(),
    }

    return render(request, 'Reports/system_reports.html', context)


def export_pdf(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="system_report.pdf"'

    doc = SimpleDocTemplate(response)
    styles = getSampleStyleSheet()

    # ✅ Build context DIRECTLY (not from another view)
    total_projects = Project.objects.count()
    completed_projects = Project.objects.filter(project_status='completed').count()
    ongoing_projects = Project.objects.filter(project_status='ongoing').count()

    total_tenders = TenderApplication.objects.count()
    awarded_tenders = TenderApplication.objects.filter(status='awarded').count()

    total_requests = GovernmentRequest.objects.count()
    resolved_requests = GovernmentRequest.objects.filter(status='resolved').count()

    # 📄 Content
    content = []

    content.append(Paragraph("GovTracker System Report", styles['Title']))
    content.append(Spacer(1, 10))

    content.append(Paragraph(f"Total Projects: {total_projects}", styles['Normal']))
    content.append(Paragraph(f"Completed Projects: {completed_projects}", styles['Normal']))
    content.append(Paragraph(f"Ongoing Projects: {ongoing_projects}", styles['Normal']))

    content.append(Spacer(1, 10))

    content.append(Paragraph(f"Total Tenders: {total_tenders}", styles['Normal']))
    content.append(Paragraph(f"Awarded Tenders: {awarded_tenders}", styles['Normal']))

    content.append(Spacer(1, 10))

    content.append(Paragraph(f"Total Requests: {total_requests}", styles['Normal']))
    content.append(Paragraph(f"Resolved Requests: {resolved_requests}", styles['Normal']))

    doc.build(content)

    return response


def export_excel(request):
    if Workbook is None:
        return HttpResponse('Excel export is unavailable. Install openpyxl.', status=503)
    wb = Workbook()
    ws = wb.active
    ws.title = "Report"

    ws.append(["Category", "Value"])
    ws.append(["Total Projects", Project.objects.count()])
    ws.append(["Completed Projects", Project.objects.filter(project_status='completed').count()])
    ws.append(["Total Requests", GovernmentRequest.objects.count()])

    response = HttpResponse(
        content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
    response['Content-Disposition'] = 'attachment; filename=report.xlsx'

    wb.save(response)
    return response
