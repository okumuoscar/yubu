# Generated by Django 4.2.6 on 2024-01-23 08:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_alter_questions_phone'),
    ]

    operations = [
        migrations.AddField(
            model_name='questions',
            name='reply',
            field=models.TextField(blank=True, null=True),
        ),
    ]
