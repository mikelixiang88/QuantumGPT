from django.db import models
from django.contrib.auth.models import User

class ChatSession(models.Model):
    participants = models.ManyToManyField('quantum_accounts.CustomUser', related_name='chat_sessions')
    created_at = models.DateTimeField(auto_now_add=True)
    title = models.TextField(default="untitled")
    owner = models.ForeignKey('quantum_accounts.CustomUser', on_delete=models.CASCADE)

class Message(models.Model):
    chat_session = models.ForeignKey(ChatSession, on_delete=models.CASCADE)
    sender = models.ForeignKey('quantum_accounts.CustomUser', on_delete=models.CASCADE)
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
