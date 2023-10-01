from django.shortcuts import render
from django.http import JsonResponse
import openai
from decouple import config
from django.contrib.auth.decorators import login_required
from .models import UserComment
from django.db.models import F
#from .models import Session, QuestionResponse

openai.api_key = config('OPENAI_API_KEY')

# Create your views here.

@login_required
def ask_question(request):
    if request.method == 'POST':
        question = request.POST.get('question')
        modelType=request.POST.get('modelType')
        # Process the question and get the response
        if modelType=="GPT4":
            if request.user.question_token < 5:
                return JsonResponse({
                    'error': 'Not enough tokens. Please comment a response, or peer review another comment to earn tokens. Free tokens will be added to your account by the end of every week',
                })
            model_used="gpt-4"
            request.user.question_token = F('question_token') - 5
        else:
            if request.user.question_token <= 0:
                return JsonResponse({
                    'error': 'Not enough tokens. Please comment a response, or peer review another comment to earn tokens. Free tokens will be added to your account by the end of every week',
                })
            model_used="gpt-3.5-turbo"
            request.user.question_token = F('question_token') - 1
        response = openai.ChatCompletion.create(
            model=model_used,
            temperature=0.2,
            max_tokens=800,
            messages=[{"role": "system", "content": """You are QuantumGPT, an online tool that can answer quantum-related questions accurately.
                       QuantumGPT is developed by Xiang's team in September 2023, using ChatGPT API and prompt engineering."""}, 
               {"role": "user", "content": question}, 
               {"role": "assistant", "content": """Here are some facts, answer the question using these facts if relevant. Quantum hamming bound
is not quantum Gilbert-Varshamov bound. The parameter of a non-degenerate quantum code must obey the Hamming bound. An important open question in
quantum coding theory is whether or not the parameters of a degenerate quantum code can violate this bound for non-degenerate quantum codes. There
is no proof stating that degenerate codes shold obey such bound. However, there has been much work done to show that many degenerate quantum codes
must also obey this bound."""}],
        )
        
        request.user.question_asked = F('question_asked') + 1
        request.user.experience = F('experience') + 1
        request.user.save(update_fields=['question_token','question_asked', 'experience'])
        request.user.refresh_from_db()
        question_token=request.user.question_token
        question_asked=request.user.question_asked
        return JsonResponse({'response': response["choices"][0]["message"]["content"], 'question_left': question_token, 'question_asked': question_asked,})
    return JsonResponse({'error': 'Only POST requests are allowed'}, status=400)


def submit_comment(request):
    if request.method == 'POST':
        question_get =  request.POST.get('question')
        response_get = request.POST.get('response')
        comment_get = request.POST.get('comment')
        user_id_get = request.POST.get('user_id')
        correctness_get=request.POST.get('correctness')
        modelType_get=request.POST.get('modelType')

        # Process the data as needed, e.g., save to the database
        comment_entry = UserComment(user_id=user_id_get, response=response_get, comment=comment_get, question=question_get, correctness=correctness_get, modelType=modelType_get)
        comment_entry.save()
        request.user.comments_made=F('comments_made') + 1
        request.user.question_token = F('question_token') + 20
        request.user.experience = F('experience') + 10
        request.user.save(update_fields=['question_token','comments_made', 'experience'])
        request.user.refresh_from_db()
        question_token=request.user.question_token
        comments_made=request.user.comments_made
        
        return JsonResponse({'success': True, 'question_left': question_token, 'comments_made': comments_made})

    return JsonResponse({'success': False})

def check_token(request):
    # Fetch the number of questions left and comments made.
    if request.user.is_authenticated:
        question_token = request.user.question_token
        comments_made = request.user.comments_made
        question_asked=request.user.question_asked
    else:
        questions_left = 0
        comments_made = 0
        question_asked=0

    context = {
        'question_left': question_token,
        'comments_made': comments_made,
        'question_asked': question_asked,
    }

    return render(request, 'app.html', context)
