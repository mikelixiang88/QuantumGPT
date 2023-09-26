#from django.contrib.auth.models import User
from django.db import models

#class Session(models.Model):
#    user = models.ForeignKey(User, on_delete=models.CASCADE)
#    session_number = models.PositiveIntegerField()

#class QuestionResponse(models.Model):
#    session = models.ForeignKey(Session, on_delete=models.CASCADE)
#    question = models.TextField()
#    response = models.TextField()

from django.db import models

class UserComment(models.Model):
    CORRECTNESS_CHOICES = [
        ('correct', 'correct'),
        ('incorrect', 'incorrect'),
        ('partial_correct', 'partial_correct'),
        ('not_classified', 'not_classified')
    ]
    username = models.CharField(max_length=255)
    response = models.TextField()
    comment = models.TextField()
    question = models.TextField(default="sample_question")
    correctness = models.CharField(max_length=15, choices=CORRECTNESS_CHOICES, default='not_classified')
    modelType=models.CharField(max_length=20, default='GPT3.5')
    
    def __str__(self):
        return self.username
