# Generated by Django 4.1.2 on 2022-10-13 18:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0003_alter_customuser_date_of_birth'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='interests',
            field=models.TextField(blank=True, null=True),
        ),
    ]
