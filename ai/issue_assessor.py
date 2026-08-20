# services/ai/issue_assessor.py

import json
from django.conf import settings
from member.ai_services import triage_issue
from member.models import ReportIssue, AIIssueAssessment
from ai.services import get_openai_client

SYSTEM_PROMPT = """
You are GovTracker's issue triage assistant.
Given a citizen-reported issue on a government project, you must:
1. Classify the category (infrastructure, financial, safety, corruption, delay, quality, other)
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
    assessment = None
    client = get_openai_client()

    if client:
        try:
            project_title = issue.project.project_title if issue.project else "Unspecified Project"
            prompt = f"""Reported Issue:
Title: {issue.title}
Description: {issue.issue_description}
Severity: {getattr(issue, 'severity', 'Unknown')}
Project: {project_title}
"""
            model = getattr(settings, "OPENAI_MODEL", "gpt-4o-mini")
            response = client.chat.completions.create(
                model=model,
                messages=[
                    {"role": "system", "content": SYSTEM_PROMPT},
                    {"role": "user", "content": prompt},
                ],
                temperature=0.2,
                max_tokens=400,
            )
            content = response.choices[0].message.content.strip()
            if content.startswith("```"):
                content = content.split("\n", 1)[-1].rsplit("```", 1)[0].strip()
            data = json.loads(content)
            assessment = {
                "category": data.get("category", "other"),
                "urgency": data.get("urgency", "moderate"),
                "confidence": int(data.get("confidence", 80)),
                "summary": data.get("summary", f"Issue reported for {project_title}."),
                "recommended_action": data.get("recommended_action", "Investigate and resolve reported issue."),
                "model": getattr(response, "model", model),
                "provider": "openai",
            }
        except Exception:
            assessment = None

    if not assessment:
        assessment = triage_issue(issue)

    return AIIssueAssessment.objects.create(
        issue=issue,
        **assessment,
    )

