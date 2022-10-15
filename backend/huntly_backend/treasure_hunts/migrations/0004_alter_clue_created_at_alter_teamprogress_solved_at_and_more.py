# Generated by Django 4.1.2 on 2022-10-13 18:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('treasure_hunts', '0003_remove_treasurehunt_no_of_clues_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='clue',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True),
        ),
        migrations.AlterField(
            model_name='teamprogress',
            name='solved_at',
            field=models.DateTimeField(auto_now_add=True),
        ),
        migrations.AlterField(
            model_name='treasurehunt',
            name='created_at',
            field=models.DateTimeField(auto_now_add=True),
        ),
        migrations.AlterField(
            model_name='treasurehunt',
            name='ended_at',
            field=models.DateTimeField(),
        ),
        migrations.AlterField(
            model_name='treasurehunt',
            name='started_at',
            field=models.DateTimeField(),
        ),
    ]