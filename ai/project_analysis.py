from decimal import Decimal

from django.conf import settings
from django.db import transaction
from django.db.models import Avg
from datetime import timedelta

from django.utils import timezone

from member.models import AIProjectAnalysis, Contractor, Project, Tender, TenderApplication


def _progress_value(project):
    raw = project.progress
    if raw is None:
        return None
    try:
        return max(0, min(100, float(str(raw).replace('%', '').strip())))
    except (TypeError, ValueError):
        return None


def _budget_metrics(project):
    budget = Decimal(project.project_Budgeting or 0)
    spent = Decimal(project.amount_spent or 0)
    utilization = round(float(spent / budget * 100), 1) if budget else 0.0
    return {
        'budget': float(budget),
        'spent': float(spent),
        'remaining': float(budget - spent),
        'utilization': utilization,
    }


def _contractor_metrics(project):
    contractor_name = (project.project_contractor or '').strip()
    if not contractor_name:
        return {'name': 'Unassigned', 'rating': None, 'projects': 0, 'delayed_projects': 0}
    contractor = Contractor.objects.filter(company__iexact=contractor_name).first()
    if contractor is None:
        contractor = Contractor.objects.filter(name__iexact=contractor_name).first()
    if contractor is None:
        return {'name': contractor_name, 'rating': None, 'projects': 0, 'delayed_projects': 0}
    ratings = contractor.contractorrating_set.all()
    rating = ratings.aggregate(
        quality=Avg('quality_score'), speed=Avg('speed_score'), compliance=Avg('compliance_score')
    )
    average_rating = round(sum(float(rating[key] or 0) for key in ('quality', 'speed', 'compliance')) / 3, 1) if ratings.exists() else None
    projects = contractor.projects.all()
    return {
        'name': contractor.company or contractor.name,
        'rating': average_rating,
        'projects': projects.count(),
        'delayed_projects': projects.filter(project_status__in={'delayed', 'stalled', 'suspended'}).count(),
    }


def _predicted_completion(project, progress, schedule_delay_months):
    if (project.project_status or '').lower() == 'completed':
        return project.actual_end_date or project.end_date
    if progress is None or progress <= 0 or not project.start_date:
        return None
    elapsed_days = max(1, (timezone.localdate() - project.start_date).days)
    projected_total_days = max(elapsed_days, round(elapsed_days * 100 / progress))
    predicted = project.start_date + timedelta(days=projected_total_days)
    if schedule_delay_months:
        predicted += timedelta(days=schedule_delay_months * 30)
    return predicted


def _expense_metrics(project):
    expenses = list(project.expenses.exclude(amount__isnull=True).order_by('date'))
    total = sum(Decimal(expense.amount or 0) for expense in expenses)
    recent = expenses[-3:]
    previous = expenses[:-3]
    recent_total = sum(Decimal(expense.amount or 0) for expense in recent)
    previous_average = sum(Decimal(expense.amount or 0) for expense in previous) / len(previous) if previous else Decimal('0')
    increase = round(float((recent_total - previous_average) / previous_average * 100), 1) if previous_average else 0.0
    after_deadline = sum(1 for expense in expenses if project.end_date and expense.date and expense.date > project.end_date)
    return {'count': len(expenses), 'total': float(total), 'recent_total': float(recent_total), 'recent_increase': increase, 'after_deadline': after_deadline}


