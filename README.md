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
- Public self-registration creates citizen accounts only. Authorized government staff can create contractor, engineer, architect, surveyor, and planner accounts with a confirmed initial password that they give directly to the professional. Admins and government officials can manage user profiles, suspend or restore sign-in access, and delete accounts; account-management actions are audit logged and superuser accounts are protected. Assigned project-delivery professionals can submit work reports and manage project stages, milestones, and project-scoped expenses, while government review and approval actions remain staff-only.

### 6. Governance and Field Accountability
- Project records can use a managed government-agency registry and geographic coordinates. Public tracking pages show project and inspection points on an OpenStreetMap map when coordinates are available.
- Each project preserves its initial approved budget and schedule as a baseline. Budget, schedule, and awarded contract-value changes are recorded with a reason and supporting document, and project change proposals require authorized review before taking effect.
- Authorized staff can record independent site inspections with findings, outcomes, corrective-action deadlines, coordinates, and evidence. Inspections appear in the project tracking history.
- Citizen issues can be assigned, responded to, and tracked against configurable severity-based response targets. Internal staff notes are hidden from the reporting citizen.
- Contractor payment requests retain the existing review workflow. Authorized officials can send an approved request to the contractor's registered phone number using Safaricom Daraja B2C, or record an external transfer. M-Pesa payments remain pending until the signed-token callback reports success; only then are they marked paid.
- The application remains English-first; the new workflows use labeled controls and semantic headings, while production/deployment settings are documented separately from these application features.

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

### Safaricom Daraja contractor payouts

Payouts use Daraja's **B2C** API. Add the values from the Safaricom Daraja portal to the deployment environment (see `.env.example` for the variable names). Keep the consumer secret, initiator security credential, and callback token private. The application defaults to `MPESA_ENVIRONMENT=sandbox`; use Safaricom sandbox credentials and a publicly reachable HTTPS callback host for testing before enabling production.

Set `MPESA_CALLBACK_BASE_URL` to the public site origin and `MPESA_CALLBACK_TOKEN` to a random secret of at least 32 characters. Daraja's result and queue-timeout URLs are generated under `/contractor/mpesa/` using that token. Configure the B2C initiator, security credential, shortcode, and command according to Safaricom's account setup. Production payouts require a live shortcode with B2C enabled.

An official approves a contractor invoice first, then explicitly selects **Send via M-Pesa** in the review queue. The contractor profile must have a valid Kenyan mobile number, and the payment must be a whole number of Kenyan shillings. A pending transfer cannot be submitted again; if the request times out, reconcile it in Daraja before retrying. Do not manually mark an in-flight M-Pesa transfer as paid.

### Customer collections (STK Push)

Signed-in users can open `/payments/mpesa/`, enter an amount, phone number and purpose, then authorize the STK prompt on their phone. Collections are tracked separately from B2C contractor payouts at `/payments/mpesa/history/`; only a callback with a receipt marks a collection successful. Configure `MPESA_STK_SHORTCODE` and `MPESA_STK_PASSKEY` with the Lipa Na M-Pesa Online credentials from Daraja. Set `MPESA_CALLBACK_BASE_URL` to the public HTTPS site and expose `/payments/mpesa/callback/<MPESA_CALLBACK_TOKEN>/` to Safaricom. Apply database migrations before using the checkout.

```powershell
python -m venv myvenv
.\myvenv\Scripts\Activate.ps1
pip install -r requirement.txt
python manage.py migrate
python manage.py runserver
```

### Africa's Talking tender award SMS

When an official awards a tender, GovTracker sends the winning applicant an SMS using the phone number on their application (then their account or contractor profile as a fallback). Configure `AFRICASTALKING_USERNAME`, `AFRICASTALKING_API_KEY`, and `AFRICASTALKING_ENVIRONMENT` in the deployment environment. Start with `sandbox`; the Africa's Talking sandbox only simulates delivery. Production SMS needs a funded/active account and any required sender ID approval. SMS delivery failure is logged and does not roll back the award.

## Running Tests

```powershell
python manage.py test member
```

The test suite covers the status engine (`tests_status_engine.py`): forward-only transitions, completion signals, the time-driven sweep, stage/milestone rollups, and deadline alerts — plus core flows like tender bidding and citizen evidence submission.

The tracking governance workflow tests are in `member/tests_tracking_features.py`.
# GovTracker
