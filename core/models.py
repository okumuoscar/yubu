from django.db import models

# Create your models here.
class Questions(models.Model):
    id = models.BigAutoField(primary_key=True)
    name = models.CharField(max_length=100)
    email = models.EmailField(max_length=100,unique=True)
    phone = models.PositiveIntegerField()
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    reply = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name
    
    class Meta:
        verbose_name = ('Question')
        verbose_name_plural = ('Questions')

