# Generated by Django 4.1.2 on 2022-10-13 18:08

from django.conf import settings
from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('treasure_hunts', '0002_preset'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='treasurehunt',
            name='no_of_clues',
        ),
        migrations.AddField(
            model_name='treasurehunt',
            name='created_at',
            field=models.DateField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='treasurehunt',
            name='participants',
            field=models.ManyToManyField(to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='treasurehunt',
            name='ended_at',
            field=models.DateField(),
        ),
        migrations.AlterField(
            model_name='treasurehunt',
            name='started_at',
            field=models.DateField(),
        ),
    ]
