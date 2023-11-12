from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from django.contrib import messages

# Create your views here.
from quantum_accounts.models import CustomUser
from django.shortcuts import render, redirect
from django.contrib.auth import login, authenticate
from django.http import JsonResponse
from .forms import CustomUserCreationForm, CustomAuthenticationForm
from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404

from q_blog.models import Post

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
        followed_users = request.user.following.all()
        followers = request.user.followers.all()
        question_token = request.user.question_token
        comments_made = request.user.comments_made
        question_asked=request.user.question_asked
        experience=request.user.experience
        teleporter=request.user.teleporter
        user_posts = Post.objects.filter(author=request.user).order_by('-created_on')
    else:
        questions_left = 0
        comments_made = 0
        question_asked=0
        experience=0
        teleporter="teleporter is empty"
        user_posts={}
        

    context = {
        'question_left': question_token,
        'comments_made': comments_made,
        'question_asked': question_asked,
        'experience': experience,
        'followed_users': followed_users,
        'user_posts': user_posts,
        'followers': followers,
    }

    return render(request, 'account.html', context)

def display_user(request):
    if request.method == 'POST':
        usern = request.POST.get('user')
        try:
            obj = CustomUser.objects.get(username=usern)
            experience = obj.experience
            teleporter_message = obj.teleporter
            question_asked=obj.question_asked
            comments_made=obj.comments_made
            user_id=obj.id
            user_posts = Post.objects.filter(author=obj).order_by('-created_on')
            context = {
                'other_user': obj,
                'username': usern,
                'userid': user_id,
                'question_asked': question_asked,
                'comments_made': comments_made,
                'question_asked': question_asked,
                'experience': experience,
                'user_posts': user_posts,
                'teleporter': teleporter_message,
            }

            return render(request, 'otheruser.html', context)

        except ObjectDoesNotExist:
            messages.error(request, 'User not found.')
            return redirect('myaccount')  # Redirect to a different page
    return redirect('myaccount')

def search_user(request):
    username_query = request.GET.get('username')
    users = CustomUser.objects.filter(username__icontains=username_query)
    user_data = [{'username': user.username} for user in users]
    return JsonResponse({'users': user_data})

def display_userID(request, user_id):
    try:
        obj = CustomUser.objects.get(id=user_id)
        experience = obj.experience
        teleporter_message = obj.teleporter
        question_asked=obj.question_asked
        comments_made=obj.comments_made
        user_posts = Post.objects.filter(author=obj).order_by('-created_on')
        username=obj.username
        context = {
            'other_user': obj,
            'username': username,
            'userid': user_id,
            'question_asked': question_asked,
            'comments_made': comments_made,
            'question_asked': question_asked,
            'experience': experience,
            'user_posts': user_posts,
            'teleporter': teleporter_message,
        }

        return render(request, 'otheruser.html', context)

    except ObjectDoesNotExist:
        messages.error(request, 'User not found.')
        return redirect('myaccount')  # Redirect to a different page
    
@login_required
def update_teleporter(request):
    if request.method == 'POST':
        message = request.POST.get('teleporter')
        teleporter_message=request.user.teleporter
        request.user.teleporter=message
        request.user.save(update_fields=['teleporter'])
        return JsonResponse({'success': True, 'teleporter': teleporter_message,})

        
    return JsonResponse({'success': False})

@login_required
def follow_user(request, user_id):
    user_to_follow = get_object_or_404(CustomUser, id=user_id)
    request.user.following.add(user_to_follow)
    return display_userID(request, user_id)  # Redirect to a suitable view, e.g., user's profile

@login_required
def unfollow_user(request, user_id):
    user_to_unfollow = get_object_or_404(CustomUser, id=user_id)
    request.user.following.remove(user_to_unfollow)
    return display_userID(request, user_id)  # Redirect to a suitable view, e.g., user's profile

@login_required
def get_followed_and_followers(request):
    user = request.user

    # Fetching followed users
    followed_users = user.following.all().values('id', 'username')

    # Fetching followers
    followers = user.followers.all().values('id', 'username')

    return JsonResponse({
        'followed': list(followed_users),
        'followers': list(followers),
    })
    
