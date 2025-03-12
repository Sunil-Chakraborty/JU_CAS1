from django.urls import path
from .views import register_student, submit_feedback, start_voting_session, clear_virtual_register

urlpatterns = [
    path('register_student/', register_student, name='register_student'),
    path('submit_feedback/', submit_feedback, name='submit_feedback'),
    path('start_voting_session/', start_voting_session, name='start_voting_session'),
    path('clear_virtual_register/', clear_virtual_register, name='clear_virtual_register'),
]
