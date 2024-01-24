from django.shortcuts import render
from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import ChatSession, Message
from quantum_accounts.models import CustomUser
from django.conf import settings
import json 
from django.contrib.auth.decorators import login_required
from .pusher_util import pusher_client
from .serializers import MessageSerializer, ChatSessionSerializer
from django.utils import timezone


def pusher_auth(request):
    user = request.user

    if user.is_authenticated:
        channel_name = request.POST['channel_name']

       
        presence_channel_name = f'presence-{channel_name}'

        auth = pusher_client.authenticate(
            presence_channel_name,
            request.POST['socket_id'],
            {
                'user_id': str(user.id),
                'user_info': {
                    'username': user.username,
                }
            }
        )

        return JsonResponse(auth)

    return JsonResponse({'error': 'Authentication failed'}, status=403)

def chat_page(request):
    return render(request, 'chat_page.html')
@api_view(['POST'])
def init_chat(request):
    if request.method == 'POST':
        owner = request.user
        title = request.data.get('title')
        new_chat = ChatSession.objects.create(owner=owner, title=title)
        new_chat.participants.add(owner)
        new_chat.save()
        return JsonResponse({"success": True, "message": "Chat session created", "chat_session_id": new_chat.id}, status=201)

@api_view(['POST'])
def remove_participants(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user != chat_session.owner:
        return JsonResponse({"error": "Permission denied"}, status=403)

    user_ids = request.data.get('participants')
    for user_id in user_ids:
        user = get_object_or_404(CustomUser, id=user_id)
        if user in chat_session.participants.all():
            chat_session.participants.remove(user)
            pusher_channel = f'presence-chat-{chat_session_id}'
            pusher_event = 'participant_removed' 
            pusher_data = {
                'removedUserId': user_id,
                'status': 'offline'  
            }
            pusher_client.trigger(pusher_channel, pusher_event, pusher_data, {"message": "You have been removed from the chat."})
    return JsonResponse({"success": True, "message": f"success"}, status=200)
  
@api_view(['POST', 'GET'])
def add_participants(request, chat_session_id):
    action = ""
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user not in chat_session.participants.all():
        return Response({'detail': 'You are not a participant in this chat session.'}, status=status.HTTP_403_FORBIDDEN)
    try:
        user_ids = request.data.get('participants')
    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON data"}, status=400)
    for user_id in user_ids:
        user = get_object_or_404(CustomUser, id=user_id)
        if user not in chat_session.participants.all():
            chat_session.participants.add(user)
            action = "added to"
            pusher_channel = f'presence-chat-{chat_session_id}' 
            pusher_event = 'participant_added'
            pusher_data = {
                'participant': user.username,
                'status': 'online' 
            }
            pusher_client.trigger(pusher_channel, pusher_event, pusher_data)
        else:
            action = "already in"
    return JsonResponse({"success": True, "message": f"success {action}"}, status=200)

@login_required
@api_view(['POST', 'GET'])
def send_message(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user not in chat_session.participants.all():
        return Response({'detail': 'You are not a participant in this chat session.'}, status=status.HTTP_403_FORBIDDEN)

    if request.method == 'POST' or request.method == 'GET':
        serializer = MessageSerializer(data=request.data)
        chat_session.updated_at = timezone.now()
        chat_session.save()

        if serializer.is_valid():
            # Create a Message object with the sender, chat session, and content
            message = Message.objects.create(
                chat_session=chat_session,
                sender=request.user,
                content=serializer.validated_data['content']
            )

            pusher_channel = f'presence-chat-{chat_session_id}'
            pusher_event = 'new-message'
            
           
            sender_status = request.user.status
            
            pusher_data = {
                'message': serializer.data,
                'message_id': message.id,
                'username': request.user.username,
                'userID': request.user.id,
                'status': sender_status  
            }
            
            pusher_client.trigger(pusher_channel, pusher_event, pusher_data)

            pusher_channel_2 = 'chat-updates'
            pusher_event_2 = 'new-message'
            pusher_data_2 = {'sessionId': chat_session_id}
            pusher_client.trigger(pusher_channel_2, pusher_event_2, pusher_data_2)

    
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


    return Response({'detail': 'Method not allowed.'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)


@api_view(['POST'])
def leave_chat(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user not in chat_session.participants.all():
        return Response({"success": True, "message": "You are not in the chat session"}, status=200)
    
    user = request.user
    is_owner = (user == chat_session.owner)
    
   
    user_status = user.status
    
    if is_owner:
        chat_session.delete()
    else:
        chat_session.participants.remove(user)
    

    pusher_channel = f'presence-chat-{chat_session_id}' 
    pusher_event = 'participant_left'
    
    pusher_data = {
        'participant': user.username,
        'status': 'offline' if user_status == 'online' else user_status 
    }
    pusher_client.trigger(pusher_channel, pusher_event, pusher_data)
    
    return JsonResponse({"success": True, "message": "Successfully left the chat session"}, status=200)

@api_view(['POST'])
def transfer_ownership(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user != chat_session.owner:
        return JsonResponse({"error": "Permission denied"}, status=403)

    new_owner_id = request.data.get('new_owner_id')
    new_owner = get_object_or_404(CustomUser, id=new_owner_id)
    chat_session.owner = new_owner
    chat_session.save()

    return JsonResponse({"success": True, "message": f"Ownership transferred to {new_owner.username}"}, status=200)

@login_required
def chat_sessions(request):
    user = request.user
    sessions = ChatSession.objects.filter(participants=user).order_by('-updated_at')
    
    session_data = []
    for session in sessions:
        session_data.append({
            'id': session.id,
            'participants': [p.username for p in session.participants.all()],
            'owner': session.owner.username,
            'title': session.title
        })
    
    return JsonResponse({'chat_sessions': session_data})

@login_required
def OpenSessionView(request, session_id):

    chat_session = get_object_or_404(ChatSession, pk=session_id)
        

    if request.user not in chat_session.participants.all():
        return JsonResponse({'error': 'User not authorized for this chat session'}, status=403)
        

    messages = Message.objects.filter(chat_session=chat_session).order_by('timestamp')
        

    message_data = []
    for message in messages:
        message_data.append({
            'sender': message.sender.username,
            'senderID': message.sender.id,
            'content': message.content,
            'timestamp': message.timestamp.strftime('%Y-%m-%d %H:%M:%S')
        })
        
    return JsonResponse({'owner':chat_session.owner.id, 'messages': message_data})

@login_required
def get_participants(request, session_id):
    chat_session = get_object_or_404(ChatSession, pk=session_id)
    participants = chat_session.participants.all().values('id', 'username')
    owner_id = chat_session.owner.id
    owner_username = chat_session.owner.username
    return JsonResponse({'owner': {'id': owner_id,'username': owner_username},'participants': list(participants)})

@api_view(['POST'])
def changetitle(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user != chat_session.owner:
        return JsonResponse({"error": "Permission denied"}, status=403)
    chat_session.title=request.data.get('title')
    chat_session.save()
    return JsonResponse({"success": True, "message": f"success"}, status=200)