def _procurement_metrics(project):
    tenders = list(project.tenders.prefetch_related('applications').all())
    bids = [bid for tender in tenders for bid in tender.applications.all() if bid.bid_amount is not None]
    prices = [Decimal(bid.bid_amount) for bid in bids]
    average_bid = float(sum(prices) / len(prices)) if prices else None
    bid_variances = [round(abs(float(bid.bid_amount) - average_bid) / average_bid * 100, 1) for bid in bids] if average_bid else []
    same_contractor_awards = 0
    for tender in Tender.objects.filter(awarded_to__isnull=False).exclude(project=project):
        if project.project_contractor and tender.awarded_to and tender.awarded_to.company and tender.awarded_to.company.lower() == project.project_contractor.lower():
            same_contractor_awards += 1
    short_period_tenders = sum(1 for tender in tenders if tender.opening_date and tender.closing_date and (tender.closing_date - tender.opening_date).days < 7)
    return {
        'tenders': len(tenders), 'bids': len(bids), 'average_bid': average_bid,
        'max_bid_variance': max(bid_variances, default=0),
        'same_contractor_awards': same_contractor_awards,
        'short_period_tenders': short_period_tenders,
    }


def _duplicate_candidates(project):
    candidates = []
    title = (project.project_title or '').lower().split()
    title_words = {word for word in title if len(word) > 3}
    if not title_words or not project.project_location:
        return candidates
    for peer in Project.objects.filter(is_public=True, project_location__iexact=project.project_location).exclude(pk=project.pk)[:30]:
        peer_words = {word for word in (peer.project_title or '').lower().split() if len(word) > 3}
        overlap = len(title_words & peer_words) / max(1, len(title_words | peer_words))
        budget_match = bool(project.project_Budgeting and peer.project_Budgeting and abs(float(project.project_Budgeting - peer.project_Budgeting)) / float(project.project_Budgeting) < .2)
        similarity = round(min(99, overlap * 75 + (24 if budget_match else 0)), 1)
        if similarity >= 60:
            candidates.append({'project_id': peer.id, 'project': peer.project_title, 'similarity': similarity})
    return candidates


