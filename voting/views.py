import csv
from django.http import HttpResponse,JsonResponse 
from django.utils import timezone

from django.shortcuts import render, redirect
from .models import Faculty, Courses, Feedback  # Assuming Feedback is the model to store the feedback
from account.models import Department

from django.views import View
from .forms import FacultyForm




def index(request):
    return render(request, 'index.html')

def faculty(request):
    return render(request, 'admin.html')
    
def vote(request):
    if request.method == 'POST':
        if request.session.get('has_voted', False):
            return HttpResponse("You have already voted", status=400)
        
        feedback_data = {
            'Q1': request.POST.get('Q1'),
            'Q2': request.POST.get('Q2'),
            'Q3': request.POST.get('Q3'),
            'Q4': request.POST.get('Q4'),
            'Q5': request.POST.get('Q5'),
            'Q6': request.POST.get('Q6'),
        }
        
        if None in feedback_data.values():
            #return render(request, 'index.html', {'all_questions_not_answered': True})
            return HttpResponse("All questions must be answered", status=400)
        
        Feedback.objects.create(**feedback_data)
        request.session['has_voted'] = True  # Mark as voted in the session
        #return JsonResponse({"message": "Vote submitted"}, status=200)
        #return HttpResponse("Vote submitted", status=200)
        #return HttpResponse(status=200)  # No content
        # Redirect to the voting page after successful submission
        #return redirect('http://127.0.0.1:8000/voting/')
        #return redirect("voting:home")
        # Redirect to the voting page after successful submission
        return redirect("voting:home")
        
    return HttpResponse("Invalid request method", status=405)

def feedback_list(request):
    feedbacks = Feedback.objects.all()
    
    # Initialize totals
    total_Q1 = total_Q2 = total_Q3 = total_Q4 = total_Q5 = total_Q6 = 0
    
    formatted_feedbacks = []
    
    for feedback in feedbacks:
        local_timestamp = timezone.localtime(feedback.timestamp)
        
        formatted_feedback = {
            'Q1': feedback.Q1,
            'Q2': feedback.Q2,
            'Q3': feedback.Q3,
            'Q4': feedback.Q4,
            'Q5': feedback.Q5,
            'Q6': feedback.Q6,
            'timestamp': local_timestamp.strftime('%d-%m-%y %H:%M')
        }
        formatted_feedbacks.append(formatted_feedback)
        
        # Update totals
        total_Q1 += feedback.Q1
        total_Q2 += feedback.Q2
        total_Q3 += feedback.Q3
        total_Q4 += feedback.Q4
        total_Q5 += feedback.Q5
        total_Q6 += feedback.Q6
    
    totals = {
        'Q1': total_Q1,
        'Q2': total_Q2,
        'Q3': total_Q3,
        'Q4': total_Q4,
        'Q5': total_Q5,
        'Q6': total_Q6,
    }
    
    return render(request, 'feedback_list.html', {'feedbacks': formatted_feedbacks, 'totals': totals})



def export_feedback_csv(request):
    # Create the HttpResponse object with the appropriate CSV header.
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="feedback.csv"'

    writer = csv.writer(response)
    writer.writerow(['Date', 'Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6'])

    feedbacks = Feedback.objects.all()
    for feedback in feedbacks:
        writer.writerow([
            feedback.timestamp.strftime('%d-%m-%y %H:%M'),
            feedback.Q1,
            feedback.Q2,
            feedback.Q3,
            feedback.Q4,
            feedback.Q5,
            feedback.Q6
        ])

    return response
    
def clear_vote_session(request):
    if request.method == 'POST':
        request.session.pop('has_voted', None)
        return HttpResponse("Session cleared", status=200)
    return HttpResponse("Invalid request method", status=405)


class FacultyCreateView(View):
    def get(self, request):
        form = FacultyForm()
        return render(request, 'faculty_form.html', {'form': form})

    def post(self, request):
        form = FacultyForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('voting:feedback-list')  # Assuming you have a view to list faculty members
        return render(request, 'faculty_form.html', {'form': form})