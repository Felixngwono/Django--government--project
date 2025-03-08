from reportlab.lib.pagesizes import letter
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from .models import PDF, Project_Division, User, Project
from django.contrib import messages
from .forms import MyUserCreationForm, ContactUsForm,FeedbackForm, NotificationForm, PdfForm,ProjectCreationForm,ProjectDivisionForm, ProjectTypeForm
from io import BytesIO
from django.http import HttpResponse
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

from django.shortcuts import render
from django.http import HttpResponse
from django.template.loader import get_template
from django.db.models import Sum
import pdfkit
from .models import User, Project, Budget, Feedback, Notification, Milestone, PDF, Media

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



@login_required
def AboutUs(request):
    return render(request, 'about_us.html')

def Home(request):
    projects= Project.objects.filter(project_status='ongoing').count()
    print(projects)
    context ={'projects':projects}
    return render(request, 'home.html', context)

@login_required
def ContactusPage(request):
    form = ContactUsForm()
    
    if request.method == 'POST':
            form = ContactUsForm(request.POST)
            if form.is_valid():
                form.save()
            
            return redirect('contactus')
        
    context={'form':form}
    return render(request, 'contact_us.html',context)


@login_required
def notifications(request):
    return render(request, 'notifications.html')

def welcomingpage(request):
    return render(request, 'welcoming page.html') 

 
def loginpage(request):
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
            messages.info(request,'Login successful')
            return redirect('index')
        else:
             messages.warning(request,'Wrong username or password')
    return render(request, 'login.html')

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


@login_required
def updateprofile(request,pk):
    user = request.user

    profiles = get_object_or_404(User, id=pk)
    
    if request.method == 'POST':
        form = MyUserCreationForm(request.POST, request.FILES, instance=profiles)
        if form.is_valid():
            form.save()
            return redirect('index')
    
    else: 
        form = MyUserCreationForm(instance=profiles)   

    return render(request, 'profile.html', {'form': form, 'profiles': profiles, 'user': user})

@login_required
def deleteprofile(request, pk):
    project= User.objects.get(id=pk)
    if request.method== 'POST':
        project.delete()
        return redirect ('index')
    return render(request, 'deleteprofile.html')



@login_required
def index(request):
    ongoingcount=Project.objects.filter(project_status='ongoing').count()
    upcomingcount=Project.objects.filter(project_status='upcoming').count()
    completedcount=Project.objects.filter(project_status='completed').count()
    allproject=Project.objects.all().count()
    users=User.objects.all().count()
    agencies=Project_Division.objects.all().count()
    projects=Project.objects.all().values('project_status').annotate(total=Count('project_status')).order_by('-total')
   

    context={'ongoingcount':ongoingcount,
             'upcomingcount':upcomingcount,
             'completedcount':completedcount,
             'allproject':allproject,
             'users':users,
             'project':projects,
             'agencies':agencies,
             'projects':projects,
             }
    return render(request,'index.html',context)

def sidebar(request):
    return render(request,'sidebar.html')

def header(request):
    return render(request,'header.html')

def jobApplication(request):
    return render(request,'job.html')

@login_required
def feedback(request):
    form= FeedbackForm()
    if request.method=='POST':
        form=FeedbackForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('index')
        
    context= {'form':form}
    return render(request,'feedback.html',context)



    
@login_required
def CreateProject(request):
    
    
    form= ProjectCreationForm()
    if request.method=='POST':
        form= ProjectCreationForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('projectoverview')
    context={'form':form,}
    return render(request,'project_form.html', context)

@login_required
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

@login_required
def deleteProject(request, pk):
    project= Project.objects.get(id=pk)
    if request.method== 'POST':
        project.delete()
        return redirect ('projectoverview')
    return render(request, 'delete.html')

@login_required
def BudgetAnalysis(request):
    return render(request,'budgetanalysis.html')

@login_required
def PerfomanceMetrix(request):
    return render(request,'perfomancematrix.html')


@login_required
def completed(request):
    projects= Project.objects.filter(project_status='completed')
    context= {'projects':projects}
    return render( request,'completed.html', context) 

@login_required
def upcoming(request):
    return render(request,'upcoming.html')
 
@login_required   
def teams(request):
    return render(request,'team.html')

@login_required
def testimonials(request):
    return render(request,'testimonials.html')

@login_required
def project_overview(request):
    projects= Project.objects.all()
    context= {'projects':projects,}
    return render( request,'overview.html', context)  

@login_required
def ongoing(request):
    projects= Project.objects.filter(project_status='ongoing')
   
    context= {'projects':projects }
    return render( request,'ongoing.html', context) 

@login_required
def upcoming(request):
    projects= Project.objects.filter(project_status='upcoming')
    context= {'projects':projects}
    return render( request,'upcoming.html', context) 

@login_required
def project(request):
    projects= Project.objects.filter(project_status='project')
    context= {'projects':projects}
    return render(request, "project.html",context)

@login_required
def UpcomingStatuses(request,pk):
    projects= Project.objects.filter(project_status='upcoming', id=pk)
    context= {'projects':projects}
    return render( request,'statuses.html', context) 
@login_required
def CompletedStatuses(request,pk):
    projects= Project.objects.filter(project_status='completed',id=pk)
    context= {'projects':projects}
    return render( request,'statuses.html', context) 

