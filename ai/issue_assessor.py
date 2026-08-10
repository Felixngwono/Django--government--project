# services/ai/issue_assessor.py

from member.models import ReportIssue, AIIssueAssessment

SYSTEM_PROMPT = """
You are GovTracker's issue triage assistant.
Given a citizen-reported issue on a government project, you must:
1. Classify the category (financial, safety, corruption, delay, quality, other)
2. Rate urgency: low / moderate / high / critical
3. Estimate confidence 0-100
4. Write a 2-sentence summary
5. Recommend a specific action for government staff.

Respond ONLY in valid JSON:
{
  "category": "...",
  "urgency": "...",
  "confidence": 85,
  "summary": "...",
  "recommended_action": "..."
}
"""

def assess_issue(issue: ReportIssue) -> AIIssueAssessment:
    prompt = f"""
    Project: {issue.project.project_title}
    Issue Title: {issue.title}
    Description: {issue.issue_description}
    Severity (user-reported): {issue.severity}
    """

    return AIIssueAssessment.objects.create(
        issue=issue,
        category='other',
        urgency='moderate',
        confidence=0,
        summary='AI assessment is unavailable because no AI service is configured.',
        recommended_action='Review the issue manually.',
        model='offline',
        provider='offline',
    )
