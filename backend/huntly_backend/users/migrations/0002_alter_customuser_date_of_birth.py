# Generated by Django 4.1.2 on 2022-10-13 18:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='date_of_birth',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
