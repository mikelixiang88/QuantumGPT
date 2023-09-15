from django.shortcuts import render
from django.http import JsonResponse
import openai
from decouple import config
from django.contrib.auth.decorators import login_required

openai.api_key = config('OPENAI_API_KEY')

# Create your views here.
def generate_prompt(question):
    return """Answer the following question as QuantumGPT, an online tool that
can answer quantum-related questions accurately and rigorously.
Question: Must degenerate quantum error correcting codes obey the quantum
Hamming bound?
Answer: The parameter of a non-degenerate quantum code must obey the Hamming
bound. An important open question in quantum coding theory is whether or not
the parameters of a degenerate quantum code can violate this bound for
non-degenerate quantum codes. There is no proof stating that degenerate
codes shold obey such bound. However, there has been much work done to show
that many degenerate quantum codes must also obey this bound.
Question:{}
Answer:""".format(question)

@login_required
def ask_question(request):
    if request.method == 'POST':
        question = request.POST.get('question')
        # Process the question and get the response
        response = openai.Completion.create(
            model="text-davinci-003",
            prompt=generate_prompt(question),
            temperature=0.2,
            max_tokens=1000,
        )
        return JsonResponse({'response': response.choices[0].text})
    return JsonResponse({'error': 'Only POST requests are allowed'}, status=400)
