from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser

class CustomUser(AbstractUser):
    # Add any additional fields here if needed
    question_token=models.IntegerField(default=20)
    question_asked=models.IntegerField(default=0)
    comments_made=models.IntegerField(default=0)
    experience=models.IntegerField(default=0)
    teleporter=models.TextField(default="The teleporter is empty")
    following = models.ManyToManyField('self', related_name='followers', symmetrical=False, blank=True)
    pass