def _analysis_payloads(project):
    progress = _progress_value(project)
    budget = _budget_metrics(project)
    contractor = _contractor_metrics(project)
    expenses = _expense_metrics(project)
    procurement = _procurement_metrics(project)
    duplicate_candidates = _duplicate_candidates(project)
    budget_revisions = sum(budget.revisions.count() for budget in project.budget.all())
    milestones = project.milestones.all()
    milestone_total = milestones.count()
    milestone_done = milestones.filter(status='completed').count()
    open_issues = project.issues.filter(resolved=False).count()
    stage_total = project.stages.count()
    stage_progress = list(project.stages.values_list('progress_percentage', flat=True))
    average_stage_progress = round(sum(float(value or 0) for value in stage_progress) / len(stage_progress), 1) if stage_progress else None
    effective_progress = progress if progress is not None else average_stage_progress
    status = (project.project_status or 'unknown').lower()
    risk_score = 20
    risk_reasons = []
    anomaly_indicators = []
    data_integrity_flags = []
    procurement_indicators = []
    schedule_delay_months = 0
    if project.end_date and project.end_date < timezone.localdate() and status not in {'completed', 'cancelled'}:
        schedule_delay_months = max(1, round((timezone.localdate() - project.end_date).days / 30))
        risk_score += min(25, schedule_delay_months * 5)
        risk_reasons.append(f'Project is approximately {schedule_delay_months} month(s) past its planned end date.')
    predicted_completion = _predicted_completion(project, effective_progress, schedule_delay_months)
    if status in {'delayed', 'stalled', 'suspended'}:
        risk_score += 35
        risk_reasons.append(f'Project status is {status}.')
    if open_issues:
        risk_score += min(30, open_issues * 10)
        risk_reasons.append(f'{open_issues} unresolved issue(s) require attention.')
    if budget['utilization'] > 90 and (effective_progress or 0) < 80:
        risk_score += 20
        risk_reasons.append('Spending is high relative to recorded progress.')
        anomaly_indicators.append('Expenditure substantially exceeds physical progress.')
    elif budget['utilization'] > 75 and (effective_progress or 0) < 50:
        risk_score += 15
        risk_reasons.append('Financial completion is materially ahead of physical completion.')
        anomaly_indicators.append('Financial completion is materially ahead of physical completion.')
    if contractor['delayed_projects'] >= 2:
        risk_score += 10
        risk_reasons.append(f"Assigned contractor has {contractor['delayed_projects']} other delayed projects.")
        anomaly_indicators.append('Contractor history contains repeated delayed projects.')
    if contractor['rating'] is not None and contractor['rating'] < 50:
        risk_score += 10
        risk_reasons.append('Recorded contractor performance rating is below 50%.')
    if milestone_total and milestones.filter(status='missed').exists():
        risk_score += 10
        risk_reasons.append('One or more milestones are marked missed.')
    if open_issues >= 3:
        anomaly_indicators.append(f'{open_issues} unresolved citizen or oversight complaints are linked to the project.')
    if effective_progress is not None and effective_progress >= 80 and open_issues >= 3:
        anomaly_indicators.append('Reported progress is high while citizen complaint volume remains high; physical verification is recommended.')
    if budget_revisions >= 2:
        anomaly_indicators.append(f'{budget_revisions} budget revision(s) require review for repeated supplementary funding.')
    if expenses['after_deadline']:
        anomaly_indicators.append(f"{expenses['after_deadline']} expense record(s) were recorded after the planned end date.")
    peer_budgets = []
    if project.category_id:
        peer_budgets = list(Project.objects.filter(is_public=True, category_id=project.category_id).exclude(pk=project.pk).exclude(project_Budgeting__isnull=True).values_list('project_Budgeting', flat=True)[:20])
    if peer_budgets and budget['budget'] > float(sum(peer_budgets) / len(peer_budgets)) * 1.8:
        anomaly_indicators.append('Allocated budget is substantially above comparable projects in the same category.')
    if expenses['recent_increase'] >= 50:
        anomaly_indicators.append(f"Recorded expenditure increased {expenses['recent_increase']:.0f}% in the latest expense entries.")
    if procurement['max_bid_variance'] >= 40:
        procurement_indicators.append('A bid price is materially different from the tender peer average.')
    if procurement['same_contractor_awards'] >= 3:
        procurement_indicators.append('The same contractor has multiple other awarded projects.')
    if procurement['short_period_tenders']:
        procurement_indicators.append('A tender used a procurement window shorter than seven days.')
    if status == 'completed' and ((effective_progress is not None and effective_progress < 100) or milestone_done < milestone_total or project.amount_spent is not None and project.project_Budgeting and project.amount_spent < project.project_Budgeting):
        data_integrity_flags.append('Project is marked completed while progress, milestones, or financial records appear incomplete.')
    if duplicate_candidates:
        data_integrity_flags.append('A similar project exists at the same recorded location and may require duplicate-record review.')
    if project.end_date and project.start_date and project.end_date < project.start_date:
        data_integrity_flags.append('Project end date precedes its start date.')
    risk_score = min(100, risk_score)
    risk_level = 'high' if risk_score >= 70 else 'medium' if risk_score >= 40 else 'low'
    progress_gap = max(0, budget['utilization'] - float(effective_progress or 0))
    anomaly_score = min(100, 20 + len(anomaly_indicators) * 20 + min(40, round(progress_gap)))
    anomaly_level = 'critical' if anomaly_score >= 80 else 'elevated' if anomaly_score >= 50 else 'normal'
    financial_health = max(0, min(100, round(100 - min(100, max(0, budget['utilization'] - float(effective_progress or 0))))))
    schedule_health = max(0, 100 - min(100, schedule_delay_months * 12 + (25 if status in {'delayed', 'stalled', 'suspended'} else 0)))
    contractor_score = None
    if contractor['rating'] is not None:
        contractor_score = max(0, min(100, round(contractor['rating'] - contractor['delayed_projects'] * 8)))
    feedback_values = list(project.feedback.exclude(rating__isnull=True).values_list('rating', flat=True))
    citizen_satisfaction = round(sum(feedback_values) / len(feedback_values) * 20, 1) if feedback_values else None
    early_warnings = []
    if anomaly_score >= 50:
        early_warnings.append('Potential financial anomaly requires evidence review before further disbursement.')
    if schedule_delay_months or status in {'delayed', 'stalled', 'suspended'}:
        early_warnings.append('Project is at risk of missing its planned completion date.')
    if milestone_total and milestones.filter(status='missed').exists():
        early_warnings.append('One or more milestones are overdue or marked missed.')
    if contractor['delayed_projects'] >= 2:
        early_warnings.append('Assigned contractor has a repeated delay pattern across linked projects.')
    if open_issues >= 3:
        early_warnings.append('Complaint volume is high enough to require an accountable response.')
    if data_integrity_flags:
        early_warnings.append('Project records contain a data-consistency signal requiring verification.')

    completion_confidence = 45 if effective_progress is None else min(95, max(45, int(effective_progress + (20 if status == 'completed' else 0))))
    if status == 'completed':
        completion_summary = 'Project is marked completed in the project register.'
    elif effective_progress is None:
        completion_summary = 'Completion cannot be estimated until progress or stage updates are recorded.'
    else:
        completion_summary = f'Recorded delivery progress is {effective_progress:.0f}%; continue milestone updates to refine the forecast.'

    budget_summary = f"KES {budget['spent']:,.2f} spent of KES {budget['budget']:,.2f} allocated ({budget['utilization']:.1f}% utilized)."
    performance_summary = f'{milestone_done} of {milestone_total} milestones complete across {stage_total} project stage(s).'
    sentiment_summary = 'Citizen sentiment signal is limited until public feedback and issue reports are linked to this project.'
    if open_issues:
        sentiment_summary = f'{open_issues} unresolved issue(s) indicate that community follow-up should be prioritized.'

    recommendations = []
    if risk_score >= 70 or anomaly_indicators:
        recommendations.append('Flag for authorized officer investigation and request supporting evidence before further disbursement.')
    if schedule_delay_months:
        recommendations.append('Request a dated recovery plan and milestone-level explanation for schedule slippage.')
    if open_issues:
        recommendations.append('Review and respond to linked citizen complaints with a public progress update.')
    if procurement_indicators:
        recommendations.append('Review tender evaluation records, bid comparisons, and award justification.')
    if duplicate_candidates:
        recommendations.append('Verify whether similar project records represent separate scopes or a duplicate entry.')
    if data_integrity_flags:
        recommendations.append('Reconcile the project status against milestones, payments, and completion evidence.')
    if not recommendations:
        recommendations.append('Continue routine milestone, expenditure, and evidence monitoring.')

    return [
        ('risk', f'{risk_level.title()} delivery risk ({risk_score}/100). ' + (' '.join(risk_reasons) if risk_reasons else 'No major automated risk signals detected.'), {'score': risk_score, 'anomaly_score': max(risk_score, anomaly_score), 'level': risk_level, 'reasons': risk_reasons, 'anomaly_indicators': anomaly_indicators, 'procurement_indicators': procurement_indicators, 'data_integrity_flags': data_integrity_flags, 'duplicate_candidates': duplicate_candidates, 'schedule_delay_months': schedule_delay_months, 'complaints': open_issues, 'contractor': contractor, 'financial_health': financial_health, 'schedule_health': schedule_health, 'early_warnings': early_warnings, 'recommendations': recommendations, 'evidence_chain': ['Budget and expenditure records', 'Milestone and stage records', 'Project timeline', 'Contractor records', 'Citizen issue records'], 'investigation': {'what_happened': risk_reasons[0] if risk_reasons else 'No major automated anomaly detected.', 'why_unusual': anomaly_indicators[0] if anomaly_indicators else 'Observed values are within the available rules-based checks.', 'what_to_check': 'Payment certificates, variation orders, invoices, site evidence, and milestone approvals.', 'priority': risk_level}}, max(55, 100 - risk_score)),
        ('completion', completion_summary, {'progress': effective_progress, 'status': status, 'milestones_completed': milestone_done, 'milestones_total': milestone_total, 'predicted_completion': predicted_completion.isoformat() if predicted_completion else None, 'schedule_delay_months': schedule_delay_months}, completion_confidence),
        ('budget', budget_summary + (f' Potential financial anomaly: {anomaly_level}.' if anomaly_indicators else ''), {**budget, 'anomaly_score': anomaly_score, 'anomaly_level': anomaly_level, 'indicators': anomaly_indicators, 'physical_progress': effective_progress, 'financial_health': financial_health, 'budget_revisions': budget_revisions, 'expenses_after_deadline': expenses['after_deadline']}, 90 if budget['budget'] else 45),
        ('performance', performance_summary, {'milestones_completed': milestone_done, 'milestones_total': milestone_total, 'stages': stage_total, 'average_stage_progress': average_stage_progress, 'contractor': contractor, 'contractor_score': contractor_score, 'contractor_anomalies': ['Repeated delays across linked projects'] if contractor['delayed_projects'] >= 2 else []}, 85 if milestone_total or stage_total else 45),
        ('sentiment', sentiment_summary, {'open_issues': open_issues, 'feedback_count': len(feedback_values), 'citizen_satisfaction': citizen_satisfaction, 'signal': 'follow_up_required' if open_issues else 'limited_data'}, 65 if open_issues or feedback_values else 40),
    ]


