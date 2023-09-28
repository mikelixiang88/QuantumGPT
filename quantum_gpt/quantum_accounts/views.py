from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages

# Create your views here.
from quantum_accounts.models import CustomUser
from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.http import JsonResponse
from .forms import CustomUserCreationForm, CustomAuthenticationForm

def register_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('app_page')  # Redirect to home or any other page
    else:
        form = CustomUserCreationForm()
    return render(request, 'register.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        form = CustomAuthenticationForm(data=request.POST)
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('app_page')
    else:
        form = CustomAuthenticationForm()
    return render(request, 'login.html', {'form': form})

def check_account(request):
    # Fetch the number of questions left and comments made.
    if request.user.is_authenticated:
        question_token = request.user.question_token
        comments_made = request.user.comments_made
        question_asked=request.user.question_asked
        experience=request.user.experience
        teleporter=request.user.teleporter
    else:
        questions_left = 0
        comments_made = 0
        question_asked=0
        experience=0
        teleporter="teleporter is empty"

    context = {
        'question_left': question_token,
        'comments_made': comments_made,
        'question_asked': question_asked,
        'experience': experience,
    }

    return render(request, 'account.html', context)

def update_teleporter(request):
    if request.method == 'POST':
        message = request.POST.get('teleporter')
        teleporter_message=request.user.teleporter
        request.user.teleporter=message
        request.user.save(update_fields=['teleporter'])
        return JsonResponse({'success': True, 'teleporter': teleporter_message,})

        
    return JsonResponse({'success': False})

def display_user(request):
    if request.method == 'POST':
        usern = request.POST.get('user')
        try:
            obj = CustomUser.objects.get(username=usern)
            experience = obj.experience
            teleporter_message = obj.teleporter
            question_asked=obj.question_asked
            comments_made=obj.comments_made
            context = {
                'question_asked': question_asked,
                'comments_made': comments_made,
                'question_asked': question_asked,
                'experience': experience,
                'teleporter': teleporter_message,
            }

            return render(request, 'otheruser.html', context)

        except ObjectDoesNotExist:
            messages.error(request, 'User not found.')
            return redirect('myaccount')  # Redirect to a different page
    return redirect('myaccount')
