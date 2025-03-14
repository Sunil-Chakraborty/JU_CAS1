from django.db import models
from datetime import datetime
from django.contrib.auth.models import User
from account.models import Account
from django.conf import settings


# Create your models here.
class Message(models.Model):
    sender          = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='sent_messages')
    receiver        = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='received_messages')
    content         = models.TextField()
    timestamp       = models.DateTimeField(auto_now_add=True)
    read            = models.BooleanField(default=False)
    modified_date   = models.DateTimeField(auto_now=True)
    receiver_name   = models.TextField()
    email           = models.EmailField()
    feedback        = models.TextField()
   
    
    def __str__(self):
        return f"{self.sender} -> {self.receiver}: {self.content}"


