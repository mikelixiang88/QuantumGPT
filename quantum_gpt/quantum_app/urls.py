from django.urls import path
from . import views

urlpatterns = [
    # ... your other url patterns
    path('ask_question/', views.ask_question, name='ask_question'),
    path('submit_comment/', views.submit_comment, name='submit_comment'),
    path('app/', views.check_token, name='app_page'),
    path('discussion/<int:comment_id>/', views.discussion, name='discussion'),
    path('api/topic/<int:discussion_id>/post_comment/', views.post_comment_api, name='post_comment_api'),
    path('view_comments/', views.view_comments, name='view_comments'),

]
