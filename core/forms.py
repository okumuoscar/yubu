from django import forms
from .models import Questions

class ReplyForm(forms.ModelForm):
    class Meta:
        models = Questions
        fields = ['reply']