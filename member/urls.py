from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from .views import  Division_view, Participation_details, ProjectStageCreate, ProjectStageDelete, ProjectStageUpdate, ProjectTypes, Testimonials, add_budget, add_team, add_testimonial, adminview, announcements, apply_tender, budget_dashboard, check_project_status, citizen_evidence, citizen_portal, comment, contractor_dashboard, dashboard, delayedstatus, delete_division, delete_testimonial, edit_division, feedback_details, notifications, people, projectstage, projectstage_details, regional_analysis, reportedissuesdetails,delayed, AuditLogs, add_audit, add_comment, add_tender, audit_details, comment_list, delete_tender, export_report_pdf, generate_report, issue_detail, issue_list, notification_create,media_list, media_upload, notification_list, milestone_list, milestone_create, milestone_update, milestone_delete, project_detail, add_report_issue, send_sms_report,sidebar,project_overview,charts,deleteprofile,ptypes,divisionform, sms_dashboard, submit_evidence, submit_issue, submit_stage_report, teams_details, tender_detail, tender_list, testimonial_details, update_team, update_tender, update_testimonial, updateprofile,Division_details,UpcomingStatuses,CompletedStatuses,OngoingStatuses,project,AboutUs,deleteProject,updateProject,teams,ongoing,upcoming,completed,BudgetAnalysis,PerfomanceMetrix,CreateProject,feedback, Home,header, ContactusPage, upload_progress_report,welcomingpage,loginpage,logoutuser,registrationpage,index
urlpatterns = [
    path('reports/', generate_report, name='generate_report'),
    path('reports/export-pdf/', export_report_pdf, name='export_report_pdf'),
    
    path('login/', loginpage, name="login"),
    path('chart/', charts, name="chart"),

    path('profile/<int:pk>/', updateprofile, name="profile"),
    path('deleteprofile/<str:pk>/', deleteprofile, name="deleteprofile"),

    path('user',people,name='user'),
    
    path('team',teams,name='team'),
    path('add_team',add_team,name='add_team'),
    path('update_team/<str:pk>/', update_team, name='update_team'),
    path('teams_details/<str:pk>/', teams_details, name='teams_details'),

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


    path('dashboard/', dashboard, name="dashboard"),


    path('adminview/', adminview, name="adminview"),
    path('feedback_details/<str:pk>/', feedback_details, name="feedback_details"),
    path('comment/<str:pk>/', comment, name="comment"),
    path('reportedissuesdetails/<str:pk>/', reportedissuesdetails, name="reportedissuesdetails"),

    path('participation_details/<str:pk>/', Participation_details, name="participation_details"),

    path('team/', teams, name="team"),
    path('add_team/', add_team, name="add_team"),
    
    path('testimonials/', Testimonials, name="testimonials"),
    path('add_testimonial/', add_testimonial, name="add_testimonial"),
    path('testimonial_details/<str:pk>/', testimonial_details, name="testimonial_details"),
    path('update_testimonial/<str:pk>/', update_testimonial, name="update_testimonial"),
    path('delete_testimonial/<str:pk>/', delete_testimonial, name="delete_testimonial"),


    path('projectoverview/', project_overview, name="projectoverview"),
    path('deleteProject/<str:pk>/', deleteProject, name="delete"),
    path('project/', project, name="project"),

    path('ongoing/', ongoing, name="ongoing"),
    path('delayed/', delayed, name="delayed"),
    path('delayedstatus/<str:pk>/', delayedstatus, name="delayedstatus"),
    path('upcoming/', upcoming, name="upcoming"),
    path('completed/', completed, name="completed"),
    path('project_details/<str:pk>/', project_detail, name="project_details"),
    path('statuses/<str:pk>/', OngoingStatuses, name="Ongoingstatuses"),
    path('CompletedStatuses/<str:pk>/', CompletedStatuses, name="CompletedStatuses"),
    path('Upcomingstatus/<str:pk>/', UpcomingStatuses, name="Upcomingstatus"),


    path('division/', divisionform, name="division"),
    path('division_details/', Division_details, name="division_details"),
    path('division_details/<str:pk>/', Division_view, name="division_view"),
    path('edit_division/<str:pk>/', edit_division, name="edit_division"),
    path('delete_division/<str:pk>/', delete_division, name="delete_division"),

    

    path('ptypes/', ptypes, name="ptypes"),
    path('ProjectTypes/', ProjectTypes, name="ProjectTypes"),

    path('milestones/', milestone_list, name='milestone_list'),
    path('milestones/new/', milestone_create, name='milestone_create'),
    path('milestones/edit/<int:pk>/', milestone_update, name='milestone_update'),
    path('milestones/delete/<int:pk>/', milestone_delete, name='milestone_delete'),

    path('notifications/', notification_list, name='notification_list'),
    path('notification_create/', notification_create, name='notification_create'),
    path('notifications/', notifications,name='notifications'),


    path('media/', media_list, name='media_list'),
    path('media/upload/', media_upload, name='media_upload'),
     
    
    path('project/<int:project_id>/upload-progress/', upload_progress_report, name='upload_progress_report'),
    path('add_report_issue/', add_report_issue, name='add_report_issue'),
    path('issues/', issue_list, name='issue_list'),
    path('issues/<int:issue_id>/', issue_detail, name='issue_detail'),
    
    path('tenders/', tender_list, name='tender_list'),
    path('apply_tender/<str:pk>/', apply_tender,name='apply_tender'),
    path('tenders/<int:tender_id>/', tender_detail, name='tender_detail'),
    path('tenders/add/', add_tender, name='add_tender'),
    path('tenders/update/<int:tender_id>/', update_tender, name='update_tender'),
    path('tenders/delete/<int:tender_id>/', delete_tender, name='delete_tender'),

   
    path('add-comment/<str:pk>/', add_comment, name='add_comment'),
    path('comments/', comment_list, name='comment_list'),

    path('AuditLog/', AuditLogs, name='AuditLog'),
    path('add_audit/', add_audit, name='add_audit'),
    path('audit_details/<str:pk>/', audit_details, name='audit_details'),


    path('stages/', projectstage, name='projectstage_list'),
    path('stages/<int:pk>/', projectstage_details, name='projectstage_detail'),
    path('new/', ProjectStageCreate, name='projectstage_create'),
    path('updatestages/<int:pk>/', ProjectStageUpdate, name='projectstage_update'),
    path('stages/<int:pk>//',ProjectStageDelete , name='projectstage_delete'),
    
    
    path('sms/', sms_dashboard, name='sms_dashboard'),
    path('send-sms/', send_sms_report, name='send_sms_report'),
    path('check-project/', check_project_status, name='check_project_status'),
    
    path('regional-comparison/', regional_analysis, name='regional_comparison'),
    
    path('announcements/', announcements, name='announcements'),
    
    path('citizen/', citizen_portal, name='citizen_portal'),
    path('submit/', submit_issue, name='submit_issue'),
    
    path('contractor_performance/', contractor_dashboard, name='contractor_performance'),
    path('submit-stage-report/', submit_stage_report, name='submit_stage_report'),
    
    path('citizen_evidence/', citizen_evidence, name='citizen_evidence'),
    path('citizen/evidence/submit/', submit_evidence, name='submit_evidence'),
    
    path('budget/', budget_dashboard, name='budget_dashboard'),
    path('budget/add/', add_budget, name='add_budget'),
    






]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
