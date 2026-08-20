from django.urls import path

from .views import (
    ai_assistant,
    ai_chatbot,
    ai_chatbot_api,
    ai_insights,
    ai_generate_report,
    ai_issue_dashboard,
    ai_report_page,
    ai_review_assessment,
    ai_triage_issue,
)

urlpatterns = [
    path("assistant/", ai_assistant, name="ai_assistant"),
    path("chatbot/", ai_chatbot, name="ai_chatbot"),
    path("chatbot/api/", ai_chatbot_api, name="ai_chatbot_api"),
    path("insights/", ai_insights, name="ai_insights"),
    path("reports/", ai_report_page, name="ai_report_page"),
    path("reports/generate/<int:project_id>/", ai_generate_report, name="ai_generate_report"),
    path("issue-dashboard/", ai_issue_dashboard, name="ai_issue_dashboard"),
    path("triage/<int:issue_id>/", ai_triage_issue, name="ai_triage_issue"),
    path("review-assessment/<int:assessment_id>/", ai_review_assessment, name="ai_review_assessment"),
]
