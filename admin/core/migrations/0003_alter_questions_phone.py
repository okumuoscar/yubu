# Generated by Django 4.2.6 on 2024-01-23 06:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_alter_questions_options'),
    ]

    operations = [
        migrations.AlterField(
            model_name='questions',
            name='phone',
            field=models.PositiveIntegerField(),
        ),
    ]