@login_required
def OngoingStatuses(request,pk):
    projects= Project.objects.filter(project_status='ongoing',id=pk)
    context= {'projects':projects}
    return render( request,'statuses.html', context) 
  
@login_required
def divisionform(request):
    form= ProjectDivisionForm()
    if request.method=='POST':
        form= ProjectDivisionForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('division_details')
    context={'form':form}
    return render(request,'division.html', context)

@login_required
def Division_details(request):
    divisions=Project_Division.objects.all()
    context={'divisions':divisions}
    return render(request,'division_details.html', context)

@login_required
def ptypes(request):
    form=ProjectTypeForm()
    if request.method=='POST':
        form=ProjectTypeForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect(request,'division_details')
    context={'form':form}
    return render(request,'projectTypes.html',context)

from django.db.models import Count
@login_required
def charts(request):
    projects=Project.objects.all().values('project_status').annotate(total=Count('project_status')).order_by('-total')
   
    context={
        'projects':projects,
    }
    return render(request,'chart.html',context)

from django.shortcuts import render, get_object_or_404, redirect
from .models import Milestone
from .forms import MilestoneForm

def milestone_list(request):
    milestones = Milestone.objects.all()
    return render(request, 'milestone_list.html', {'milestones': milestones})

def milestone_create(request):
    if request.method == 'POST':
        form = MilestoneForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('milestone_list')
    else:
        form = MilestoneForm()
    return render(request, 'milestone_form.html', {'form': form})

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

def milestone_delete(request, pk):
    milestone = get_object_or_404(Milestone, pk=pk)
    if request.method == 'POST':
        milestone.delete()
        return redirect('milestone_list')
    return render(request, 'milestone_confirm_delete.html', {'milestone': milestone})

from django.shortcuts import render
from .models import Notification

def notification_list(request):
    notifications = Notification.objects.all()
    return render(request, 'notification_list.html', {'notifications': notifications})

def notification_create(request):
    form=NotificationForm()
    if request.method=='POST':
        form=NotificationForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('notification_list')
   
    return render(request, 'notification_create.html',{'form':form})


from django.shortcuts import render, get_object_or_404, redirect
from .models import Media
from .forms import MediaForm

def media_list(request):
    media_files = Media.objects.all()
    return render(request, 'media_list.html', {'media_files': media_files})

def media_upload(request):
    form = MediaForm()
    if request.method == 'POST':
        form = MediaForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('media_list')
      
    return render(request, 'media_upload.html', {'form': form})


from django.shortcuts import render, redirect
from .models import Milestone
from .forms import MilestoneForm

def milestone_create(request):
    form = MilestoneForm()
    if request.method == "POST":
        form = MilestoneForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('milestone_list')  # Redirect after saving
    
    return render(request, 'milestone_form.html', {'form': form})


from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from django.urls import path
from .models import Project, Comment, ProgressReport, Tender, ProjectLocation, ReportIssue
from .forms import CommentForm, ProgressReportForm, TenderForm, ReportIssueForm

# 🔹 Project Comments View
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
@login_required
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
@login_required
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
@login_required
def report_issue(request, pk):
    project = get_object_or_404(Project, id=pk)
    if request.method == "POST":
        form = ReportIssueForm(request.POST, request.FILES)
        if form.is_valid():
            issue = form.save(commit=False)
            issue.project = project
            issue.user = request.user
            issue.save()
            return redirect('project_detail')
    else:
        form = ReportIssueForm()
    return render(request, 'report_issue.html', {'form': form, 'project': project})

@login_required
def issue_list(request):
    issues = ReportIssue.objects.all()
    return render(request, 'issue_list.html', {'issues': issues})

@login_required
def issue_detail(request, issue_id):
    issue = get_object_or_404(ReportIssue, id=issue_id)
    return render(request, 'issue_detail.html', {'issue': issue})

from django.shortcuts import render, get_object_or_404
from .models import Tender

def tender_list(request):
    tenders = Tender.objects.all()
    return render(request, 'tender_list.html', {'tenders': tenders})

def tender_detail(request, tender_id):
    tender = get_object_or_404(Tender, id=tender_id)
    return render(request, 'tender_detail.html', {'tender': tender})


from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import ProjectLocation
from .forms import ProjectLocationForm

@login_required
def add_project_location(request):
    if request.method == 'POST':
        form = ProjectLocationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('project_location_list')
    else:
        form = ProjectLocationForm()
    return render(request, 'add_project_location.html', {'form': form})

@login_required
def project_location_list(request):
    locations = ProjectLocation.objects.all()
    return render(request, 'project_location_list.html', {'locations': locations})

@login_required
def project_location_detail(request, location_id):
    location = get_object_or_404(ProjectLocation, id=location_id)
    return render(request, 'project_location_detail.html', {'location': location})

from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .models import Comment, Project
from .forms import CommentForm

@login_required
def comment_list(request):
    comments = Comment.objects.all()
    return  render(request, 'comment_list.html', { 'comments': comments})


@login_required
def add_comment(request):
    form = CommentForm()
    if request.method=='POST':
        form=CommentForm(request.POST,request.FILES)
        if form.is_valid():
            form.save()
            return redirect('comment_list')

    return render(request, 'add_comment.html', {'form': form})



