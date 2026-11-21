"""Small Africa's Talking SMS client using the official Messaging REST API."""

import json
import re
from urllib.error import HTTPError, URLError
from urllib.parse import urlencode
from urllib.request import Request, urlopen

from django.conf import settings


class AfricaTalkingError(Exception):
    """Raised when SMS is not configured or Africa's Talking rejects it."""


def normalize_recipient(phone):
    raw = (phone or '').strip()
    digits = re.sub(r'\D', '', raw)
    if digits.startswith('0') and len(digits) == 10:
        digits = '254' + digits[1:]
    elif len(digits) == 9 and digits.startswith(('7', '1')):
        digits = '254' + digits
    if not digits.startswith('+'):
        digits = '+' + digits
    if not re.fullmatch(r'\+[1-9]\d{7,14}', digits):
        raise AfricaTalkingError('The applicant does not have a valid international phone number.')
    return digits


def send_sms(phone, message):
    username = getattr(settings, 'AFRICASTALKING_USERNAME', '')
    api_key = getattr(settings, 'AFRICASTALKING_API_KEY', '')
    environment = getattr(settings, 'AFRICASTALKING_ENVIRONMENT', 'sandbox').lower()
    sender_id = getattr(settings, 'AFRICASTALKING_SENDER_ID', '')
    if not username or not api_key:
        raise AfricaTalkingError('Africa\'s Talking is not configured.')
    if environment not in {'sandbox', 'production'}:
        raise AfricaTalkingError('AFRICASTALKING_ENVIRONMENT must be sandbox or production.')

    recipient = normalize_recipient(phone)
    payload = {'username': username, 'to': recipient, 'message': message}
    if sender_id:
        payload['from'] = sender_id
    base_url = (
        'https://api.sandbox.africastalking.com'
        if environment == 'sandbox'
        else 'https://api.africastalking.com'
    )
    request = Request(
        base_url + '/version1/messaging',
        data=urlencode(payload).encode('utf-8'),
        headers={
            'apiKey': api_key,
            'Accept': 'application/json',
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        method='POST',
    )
    try:
        with urlopen(request, timeout=20) as response:
            result = json.loads(response.read().decode('utf-8'))
    except HTTPError as exc:
        raise AfricaTalkingError(f'Africa\'s Talking returned HTTP {exc.code}.') from exc
    except (URLError, TimeoutError, OSError) as exc:
        raise AfricaTalkingError('Could not connect to Africa\'s Talking.') from exc
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise AfricaTalkingError('Africa\'s Talking returned an invalid response.') from exc

    recipients = result.get('SMSMessageData', {}).get('Recipients', [])
    if not recipients or recipients[0].get('statusCode') not in (101, 102, 100):
        description = recipients[0].get('status') if recipients else result.get('SMSMessageData', {}).get('Message')
        raise AfricaTalkingError(description or 'Africa\'s Talking did not accept the SMS.')
    return {'recipient': recipient, 'status': recipients[0].get('status', 'Accepted')}