@transaction.atomic
def generate_project_analyses(project: Project, requested_by=None):
    """Create a fresh, explainable analysis snapshot for every project AI pillar."""
    del requested_by
    AIProjectAnalysis.objects.filter(project=project, is_latest=True).update(is_latest=False)
    model_name = getattr(settings, 'OPENAI_MODEL', '') or 'govtracker-rules-v2'
    created = []
    for analysis_type, summary, data, confidence in _analysis_payloads(project):
        created.append(AIProjectAnalysis.objects.create(
            project=project,
            analysis_type=analysis_type,
            summary=summary,
            data=data,
            confidence=confidence,
            model=model_name,
            is_latest=True,
        ))

    risk = next(item for item in created if item.analysis_type == 'risk')
    project.ai_risk_score = risk.data.get('score')
    completion = next(item for item in created if item.analysis_type == 'completion')
    project.ai_summary = completion.summary
    project.ai_completion_estimate = timezone.localdate() if project.project_status == 'completed' else project.ai_completion_estimate
    project.save(update_fields=['ai_risk_score', 'ai_summary', 'ai_completion_estimate'])
    return created


def build_portfolio_anomaly_summary(projects, limit=12):
    """Aggregate explainable project anomaly snapshots for the AI portfolio dashboard."""
    snapshots = []
    counts = {'critical': 0, 'high': 0, 'medium': 0, 'early_warnings': 0, 'financial': 0, 'schedule': 0, 'procurement': 0, 'data_quality': 0}
    for project in projects:
        risk = next(data for kind, _summary, data, _confidence in _analysis_payloads(project) if kind == 'risk')
        if risk['anomaly_score'] >= 80:
            counts['critical'] += 1
        elif risk['anomaly_score'] >= 60:
            counts['high'] += 1
        elif risk['anomaly_score'] >= 40:
            counts['medium'] += 1
        counts['early_warnings'] += len(risk['early_warnings'])
        counts['financial'] += bool(risk['anomaly_indicators'])
        counts['schedule'] += bool(risk['schedule_delay_months'] or risk['schedule_health'] < 60)
        counts['procurement'] += bool(risk['procurement_indicators'])
        counts['data_quality'] += bool(risk['data_integrity_flags'] or risk['duplicate_candidates'])
        snapshots.append({'project': project, 'risk': risk})
    snapshots.sort(key=lambda item: (item['risk']['anomaly_score'], item['risk']['score']), reverse=True)
    return {'counts': counts, 'projects': snapshots[:limit], 'total': len(snapshots)}
