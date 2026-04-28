from django.db.models import Count
from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from .models import Announcement, CitizenEvidence, CitizenSubmission, Comment,PDF, AuditLog, Contractor, Participation, ProgramImpact, ProgressUpdate, Project_Division, Project_type, ProjectExpense, ProjectRisk, ProjectStage, ReportIssue,  StageReport, Stakeholder, Team, Tender, Testimonial, User, Project,  Budget, Feedback, Notification, Milestone, Media
from django.contrib import messages
from .forms import AuditLogForm, BudgetForm, CommentForm,  MediaForm, MilestoneForm, MyUserCreationForm, ContactUsForm,FeedbackForm, NotificationForm, ProgressReportForm, ProjectCreationForm,ProjectDivisionForm, ProjectStageForm, ProjectTypeForm, ReportIssueForm, TeamsForm, TenderApplicationForm, TenderForm, TestimonialForm, contractorForm, participationForm
from django.template.loader import get_template
from django.db.models import Sum
import pdfkit
from django.db.models import Q
from django.core.paginator import Paginator
from django.db.models.functions import ExtractMonth
from datetime import datetime, timedelta, timezone
from django.db.models.functions import TruncMonth

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
    template = get_template('generate_pdf.html')
    context = generate_report(request).context_data
    html = template.render(context)
    pdf = pdfkit.from_string(html, False)
    response = HttpResponse(pdf, content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="report.pdf"'
    return response



@login_required(login_url='login')
def AboutUs(request):
    
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    
    return render(request, 'about_us.html', context={'participants': participants})


def Home(request):
    projects= Project.objects.filter(project_status='ongoing').count()
    print(projects)
    context ={'projects':projects}
    return render(request, 'home.html', context)

@login_required(login_url='login')
def Participation_details(request,pk):
    participation=get_object_or_404(Participation,id=pk)
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
        
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
    projects=Project.objects.all().values('project_status').annotate(total=Count('project_status')).order_by('-total')
    pro=Project.objects.all().order_by('-start_date')[:5]
     # Initialize month list
    project_counts = [0] * 12  # Jan to Dec
# Aggregate budget per month
    data = (
        Project.objects
        .annotate(month=ExtractMonth('start_date'))
        .values('month')
        .annotate(
            total_budget=Sum('budget'),
            used_budget=Sum('amount_spent')
        )
        .order_by('month')
    )

    # Prepare arrays for all 12 months
    months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    allocated = [0]*12
    used = [0]*12

     # Prepare last 12 months
    today = datetime.today()
    months = []
    month_labels = []
    for i in range(11, -1, -1):  # 11 → 0
        month_date = today - timedelta(days=i*30)  # approximate month
        months.append(month_date.month)
        month_labels.append(month_date.strftime('%b'))

    # Count users per month
    users_by_month = User.objects.filter(
        date_joined__year__gte=today.year-1
    ).annotate(
        month=TruncMonth('date_joined')
    ).values('month').annotate(count=Count('id'))

    # Build data array for Chart.js
    data = []
    users_dict = {x['month'].month: x['count'] for x in users_by_month}
    for m in months:
        data.append(users_dict.get(m, 0))


    
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
             'participants':participants,
             'projects_per_month': project_counts,
             'months': months,
             'allocated': allocated,
             'used': used,
             'month_labels': month_labels,
              'user_counts': data,
                'pro':pro
             }
    return render(request, 'dashboard.html',context)

@login_required(login_url='login')
def ContactusPage(request):
    
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
  
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
    testimonials= Testimonial.objects.all()
    
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:4]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    
    context={
        'testimonials':testimonials,
        'participants': participants
    }
    return render(request,'testimonials.html',context)

@login_required(login_url='login')
def testimonial_details(request,pk):
    testimonial=get_object_or_404(Testimonial,id=pk)
    
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
  
    context={'testimonial':testimonial, 'participants': participants}
    return render(request,'testimonial_details.html',context)

@login_required(login_url='login')
def add_testimonial(request):
  
    form=TestimonialForm()
    if request.method=='POST':
        form=TestimonialForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('testimonials')
    context={'form':form}
    return render(request,'add_testimonial.html',context)

@login_required(login_url='login')
def delete_testimonial(request, pk):
    testimonial= Testimonial.objects.get(id=pk)
    if request.method== 'POST':
        testimonial.delete()
        return redirect ('testimonials')
    return render(request, 'delete_testimonial.html')

@login_required(login_url='login')
def update_testimonial(request, pk):
    testimonial=Testimonial.objects.get(id= pk)
    form= TestimonialForm(instance=testimonial)
    if request.method=='POST':
        form= TestimonialForm(request.POST,request.FILES,instance=testimonial)
        if form.is_valid():
            form.save()
            return redirect('testimonials')
    context={'form':form}
    return render(request,'add_testimonial.html', context)

@login_required(login_url='login')
def adminview(request):
    feedbacks=Feedback.objects.all()
    impacts=ProgramImpact.objects.all()
    updates=ProgressUpdate.objects.all()
    budgetings=Budget.objects.all()
    comments=Comment.objects.all()
    risks=ProjectRisk.objects.all()
    stakeholder=Stakeholder.objects.all()
    reportedissues=ReportIssue.objects.all()
    if request.user.is_superuser:
        participants = Participation.objects.all().order_by('-joined_at')[:5]
    else:
        participants = Participation.objects.filter(user=request.user)
  

    context={'feedbacks':feedbacks,
             'impacts':impacts,
             'updates':updates,
             'budgetings':budgetings,
             'comments':comments,
             'risks':risks,
             'stakeholder':stakeholder,
             'reportedissues':reportedissues,
             'participants':participants
             }
    return render(request,'adminview.html',context)

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
    comment=Comment.objects.all()
    projects = Project.objects.all()[:6]
    testimonials=Testimonial.objects.all()[:5]
    return render(request, 'welcoming page.html', context={'projects': projects,'comment':comment,'testimonials':testimonials})

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
            return redirect('index')
        else:
            messages.warning(request, 'Wrong username or password')
    return render(request, 'login.html', {'next': next_url})

