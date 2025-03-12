from django.utils import timezone
import random
import string
from django.db import models
from account.models import Department

# Create your models here.


class Feedback(models.Model):
    Q1 = models.IntegerField()
    Q2 = models.IntegerField()
    Q3 = models.IntegerField()
    Q4 = models.IntegerField()
    Q5 = models.IntegerField()
    Q6 = models.IntegerField()
    timestamp = models.DateTimeField(auto_now_add=True)
    
    def formatted_timestamp(self):
        local_timestamp = timezone.localtime(self.timestamp)
        return local_timestamp.strftime('%d-%m-%y %H:%M')
        
    def __str__(self):
        return f"Feedback (Q1: {self.Q1}, Q2: {self.Q2}, Q3: {self.Q3}, Q4: {self.Q4}, Q5: {self.Q5}, Q6: {self.Q6})"
        

class Courses(models.Model):
    course_name = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.course_name
        
        

YEAR_CHOICES = (
    (None, 'Select'),
    ('1', '1st'),
    ('2', '2nd'),           
)

SEM_CHOICES = (
    (None, 'Select'),
    ('1', '1st'),
    ('2', '2nd'),           
)

BATCH_CHOICES = (
    (None, 'Select'),
    ('1', '2020-21'),
    ('2', '2021-22'),           
    ('3', '2022-23'),           
    ('4', '2023-24'), 
)

class Faculty(models.Model):
    faculty_name    = models.CharField(max_length=100)
    faculty_email   = models.EmailField(max_length=60)
    faculty_id      = models.CharField(max_length=50, unique=True, editable=False)
    emp_id          = models.CharField(max_length=6)
    course_name     = models.ForeignKey(Courses, on_delete=models.CASCADE, null=True, blank=True)
    department      = models.ForeignKey(Department, on_delete=models.CASCADE, null=True, blank=True, related_name='faculty_members')
    year            = models.CharField(max_length=6, choices=YEAR_CHOICES, null=True, blank=True)
    semestar        = models.CharField(max_length=6, choices=SEM_CHOICES, null=True, blank=True)
    batch           = models.CharField(max_length=6, choices=BATCH_CHOICES, null=True, blank=True)
    created_dt      = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        if not self.faculty_id:
            separator = random.choice(string.ascii_lowercase + string.punctuation)
            self.faculty_id = f"{self.emp_id}{separator}{self.course_name_id}{self.year}{self.semestar}{self.batch}"
        super(Faculty, self).save(*args, **kwargs)
        
        
