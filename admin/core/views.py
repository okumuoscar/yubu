from django.shortcuts import render, redirect, get_object_or_404, HttpResponse
from .models import Questions   
import requests
from django.core.mail import send_mail
from .forms import ReplyForm
from django.conf import settings
from django.contrib.auth.decorators import login_required


# Create your views here.
@login_required
def index(request):
    response = requests.get('http://127.0.0.1:8000/api/question_list/').json()
    response_reverse = list(reversed(response))
    return render(request, 'index.html',{'response':response_reverse})

@login_required
def about(request):
    return render(request, 'about.html')

# deleting questions 
@login_required
def questionDelete(request, pk):
    item = Questions.objects.get(id=pk)
    if request.method == 'POST':
        item.delete()
        return redirect('/')
    context = {'item':item}
    return render(request,'delete.html', context)


@login_required
def question_detail(request, question_id):
    # Retrieve the question instance from the database
    question = get_object_or_404(Questions, pk=question_id)

    
    api_url = f'http://127.0.0.1:8000/api/questions_detail/{question_id}'
    try:
        # Fetch additional details from the API
        response = requests.get(api_url)
        if response.status_code == 200:
            api_data = response.json()
            question.name = api_data.get('name')
            question.email = api_data.get('email')
            question.phone = api_data.get('phone')

    except requests.RequestException as e:
        # Handle API request errors
        print(f"Error fetching data from API: {e}")

    if request.method == 'POST':
        # Extracting user input from the form
        reply_message = request.POST.get('reply')

        # Build the email subject and body
        subject = f"Re: Your Inquiry: {question.message[:50]}"
        body = f"Dear {question.name},\n\nThank you for your inquiry:\n\n{question.message}\n\nHere is our reply:\n\n{reply_message}"

        # Send email
        send_mail(
            subject,
            body,
            'oscarlincoln520@gmail.com',  
            [question.email],
            fail_silently=False,
        )

        # Update the question instance with the reply
        question.reply = reply_message
        question.save()

        return HttpResponse("Reply sent successfully!")  

    return render(request, 'detail.html', {'question': question})
