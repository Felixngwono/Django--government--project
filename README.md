# Government Development Project Tracking System

A Django-based platform for tracking government development projects across their entire lifecycle, with a focus on transparency and public accountability.

## Overview

The system's foundation is **project registration**. Once a project is registered, it becomes visible to the public and contractors/eligible organizations can apply for it through the tendering module. From that point on, the platform tracks the project's **status, progress, and full change history**, so a citizen can search for any project months later and immediately see its current state and how it got there.

## Core Features

### 1. Project Registration
- Projects are registered with a category, district/region, timeline (start/end dates), budget, project manager, and assigned contractors.
- Each project carries a reference code for easy lookup.

### 2. Tendering & Applications
- Registered projects can be published as tenders.
- Contractors (or other eligible individuals/organizations) can apply, submit cover letters and documents, and track their bids.
- Officials evaluate bids and award tenders (award restricted to official/admin roles).

### 3. Status Management & Tracking
- Statuses: **Draft → Upcoming → Ongoing → Delayed / Suspended / Stalled → Completed or Cancelled**.
- A forward-only transition engine (`member/workflow.py`) derives status automatically from real signals — stages, progress updates, milestones, and timeline dates — so statuses move with time even when nobody saves a report (`member/status_sweep.py`, wired into middleware and a management command).
- Every transition is recorded in **ProjectStatusHistory** and the immutable **AuditLog**, giving a complete, ordered history of how each project reached its current state.
- Automatic transitions never override terminal states (completed/cancelled); only authorized manual action can step back.

### 4. Public Transparency
- Citizens can **search and filter** the project list and view a full tracking page per project: current status, progress percentage, milestones, stage reports, budget, and the complete status-change timeline.
- Progress reports with photo evidence, media galleries, documents, and PDFs are attached to projects.
- Citizens can report issues, submit evidence, comment, and participate in discussions and public participation events.

### 5. Supporting Modules
- Budget tracking with revisions and expenses; AI insights and an AI chatbot for querying project data; notifications, SMS alerts, deadline alerts, regional analytics, and role-based access (citizen, official, contractor, engineer, auditor, etc.).

## Project Structure

| Path | Purpose |
|---|---|
| `member/` | Main app: models, views, forms, status engine (`workflow.py`, `status_sweep.py`), middleware, signals, tests |
| `ai/` | AI services: insights, vector search, REST API viewsets |
| `FelloMarley/` | Django project settings and root URL configuration |
| `templates/` | HTML templates (public pages, tender, tracking, citizen, finance, etc.) |
| `static/` | CSS, JS, images |
| `media/` | Uploaded evidence, tenders, reports, project media |

## Getting Started

```powershell
python -m venv myvenv
.\myvenv\Scripts\Activate.ps1
pip install -r requirement.txt
python manage.py migrate
python manage.py runserver
```

## Running Tests

```powershell
python manage.py test member
```

The test suite covers the status engine (`tests_status_engine.py`): forward-only transitions, completion signals, the time-driven sweep, stage/milestone rollups, and deadline alerts — plus core flows like tender bidding and citizen evidence submission.
