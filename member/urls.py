from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from .views import   ProjectStageListView, ProjectStageDetailView,  ProjectStageCreateView, ProjectStageUpdateView, ProjectStageDeleteView,AuditLogs, add_audit, add_comment, add_project_location, add_tender, audit_details, comment_list, delete_tender, export_report_pdf, generate_report, issue_detail, issue_list, notification_create,media_list, media_upload, notification_list, milestone_list, milestone_create, milestone_update, milestone_delete, project_detail, project_location_detail, project_location_list, add_report_issue,sidebar,project_overview,charts,deleteprofile,ptypes,divisionform, tender_detail, tender_list, update_tender,updateprofile,Division_details,UpcomingStatuses,CompletedStatuses,OngoingStatuses,project,AboutUs,deleteProject,updateProject,teams,testimonials,ongoing,upcoming,completed,BudgetAnalysis,PerfomanceMetrix,CreateProject,feedback, Home,header, ContactusPage, upload_progress_report, upload_tender,welcomingpage,loginpage,logoutuser,registrationpage,index
urlpatterns = [
    path('reports/', generate_report, name='generate_report'),
    path('reports/export-pdf/', export_report_pdf, name='export_report_pdf'),
    
    path('login/', loginpage, name="login"),
    path('chart/', charts, name="chart"),

    path('profile/<int:pk>/', updateprofile, name="profile"),
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

    path('milestones/', milestone_list, name='milestone_list'),
    path('milestones/new/', milestone_create, name='milestone_create'),
    path('milestones/edit/<int:pk>/', milestone_update, name='milestone_update'),
    path('milestones/delete/<int:pk>/', milestone_delete, name='milestone_delete'),

    path('notifications/', notification_list, name='notification_list'),
    path('notification_create/', notification_create, name='notification_create'),


    path('media/', media_list, name='media_list'),
    path('media/upload/', media_upload, name='media_upload'),
    

    path('project/<int:project_id>/', project_detail, name='project_detail'),

    
    path('project/<int:project_id>/upload-progress/', upload_progress_report, name='upload_progress_report'),
    path('add_report_issue/', add_report_issue, name='add_report_issue'),
    path('issues/', issue_list, name='issue_list'),
    path('issues/<int:issue_id>/', issue_detail, name='issue_detail'),
    
    path('tenders/', tender_list, name='tender_list'),
    path('tenders/<int:tender_id>/', tender_detail, name='tender_detail'),
    path('tenders/add/', add_tender, name='add_tender'),
    path('tenders/update/<int:tender_id>/', update_tender, name='update_tender'),
    path('tenders/delete/<int:tender_id>/', delete_tender, name='delete_tender'),

    path('add-location/', add_project_location, name='add_project_location'),
    path('locations/', project_location_list, name='project_location_list'),
    path('locations/<int:location_id>/', project_location_detail, name='project_location_detail'),

    path('add-comment/', add_comment, name='add_comment'),
    path('comments/', comment_list, name='comment_list'),

    path('AuditLog/', AuditLogs, name='AuditLog'),
    path('add_audit/', add_audit, name='add_audit'),
    path('audit_details/<str:pk>/', audit_details, name='audit_details'),


    path('stages/', ProjectStageListView.as_view(), name='projectstage_list'),
    path('stages/<int:pk>/', ProjectStageDetailView.as_view(), name='projectstage_detail'),
    path('stages/new/', ProjectStageCreateView.as_view(), name='projectstage_create'),
    path('stages/<int:pk>/edit/', ProjectStageUpdateView.as_view(), name='projectstage_update'),
    path('stages/<int:pk>/delete/', ProjectStageDeleteView.as_view(), name='projectstage_delete'),





]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
