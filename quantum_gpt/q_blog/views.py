from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from .forms import PostForm
from .models import Post, Comment
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.core.files.storage import FileSystemStorage

@login_required
def create_post(request):
    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user  # Assuming you have an author field in your Post model
            post.save()
            # Redirect to the detail view of the blog post or any other appropriate page
            return redirect('blog_detail', post.id)
    else:
        form = PostForm()

    return render(request, 'create_post.html', {'form': form})

@login_required
def edit_post(request, post_id):
    post = get_object_or_404(Post, id=post_id)

    # Check if the current user is the author of the post
    if post.author != request.user:
        return redirect('blog_detail', post.id)  # or some other appropriate action

    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES, instance=post)
        if form.is_valid():
            form.save()
            return redirect('blog_detail', post.id)
    else:
        form = PostForm(instance=post)

    return render(request, 'edit_post.html', {'form': form, 'post': post})


@csrf_exempt
def add_comment(request, post_id):
    if request.method == 'POST' and request.user.is_authenticated:
        comment_text = request.POST.get('comment')
        post = get_object_or_404(Post, id=post_id)
        
        # Create and save the new comment
        Comment.objects.create(post=post, author=request.user, body=comment_text)

        return JsonResponse({'status': 'success', 'message': 'Comment added successfully'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Invalid request'}, status=400)

def blog_detail(request, post_id):
    post = get_object_or_404(Post, pk=post_id)
    return render(request, 'blog_detail.html', {'post': post})

def blog_index(request):
    posts = Post.objects.all().order_by('-created_on')  # Assuming 'created_on' is a field in your Post model
    return render(request, 'blog_index.html', {'posts': posts})

@csrf_exempt
def image_upload_view(request):
    if request.method == 'POST':
        image = request.FILES.get('upload')
        fs = FileSystemStorage()
        filename = fs.save("uploaded_images/" + image.name, image)
        image_url = fs.url(filename)

        return JsonResponse({
            'uploaded': 1,
            'fileName': filename,
            'url': image_url
        })

    return JsonResponse({'uploaded': 0}, status=400)

@login_required
def delete_post(request, post_id):
    post = get_object_or_404(Post, id=post_id)

    # Check if the logged-in user is the author of the post
    if request.user != post.author:
        # Redirect them if they're not the author
        return redirect('blog_detail', post.id)

    post.delete()
    return redirect('blog_index')  # Redirect to a safe page after deletion
