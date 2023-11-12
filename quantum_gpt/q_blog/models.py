from django.db import models
from django.contrib.auth.models import User
from ckeditor.fields import RichTextField

class Post(models.Model):
    title = models.CharField(max_length=200)
    content = RichTextField()
    author = models.ForeignKey(
        'quantum_accounts.CustomUser',
        on_delete=models.CASCADE
    )
    created_on = models.DateTimeField(auto_now_add=True)
    #image = models.ImageField(upload_to='blog_images/', blank=True, null=True)

    def __str__(self):
        return self.title
    
class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments')
    author = models.ForeignKey(
        'quantum_accounts.CustomUser',
        on_delete=models.CASCADE
    )
    body = models.TextField()
    created_on = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Comment {self.body} by {self.name}'


