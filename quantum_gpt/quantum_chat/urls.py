from django.urls import path
from . import views

urlpatterns = [
    path('chat/', views.chat_page, name='chat_page'),
    path('init_chat/', views.init_chat, name='init_chat'),
    path('chat/<int:chat_session_id>/add/', views.add_participants, name='add_participant'),
    path('chat/<int:chat_session_id>/remove/', views.remove_participants, name='remove_participant'),
    path('chat/<int:chat_session_id>/leave/', views.leave_chat, name='leave_chat'),
    path('chat/<int:chat_session_id>/transfer_ownership/', views.transfer_ownership, name='transfer_ownership'),
    path('chat/<int:chat_session_id>/send_message/', views.send_message, name='send_message'),
    path('chat_sessions/', views.chat_sessions, name='chat_sessions'),
    path('open_chat/<int:session_id>/messages/', views.OpenSessionView, name='open_session'),
    path('get_participants/<int:session_id>/', views.get_participants, name='get_participants'),
    path('chat/<int:chat_session_id>/changetitle/', views.changetitle, name='changetitle'),
]
