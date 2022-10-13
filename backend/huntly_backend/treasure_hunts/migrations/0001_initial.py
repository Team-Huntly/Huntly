# Generated by Django 4.1.2 on 2022-10-13 16:27

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Clue',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('step_no', models.IntegerField()),
                ('description', models.TextField(blank=True, null=True)),
                ('created_at', models.DateField(auto_now_add=True)),
                ('answer_description', models.TextField(blank=True, null=True)),
                ('answer_latitude', models.CharField(max_length=30)),
                ('answer_longitude', models.CharField(max_length=30)),
                ('is_qr_based', models.BooleanField()),
            ],
        ),
        migrations.CreateModel(
            name='Theme',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=256)),
                ('description', models.TextField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='TreasureHunt',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=256)),
                ('started_at', models.DateField(auto_now_add=True)),
                ('ended_at', models.DateField(auto_now_add=True)),
                ('location_latitude', models.CharField(max_length=30)),
                ('location_longitude', models.CharField(max_length=30)),
                ('total_seats', models.IntegerField()),
                ('team_size', models.IntegerField()),
                ('no_of_clues', models.IntegerField()),
                ('theme', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='treasure_hunts.theme')),
            ],
        ),
        migrations.CreateModel(
            name='TeamProgress',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('solved_at', models.DateField(auto_now_add=True)),
                ('clue', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='treasure_hunts.clue')),
                ('team', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='treasure_hunts.treasurehunt')),
            ],
        ),
        migrations.CreateModel(
            name='Team',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=256)),
                ('logo', models.ImageField(blank=True, null=True, upload_to='team_logos')),
                ('team_members', models.ManyToManyField(to=settings.AUTH_USER_MODEL)),
                ('treasure_hunt', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='treasure_hunts.treasurehunt')),
            ],
        ),
        migrations.AddField(
            model_name='clue',
            name='treasure_hunt',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='treasure_hunts.treasurehunt'),
        ),
    ]
