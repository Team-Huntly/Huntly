# Generated by Django 4.1.2 on 2022-10-14 10:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('treasure_hunts', '0009_alter_clue_step_no_alter_treasurehunt_team_size_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='treasurehunt',
            name='location_name',
            field=models.CharField(blank=True, max_length=256, null=True),
        ),
    ]
