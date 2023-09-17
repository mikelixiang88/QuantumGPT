from django.urls import path
from . import views

urlpatterns = [
    # ... your other url patterns
    path('ask_question/', views.ask_question, name='ask_question'),
    path('submit_comment/', views.submit_comment, name='submit_comment'),
    path('app/', views.check_token, name='app_page'),
]
