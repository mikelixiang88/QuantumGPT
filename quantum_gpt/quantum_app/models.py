#from django.contrib.auth.models import User
from django.db import models

#class Session(models.Model):
#    user = models.ForeignKey(User, on_delete=models.CASCADE)
#    session_number = models.PositiveIntegerField()

#class QuestionResponse(models.Model):
#    session = models.ForeignKey(Session, on_delete=models.CASCADE)
#    question = models.TextField()
#    response = models.TextField()


class UserComment(models.Model):
    CORRECTNESS_CHOICES = [
        ('correct', 'correct'),
        ('incorrect', 'incorrect'),
        ('partial_correct', 'partial_correct'),
        ('not_classified', 'not_classified'),
        ('doubts', 'doubts'),
    ]
    user = models.ForeignKey('quantum_accounts.CustomUser', on_delete=models.CASCADE)
    response = models.TextField()
    comment = models.TextField()
    question = models.TextField(default="sample_question")
    correctness = models.CharField(max_length=15, choices=CORRECTNESS_CHOICES, default='not_classified')
    modelType=models.CharField(max_length=20, default='GPT3.5')
    followup=models.IntegerField(default=0)
    
    def __str__(self):
        return self.question

class Comment_C(models.Model):
    user = models.ForeignKey('quantum_accounts.CustomUser', on_delete=models.CASCADE)
    comment = models.TextField()
    discussion_id=models.ForeignKey(UserComment, on_delete=models.CASCADE, related_name='comments')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at']
    
    def __str__(self):
        return self.question
