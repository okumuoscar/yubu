from django.urls import path 
from . import views 

urlpatterns = [
    path('question_list/', views.question_list, name='question-list'),
    path('question_create/', views.question_create, name='question-create'),
    path('question_detail/<int:question_id>/', views.question_api_detail, name='api_detail'),
]