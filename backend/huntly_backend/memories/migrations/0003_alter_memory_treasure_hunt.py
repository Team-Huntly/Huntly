# Generated by Django 4.1.2 on 2022-10-13 21:05

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('treasure_hunts', '0006_treasurehunt_created_by_alter_clue_treasure_hunt_and_more'),
        ('memories', '0002_alter_memory_added_at'),
    ]

    operations = [
        migrations.AlterField(
            model_name='memory',
            name='treasure_hunt',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='memories_treasure_hunt', to='treasure_hunts.treasurehunt'),
        ),
    ]