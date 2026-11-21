"""Safaricom Daraja B2C disbursements for approved contractor payments."""

import base64
import json
import re
from urllib.error import HTTPError, URLError
from urllib.parse import urlparse
from urllib.request import Request, urlopen
from datetime import datetime
from zoneinfo import ZoneInfo

from django.conf import settings
from django.urls import reverse


class DarajaError(Exception):
    """Raised when Daraja cannot be reached or its response is unusable."""


class DarajaRejected(DarajaError):
    """Raised when Daraja explicitly rejects a B2C payment request."""


def normalize_kenyan_phone(phone):
    digits = re.sub(r'\D', '', phone or '')
    if len(digits) == 10 and digits.startswith('0'):
        digits = '254' + digits[1:]
    elif len(digits) == 9:
        digits = '254' + digits
    if not re.fullmatch(r'254[17]\d{8}', digits):
        raise ValueError('Enter a valid Kenyan mobile number for M-Pesa.')
    return digits


def _configuration(*, payout=True):
    environment = getattr(settings, 'MPESA_ENVIRONMENT', 'sandbox')
    if environment not in {'sandbox', 'production'}:
        raise DarajaError('MPESA_ENVIRONMENT must be sandbox or production.')
    required = {
        'consumer key': getattr(settings, 'MPESA_CONSUMER_KEY', ''),
        'consumer secret': getattr(settings, 'MPESA_CONSUMER_SECRET', ''),
        'shortcode': (
            getattr(settings, 'MPESA_SHORTCODE', '')
            if payout else (getattr(settings, 'MPESA_STK_SHORTCODE', '') or getattr(settings, 'MPESA_SHORTCODE', ''))
        ),
        'callback base URL': getattr(settings, 'MPESA_CALLBACK_BASE_URL', ''),
        'callback token': getattr(settings, 'MPESA_CALLBACK_TOKEN', ''),
    }
    if payout:
        required['initiator name'] = getattr(settings, 'MPESA_INITIATOR_NAME', '')
        required['security credential'] = getattr(settings, 'MPESA_SECURITY_CREDENTIAL', '')
    missing = [label for label, value in required.items() if not value]
    if missing:
        raise DarajaError('M-Pesa is not configured: missing ' + ', '.join(missing) + '.')
    if len(required['callback token']) < 32:
        raise DarajaError('MPESA_CALLBACK_TOKEN must contain at least 32 characters.')
    callback = urlparse(required['callback base URL'])
    if callback.scheme != 'https' or not callback.netloc:
        raise DarajaError('MPESA_CALLBACK_BASE_URL must be a public HTTPS URL.')

    host = (
        'https://sandbox.safaricom.co.ke'
        if environment == 'sandbox'
        else 'https://api.safaricom.co.ke'
    )
    return {
        **required,
        'host': host,
        'shortcode': str(required['shortcode']),
        'command_id': getattr(settings, 'MPESA_COMMAND_ID', 'BusinessPayment'),
    }


def _callback_url(route_name):
    config = _configuration(payout=False)
    token = config['callback token']
    path = reverse(route_name, kwargs={'token': token})
    return config['callback base URL'].rstrip('/') + path


def _decode_response(response):
    try:
        return json.loads(response.read().decode('utf-8'))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        raise DarajaError('Daraja returned an invalid response.') from exc


def get_access_token():
    config = _configuration(payout=False)
    credentials = f"{config['consumer key']}:{config['consumer secret']}".encode('utf-8')
    request = Request(
        config['host'] + '/oauth/v1/generate?grant_type=client_credentials',
        headers={'Authorization': 'Basic ' + base64.b64encode(credentials).decode('ascii')},
    )
    try:
        with urlopen(request, timeout=20) as response:
            data = _decode_response(response)
    except HTTPError as exc:
        raise DarajaError(f'Daraja authentication failed (HTTP {exc.code}).') from exc
    except (URLError, TimeoutError, OSError) as exc:
        raise DarajaError('Could not connect to Daraja for authentication.') from exc
    token = data.get('access_token')
    if not token:
        raise DarajaError('Daraja did not return an access token.')
    return token


