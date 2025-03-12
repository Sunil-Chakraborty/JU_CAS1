CREATE TABLE virtual_register (
    student_id CHAR(10) PRIMARY KEY,
    faculty_id CHAR(5),
    timestamp TIMESTAMP DEFAULT NULL,
    approved BOOLEAN DEFAULT FALSE
);



from django.db import models

class VirtualRegister(models.Model):
    student_id = models.CharField(max_length=10, primary_key=True)
    faculty_id = models.CharField(max_length=5)
    timestamp = models.DateTimeField(null=True, blank=True)
    approved = models.BooleanField(default=False)
