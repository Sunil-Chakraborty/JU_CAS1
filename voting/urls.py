from django.urls import path
from . import views
from .views import FacultyCreateView


app_name = 'voting'

urlpatterns = [
    path('home', views.index, name='home'),
    path('faculty/', views.faculty, name='faculty'),
    path('vote/', views.vote, name='vote'),
    path('clear-session/', views.clear_vote_session, name='clear_vote_session'),
    path('feedback-list/', views.feedback_list, name='feedback_list'),
    path('export-feedback-csv/', views.export_feedback_csv, name='export_feedback_csv'),
    path('faculty/create/', FacultyCreateView.as_view(), name='faculty_create'),
     
]


#http://127.0.0.1:8000/voting/faculty/create/
