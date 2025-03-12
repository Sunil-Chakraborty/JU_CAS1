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

send_sms('+9903751108', 'Hello, world! This is a test message from my Django app.')
    
