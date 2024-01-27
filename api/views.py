from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from core.models import Questions
from .serializers import QuestionSerializer
from django.http import JsonResponse

# Create your views here.
@api_view(['GET'])
def question_list(request):
    queryset = Questions.objects.all()
    serializer = QuestionSerializer(queryset, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def question_create(request):
    if request.method == 'POST':
        serializer = QuestionSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        else:
            return Response(serializer.errors)
    else:
        return Response('Invalid Methods')

@api_view(['GET'])  
def question_api_detail(request, question_id):
    try:
        # Retrieve the question instance
        question = Questions.objects.get(pk=question_id)
        # Prepare the data to return in JSON format
        data = {
            'id': question.id,
            'name': question.name,
            'email': question.email,
            'phone': question.phone,
            'message': question.message,
            'created_at': question.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            'reply': question.reply
        }
        return JsonResponse(data)
    except Questions.DoesNotExist:
        return JsonResponse({'error': 'Question not found'}, status=404)