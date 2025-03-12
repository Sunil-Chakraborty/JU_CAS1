from django import forms
from .models import Faculty

class FacultyForm(forms.ModelForm):
    class Meta:
        model = Faculty
        fields = ['faculty_name', 'faculty_email', 'emp_id', 'course_name', 'department', 'year', 'semestar', 'batch']
