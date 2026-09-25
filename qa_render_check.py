# File: qa_render_check.py
"""One-off QA: render the restyled pages as an authenticated user and report status + key content."""
import django, os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'FelloMarley.settings')
django.setup()

from django.test import Client
from member.models import User, ReportIssue, Project

c = Client(SERVER_NAME='localhost')  # dev settings don't allow 'testserver'
u, _ = User.objects.get_or_create(username='qa_style_check', defaults={'is_superuser': True, 'is_staff': True, 'role': 'admin'})
u.is_superuser = True; u.is_staff = True; u.save()
c.force_login(u)

urls = ['/progress-report/', '/issues/', '/add_report_issue/', '/ongoing/', '/delayed/', '/completed/']
issue = ReportIssue.objects.first()
if issue:
    urls.append(f'/issues/{issue.id}/')
    urls.append(f'/reportedissuesdetails/{issue.id}/')
proj = Project.objects.first()
if proj:
    urls.append(f'/project_details/{proj.id}/')

for url in urls:
    r = c.get(url, follow=True)
    ok = r.status_code == 200
    marker = ('Reported Issues' if 'issues' in url and 'add' not in url else
              'Report an Issue' if 'add_report_issue' in url else
              'Project Progress Report' if 'progress-report' in url else
              'Issue Details' if f'/issues/' in url and issue and str(issue.id) in url else '')
    print(f"{r.status_code}  {'OK ' if ok else 'BAD'}  {url}  has_marker={bool(marker) and marker in r.content.decode(errors='ignore')}  len={len(r.content)}")
