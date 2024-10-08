
from django.urls import path
from .views import  PdfFile, generate_pdf, render_pdf_view, sidebar,project_overview,charts,deleteprofile,ptypes,divisionform,updateprofile,Division_details,UpcomingStatuses,CompletedStatuses,OngoingStatuses,project,AboutUs,deleteProject,updateProject,teams,testimonials,ongoing,upcoming,completed,BudgetAnalysis,PerfomanceMetrix,CreateProject,feedback, Home,header, ContactusPage,welcomingpage,loginpage,logoutuser,registrationpage,index
urlpatterns = [
    path('login/', loginpage, name="login"),
    path('generate_pdf/', generate_pdf, name='generate_pdf'),
    path('render_pdf/', render_pdf_view, name='render_pdf'),
    path('chart/', charts, name="chart"),
    path('profile/<str:pk>/', updateprofile, name="profile"),
    path('deleteprofile/<str:pk>/', deleteprofile, name="deleteprofile"),
    path('logout', logoutuser, name="logout"),
    path('About/', AboutUs, name="AboutUs"),
    path('home/', Home, name="home"),
    path('contactus/', ContactusPage, name="contactus"),
    path('', welcomingpage, name="welcoming_page"),
    path('register/', registrationpage, name="registrationpage"),
    path('index', index, name="index"),
    path('sidebar/', sidebar, name="sidebar"),
    path('header/', header, name="header"), 
    path('feedback/', feedback, name="feedback"),
    path('createproject/', CreateProject, name="createproject"),
    path('updateproject/<str:pk>/', updateProject, name="update"),
    path('budgetAnalysis/', BudgetAnalysis, name="BudgetAnalysis"),
    path('metrix/', PerfomanceMetrix, name="metrix"),
    path('ongoing/', ongoing, name="ongoing"),
    path('upcoming/', upcoming, name="upcoming"),
    path('completed/', completed, name="completed"),
    path('team/', teams, name="team"),
    path('testimonials/', testimonials, name="testimonials"),
    path('projectoverview/', project_overview, name="projectoverview"),
    path('deleteProject/<str:pk>/', deleteProject, name="delete"),
    path('project/', project, name="project"),
    path('statuses/<str:pk>/', OngoingStatuses, name="Ongoingstatuses"),
    path('division/', divisionform, name="division"),
    path('division_details/', Division_details, name="division_details"),
    path('CompletedStatuses/<str:pk>/', CompletedStatuses, name="CompletedStatuses"),
    path('Upcomingstatus/<str:pk>/', UpcomingStatuses, name="Upcomingstatus"),
    path('ptypes/', ptypes, name="ptypes"),
    path('PdfFile/', PdfFile, name="PdfFile"),


    
]
