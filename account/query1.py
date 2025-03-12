
#http://127.0.0.1:8000/prior-posts/

from django.shortcuts import render, redirect, get_object_or_404
import csv
from django.contrib import messages
from django.http import HttpResponse
from account.models import Account, PriorPost, Department
from django.conf import settings

def prior_posts_view(request):
    # Query to filter PriorPost based on Account model's conditions and join the Department table
    
    prior_posts = PriorPost.objects.filter(
        email__frm_submitted=False,
        email__is_submit=False
    ).select_related('email', 'email__Department').order_by('email__username')
    
    
    # Query without filter PriorPost based on Account model's conditions and join the Department table
    # prior_posts = PriorPost.objects.select_related('email', 'email__Department').order_by('email__username')
    
    
    
    if 'csv' in request.GET:
        # Create the HttpResponse object with the appropriate CSV header.
        response = HttpResponse(content_type='text/csv')
        response['Content-Disposition'] = 'attachment; filename="prior_posts.csv"'

        writer = csv.writer(response)
        # Write the header
        writer.writerow(['Username', 'Email', 'Designation', 'Employer', 'Department Name', 'Faculty'])

        # Write the data
        for post in prior_posts:
            writer.writerow([
                post.email.username,
                post.email.email,
                post.get_designation_display(),
                post.employer,
                post.email.Department.name if post.email.Department else '',
                post.email.Department.faculty if post.email.Department else ''
            ])
        return response
    else:
        # Render the HTML template with the data
        context = {
            'prior_posts': prior_posts
        }    
        return render(request, 'prior_posts.html', context)
   
   

def delete_prior_post(request, post_id):
    prior_post = get_object_or_404(PriorPost, id=post_id)
    prior_post.delete()
    messages.success(request, f'Prior post for {prior_post.email.username} has been deleted successfully.')
    return redirect('prior-posts')
    
    
    
    
    """
    Equivalent SQL Query
    SELECT
        priorpost.id,
        priorpost.designation,
        priorpost.employer,
        account.username,
        account.email,
        department.name AS department_name,
        department.faculty AS department_faculty
    FROM
        priorpost
    INNER JOIN
        account ON priorpost.email_id = account.id
    LEFT JOIN
        department ON account.Department_id = department.id
    WHERE
        account.frm_submitted = FALSE AND
        account.is_submit = FALSE;
    """
    