@login_required(login_url='login')
def logoutuser(request):
    logout(request)
    messages.info(request,"Its sad to see you leave, welcome again")
    return redirect('login') 

def registrationpage(request):
    form =MyUserCreationForm()
    if request.method == 'POST':
        form = MyUserCreationForm(request.POST,request.FILES)
        if form.is_valid():
                user = form.save(commit=False)
                user.email = user.email
                user.save()
                messages.info(request,'Registration successful, login to continue to main page')
                return redirect('login')
        else:
            messages.warning(request,'An error occured during registration')

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

    Participants = Participation.objects.filter(user=request.user)
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


@login_required(login_url='login')
def media_list(request):
    media_files = Media.objects.all()
    return render(request, 'media_list.html', {'media_files': media_files})

@login_required(login_url='login')
def media_upload(request):
    form = MediaForm()
    if request.method == 'POST':
        form = MediaForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('media_list')
      
    return render(request, 'media_upload.html', {'form': form})



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
    issues = ReportIssue.objects.all()
    return render(request, 'issue_list.html', {'issues': issues})

@login_required(login_url='login')
def add_report_issue(request):
    form=ReportIssueForm()
    if request.method == "POST":
        form = ReportIssueForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
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

def apply_tender(request, pk):
    tender = get_object_or_404(Tender, id=pk)
    form = TenderApplicationForm(request.POST or None, request.FILES or None)

    if form.is_valid():
        application = form.save(commit=False)
        application.tender = tender
        application.applicant = request.user
        application.save()
        messages.success(request, "Your application has been submitted.")
        return redirect('tender_list')

    context = {
        'tender': tender,   # <-- pass 'tender', not 'apply'
        'form': form,
    }
    return render(request, 'apply_tender.html', context)

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
        form=AuditLogForm(request.POST)
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


def send_sms_report(request):
    if request.method == "POST":
        phone = request.POST.get('phone')
        message = request.POST.get('message')

        # TODO: Integrate SMS API here
        print(phone, message)

        messages.success(request, "SMS sent successfully!")
        return redirect('sms_dashboard')


def check_project_status(request):
    code = request.GET.get('code')

    # Dummy response
    context = {
        "code": code,
        "status": "65% Complete"
    }
    return render(request, 'sms/status.html', context)

def regional_analysis(request):
    regions = ["Nairobi", "Kisumu", "Siaya", "Mombasa"]

    region1 = request.GET.get('region1')
    region2 = request.GET.get('region2')

    def get_data(region):
        # Replace with real DB queries
        return {
            "total": 50,
            "completed": 20,
            "ongoing": 20,
            "delayed": 10,
            "completion_rate": 40
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
    delayed = projects.filter(status='delayed')
    if delayed.count() > 0:
        Announcement.objects.create(
            title="Delayed Projects Alert",
            message=f"{delayed.count()} projects are currently delayed. Immediate attention required.",
            level="warning"
        )

    # 2. Completed Projects
    completed = projects.filter(status='completed')
    if completed.count() > 0:
        Announcement.objects.create(
            title="Project Completion Update",
            message=f"{completed.count()} projects have been successfully completed.",
            level="info"
        )

    # 3. Budget Anomalies
    for p in projects:
        if p.actual_budget and p.estimated_budget:
            if p.actual_budget > p.estimated_budget * 1.5:
                Announcement.objects.create(
                    title=f"Budget Overrun: {p.name}",
                    message="Project exceeded budget by more than 50%.",
                    level="critical"
                )

    # 4. Stalled Projects (no update in 30 days)
    for p in projects:
        if p.updated_at:
            days = (timezone.now() - p.updated_at).days
            if days > 30:
                Announcement.objects.create(
                    title=f"Stalled Project: {p.name}",
                    message=f"No updates for {days} days.",
                    level="warning"
                )
                
                

def announcements(request):
    announcements = Announcement.objects.all().order_by('-created_at')
    return render(request, 'announcements/list.html', {
        'announcements': announcements
    })
    
   
def citizen_portal(request):
    submissions = CitizenSubmission.objects.filter(user=request.user).order_by('-created_at')
    proje=Project.objects.all()

    return render(request, 'public_participation/citizen.html', {
        'submissions': submissions,
        'proje': proje
    })

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
    


def contractor_dashboard(request):
    con=Project.objects.all()
    contractors = Contractor.objects.all()
    reports = StageReport.objects.all().order_by('-created_at')
    
    stages = ProjectStage.objects.all()
    form = contractorForm(request.POST or None)

    if request.method == "POST":
        if form.is_valid():
            form.save()
            return redirect('contractor_dashboard')


    return render(request, 'contractors/dashboard.html', {
        'contractors': contractors,
        'reports': reports,
        'con':con,
        'stages': stages,
        'form': form
    })
 
def submit_stage_report(request):
    projects = Project.objects.all()
    stages = ProjectStage.objects.all()
    contractors = Contractor.objects.all()

    if request.method == "POST":
        StageReport.objects.create(
            project_id=request.POST.get('project'),
            stage_id=request.POST.get('stage'),
            contractor_id=request.POST.get('contractor'),
            description=request.POST.get('description'),
            progress_percentage=request.POST.get('progress'),
            location=request.POST.get('location')
        )
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
    form = BudgetForm(request.POST or None)

    if request.method == "POST":
        if form.is_valid():
            form.save()
            return redirect('dashboard')

    return render(request, 'finance/add_budget.html', {'form': form})

