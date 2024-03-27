from django.http import FileResponse
import csv,io
from reportlab.lib.units import inch
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from django.shortcuts import render, redirect
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from .models import PDF, Project_Division, User, Project
from django.contrib import messages
from django.core.paginator import Paginator
from .forms import MyUserCreationForm,PdfForm, ContactUsForm,FeedbackForm,ProjectCreationForm,ProjectDivisionForm, ProjectTypeForm


def PdfFile(request):
    if request.method == 'POST':
        form = PdfForm(request.POST)
        if form.is_valid():
            form.save()
    # Redirect to PDF generation after adding a project
            return redirect('index')  
    else:
        form = PdfForm()
    return render(request, 'pdf.html', {'form': form})
 
def generate_pdf(request):
    response = FileResponse(generate_pdf_file(Project), 
                            as_attachment=True, 
                            filename='Project.pdf')
    return response
 
 
def generate_pdf_file():
    from io import BytesIO
 
    buffer = io.BytesIO()
    p = canvas.Canvas(buffer,pagesize=letter,bottomup=0)
 
    # Create a PDF document
    x = PDF.objects.all()
    p.drawString(100, 750, "project Catalog")
 
    y = 700
    for y in x:
        p.drawString(100, y, f"project_Title: {PDF.project_Title}")
        p.drawString(100, y - 20, f"Project_status: {PDF.Project_status}")
        p.drawString(100, y - 40, f"Agency: {PDF.implementing_agency}")
        y -= 60
 
    p.showPage()
    p.save()
 
    buffer.seek(0)
    return buffer



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
    profiles=User.objects.get(id= pk)
    form= MyUserCreationForm()
    if request.method=='POST':
        form= MyUserCreationForm(request.POST,request.FILES,instance=profiles)
        if form.is_valid():
            form.save()
            return redirect('index')
    context={'form':form}
    return render(request,'profile.html', context)

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
             'agencies':agencies
             }
    return render(request,'index.html',context)

def sidebar(request):
    return render(request,'sidebar.html')

def header(request):
    return render(request,'header.html')

def jobApplication(request):
    return render(request,'job.html')

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


def BudgetAnalysis(request):
    return render(request,'budgetanalysis.html')

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
    
def teams(request):
    return render(request,'team.html')

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
    projects= Project.objects.filter(project_status='ongoing')
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
        form=ProjectTypeForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect(request,'completed')
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