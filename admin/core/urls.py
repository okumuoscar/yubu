from django.urls import path , include
from . import views

urlpatterns = [
    path('', views.index, name='dashboard'),
    path('about/', views.about, name='about'),
    path('delete/<str:pk>/', views.questionDelete, name='question-delete'),
    path('question/<int:question_id>/', views.question_detail, name='question_detail'),
    path('accounts/', include('django.contrib.auth.urls'))
]