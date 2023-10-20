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
        chat_session.participants.remove(user)
    return JsonResponse({"success": True, "message": f"success"}, status=200)
        
@api_view(['POST'])
def add_participants(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user not in chat_session.participants.all():
        return Response({'detail': 'You are not a participant in this chat session.'}, status=status.HTTP_403_FORBIDDEN)
    # Parse the JSON data from the request body
    try:
        user_ids = request.data.get('participants')
    except json.JSONDecodeError:
        return JsonResponse({"error": "Invalid JSON data"}, status=400)
    # Assuming 'participants' is a list of user IDs
    for user_id in user_ids:
        user = get_object_or_404(CustomUser, id=user_id)
        chat_sessions_with_user = ChatSession.objects.filter(participants=user)
        if not chat_sessions_with_user.exists():
            chat_session.participants.add(user)
            action = "added to"
            pusher_client.trigger(f'chat_{chat_session_id}', 'participant_added', {
                'participant': user.username
            })
        else:
            action = "already in"  # Assign a different value if needed
    return JsonResponse({"success": True, "message": f"success"}, status=200)

@login_required
@api_view(['POST', 'GET'])
def send_message(request, chat_session_id):
    # Get the ChatSession object or return a 404 response if it doesn't exist
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user not in chat_session.participants.all():
        return Response({'detail': 'You are not a participant in this chat session.'}, status=status.HTTP_403_FORBIDDEN)

    if request.method == 'POST' or request.method == 'GET':
        # Serialize the message data
        serializer = MessageSerializer(data=request.data)
        chat_session.updated_at = timezone.now()
        chat_session.save()

        # Check if the serializer is valid
        if serializer.is_valid():
            # Create a Message object with the sender, chat session, and content
            message = Message.objects.create(
                chat_session=chat_session,
                sender=request.user,
                content=serializer.validated_data['content']
            )

            # Trigger a Pusher event to notify clients of the new message
            pusher_channel = f'chat-{chat_session_id}'
            pusher_event = 'new-message'
            pusher_data = {'message': serializer.data, 'message_id':message.id, 'username':request.user.username, 'userID':request.user.id}
            pusher_client.trigger(pusher_channel, pusher_event, pusher_data)
            pusher_channel_2 = 'chat-updates'
            pusher_event_2 = 'new-message'
            pusher_data_2 = {'sessionId': chat_session_id}
            pusher_client.trigger(pusher_channel_2, pusher_event_2, pusher_data_2)

            # Return a successful response with the serialized data
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        # Return a response with serializer errors if the data is invalid
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    # Handle other HTTP methods (e.g., GET, PUT, DELETE) if necessary
    return Response({'detail': 'Method not allowed.'}, status=status.HTTP_405_METHOD_NOT_ALLOWED)

@api_view(['POST'])
def leave_chat(request, chat_session_id):
    chat_session = get_object_or_404(ChatSession, id=chat_session_id)
    if request.user not in chat_session.participants.all():
        return Response({"success": True, "message": "You are not in the chat session"}, status=200)
    user=request.user
    if user==chat_session.owner:
        chat_session.delete()
    else:
        chat_session.participants.remove(request.user)
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
    # Get the chat session
    chat_session = get_object_or_404(ChatSession, pk=session_id)
        
    # Ensure the user is a participant in the chat session
    if request.user not in chat_session.participants.all():
        return JsonResponse({'error': 'User not authorized for this chat session'}, status=403)
        
    # Fetch messages for the chat session
    messages = Message.objects.filter(chat_session=chat_session).order_by('timestamp')
        
    # Prepare message data to be sent in the response
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
