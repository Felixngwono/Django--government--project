"""Contractor disbursement notifications via Africa's Talking SMS.

Every SMS sent to a contractor about a payment is recorded in the immutable
audit trail (``AuditLog``) so the system/government can prove exactly what
was communicated, when, and to which phone number.
"""

from __future__ import annotations

from django.conf import settings
from django.db import transaction
from django.utils import timezone

from .africastalking import AfricaTalkingError, send_sms as _send_africastalking_sms
from .models import AuditLog, ContractorPaymentRequest


class PaymentSmsError(Exception):
    """Raised when a contractor payment SMS cannot be sent or recorded."""


def contractor_phone(payment: ContractorPaymentRequest) -> str | None:
    """Return the best available phone number for a payment's contractor."""
    if payment.mpesa_phone_number:
        return payment.mpesa_phone_number
    if payment.contractor and payment.contractor.phone:
        return payment.contractor.phone
    if payment.submitted_by and payment.submitted_by.phone_number:
        return payment.submitted_by.phone_number
    return None


@transaction.atomic()
def send_payment_sms(
    payment: ContractorPaymentRequest,
    message: str,
    *,
    purpose: str,
    actor=None,
    request=None,
) -> dict:
    """Send an Africa's Talking SMS about a contractor payment and audit it.

    Args:
        payment: The ``ContractorPaymentRequest`` being communicated about.
        message: The SMS body to deliver.
        purpose: Human-readable reason (e.g. ``"payout-initiated"``).
        actor: The user who triggered the SMS (for the audit record).
        request: The current HTTP request (to capture the IP address).

    Returns:
        A dict with the Africa's Talking recipient and status.

    Raises:
        PaymentSmsError: If there is no phone number, SMS is misconfigured,
            or Africa's Talking rejects the message.
    """
    phone = contractor_phone(payment)
    if not phone:
        raise PaymentSmsError(
            "No phone number is available for this payment. "
            "Add an M-Pesa number to the contractor profile before sending SMS."
        )

    try:
        result = _send_africastalking_sms(phone, message)
    except AfricaTalkingError as exc:
        AuditLog.objects.create(
            user=actor,
            action="payment_sms_failed",
            model_name="ContractorPaymentRequest",
            object_id=payment.pk,
            project=payment.project,
            changes={
                "purpose": purpose,
                "phone_last_four": phone[-4:],
                "error": str(exc),
            },
            ip_address=request.META.get("REMOTE_ADDR") if request else None,
        )
        raise PaymentSmsError(str(exc)) from exc

    payment.sms_sent = True
    payment.sms_sent_at = timezone.now()
    payment.sms_reference = result.get("recipient", phone)
    payment.sms_result = result.get("status", "Accepted")
    payment.save(
        update_fields=[
            "sms_sent",
            "sms_sent_at",
            "sms_reference",
            "sms_result",
            "updated_at",
        ]
    )

    AuditLog.objects.create(
        user=actor,
        action="payment_sms_sent",
        model_name="ContractorPaymentRequest",
        object_id=payment.pk,
        project=payment.project,
        changes={
            "purpose": purpose,
            "phone_last_four": phone[-4:],
            "recipient": result.get("recipient"),
            "status": result.get("status"),
            "message_preview": message[:120],
        },
        ip_address=request.META.get("REMOTE_ADDR") if request else None,
    )
    return result