def submit_b2c_payment(payment, phone_number, access_token):
    config = _configuration()
    url = config['host'] + '/mpesa/b2c/v1/paymentrequest'
    callback_url = _callback_url('mpesa_result_callback')
    timeout_url = _callback_url('mpesa_timeout_callback')
    payload = {
        'InitiatorName': config['initiator name'],
        'SecurityCredential': config['security credential'],
        'CommandID': config['command_id'],
        'Amount': int(payment.amount),
        'PartyA': config['shortcode'],
        'PartyB': phone_number,
        'Remarks': f'Contractor payment {payment.pk}',
        'QueueTimeOutURL': timeout_url,
        'ResultURL': callback_url,
        'Occasion': payment.invoice_number or str(payment.pk),
    }
    request = Request(
        url,
        data=json.dumps(payload).encode('utf-8'),
        headers={
            'Authorization': 'Bearer ' + access_token,
            'Content-Type': 'application/json',
        },
        method='POST',
    )
    try:
        with urlopen(request, timeout=30) as response:
            data = _decode_response(response)
    except HTTPError as exc:
        try:
            data = json.loads(exc.read().decode('utf-8'))
        except (UnicodeDecodeError, json.JSONDecodeError):
            raise DarajaError(f'Daraja returned HTTP {exc.code} without a usable response.') from exc
        if str(data.get('ResponseCode', '')) != '0':
            raise DarajaRejected(data.get('ResponseDescription') or 'Daraja rejected the payment request.')
        raise DarajaError(f'Daraja returned an unexpected HTTP {exc.code}.') from exc
    except (URLError, TimeoutError, OSError) as exc:
        raise DarajaError(
            'The payment request outcome is unknown because the connection failed. '
            'Do not retry until you have checked the Daraja transaction status.'
        ) from exc

    if str(data.get('ResponseCode', '')) != '0':
        raise DarajaRejected(data.get('ResponseDescription') or 'Daraja rejected the payment request.')
    if not data.get('ConversationID') or not data.get('OriginatorConversationID'):
        raise DarajaError(
            'Daraja accepted the request but omitted its tracking IDs. '
            'The payment remains pending; do not retry until reconciled.'
        )
    return data


def submit_stk_push(payment, phone_number, access_token):
    """Prompt a customer to authorize an Lipa Na M-Pesa payment."""
    config = _configuration(payout=False)
    shortcode = config['shortcode']
    passkey = getattr(settings, 'MPESA_STK_PASSKEY', '')
    if not shortcode or not passkey:
        raise DarajaError('M-Pesa STK Push is not configured: set MPESA_STK_SHORTCODE and MPESA_STK_PASSKEY.')
    timestamp = datetime.now(ZoneInfo('Africa/Nairobi')).strftime('%Y%m%d%H%M%S')
    password = base64.b64encode(f'{shortcode}{passkey}{timestamp}'.encode()).decode('ascii')
    callback_url = _callback_url('mpesa_stk_callback')
    payload = {
        'BusinessShortCode': str(shortcode),
        'Password': password,
        'Timestamp': timestamp,
        'TransactionType': getattr(settings, 'MPESA_STK_TRANSACTION_TYPE', 'CustomerPayBillOnline'),
        'Amount': int(payment.amount),
        'PartyA': phone_number,
        'PartyB': str(shortcode),
        'PhoneNumber': phone_number,
        'CallBackURL': callback_url,
        'AccountReference': f'PAY{payment.pk}',
        'TransactionDesc': payment.description[:100] or f'Payment {payment.pk}',
    }
    request = Request(
        config['host'] + '/mpesa/stkpush/v1/processrequest',
        data=json.dumps(payload).encode('utf-8'),
        headers={'Authorization': 'Bearer ' + access_token, 'Content-Type': 'application/json'},
        method='POST',
    )
    try:
        with urlopen(request, timeout=30) as response:
            data = _decode_response(response)
    except HTTPError as exc:
        raise DarajaError(f'Daraja STK request failed (HTTP {exc.code}).') from exc
    except (URLError, TimeoutError, OSError) as exc:
        raise DarajaError('The STK request outcome is unknown. Check Daraja before retrying.') from exc
    if str(data.get('ResponseCode', '')) != '0' or not data.get('CheckoutRequestID'):
        raise DarajaRejected(data.get('ResponseDescription') or 'Daraja rejected the STK request.')
    return data
