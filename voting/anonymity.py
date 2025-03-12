from django.http import JsonResponse, HttpResponse
from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt
from .models import VirtualRegister
from django.utils import timezone
import json

@csrf_exempt
def register_student(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        student_id = data.get('student_id')
        faculty_id = data.get('faculty_id')
        
        if VirtualRegister.objects.filter(student_id=student_id).exists():
            return JsonResponse({'success': False, 'message': 'Student already registered'})
        
        VirtualRegister.objects.create(student_id=student_id, faculty_id=faculty_id)
        return JsonResponse({'success': True, 'message': 'Student registered successfully'})
    
    return HttpResponse(status=405)

@csrf_exempt
def submit_feedback(request):
    if request.method == 'POST':
        student_id = request.POST.get('student_id')
        faculty_id = request.POST.get('faculty_id')
        
        # Check if student is approved and has not already voted
        try:
            record = VirtualRegister.objects.get(student_id=student_id, faculty_id=faculty_id)
            if not record.approved:
                return HttpResponse("You are not approved to vote", status=403)
            if record.timestamp is not None:
                return HttpResponse("You have already voted", status=400)
            
            # Process feedback submission
            # Your feedback processing logic here

            # Update timestamp
            record.timestamp = timezone.now()
            record.save()
            return JsonResponse({'success': True, 'message': 'Feedback submitted successfully'})
        
        except VirtualRegister.DoesNotExist:
            return HttpResponse("Invalid student_id or faculty_id", status=404)
    
    return HttpResponse(status=405)

def start_voting_session(request):
    if request.method == 'POST':
        faculty_id = request.POST.get('faculty_id')
        
        # Approve all students registered under this faculty_id
        VirtualRegister.objects.filter(faculty_id=faculty_id).update(approved=True)
        
        return redirect('http://127.0.0.1:8000/voting/')
    
    return HttpResponse(status=405)

def clear_virtual_register(request):
    if request.method == 'POST':
        faculty_id = request.POST.get('faculty_id')
        
        # Delete all records with the given faculty_id
        VirtualRegister.objects.filter(faculty_id=faculty_id).delete()
        
        return JsonResponse({'success': True, 'message': 'Virtual register cleared'})
    
    return HttpResponse(status=405)
