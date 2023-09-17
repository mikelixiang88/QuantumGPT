from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'password1', 'password2']
        model.question_token=20
        model.question_asked=0
        model.comments_made=0

class CustomAuthenticationForm(AuthenticationForm):
    class Meta:
        model = CustomUser
