import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "Mylogin.settings")

from django.conf import settings
from twilio.rest import Client

def send_sms(to, body):    
    
    client = Client(settings.TWILIO_ACCOUNT_SID, settings.TWILIO_AUTH_TOKEN)
    message = client.messages.create(
        body=body,
        from_=settings.TWILIO_PHONE_NUMBER,
        to=to
    )
    return message.sid

send_sms('+919903751108', '        From: IQAC-JU,\nCAS submitted by Sahinur Reja of Physics.')
