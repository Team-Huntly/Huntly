from asyncore import read
from django.db import models
from email.policy import default
from django.contrib.auth import get_user_model
from django.core.validators import MinValueValidator

# Create your models here.

User = get_user_model()

# Create your models here.
class TreasureHunt(models.Model):
    STATUS_CHOICES = (
        ('O', 'Open'),
        ('A', 'Allotted'),
        ('C', 'Cancelled'),
        ('F', 'Finished'),
    )
    name =  models.CharField(max_length = 256)
    created_at = models.DateTimeField(auto_now_add=True)
    started_at = models.DateTimeField()
    ended_at = models.DateTimeField()
    location_latitude = models.CharField(max_length = 30)
    location_longitude = models.CharField(max_length = 30)
    location_name = models.CharField(max_length = 256, blank=True, null=True)
    total_seats = models.IntegerField(validators=[MinValueValidator(1)])
    team_size = models.IntegerField(validators=[MinValueValidator(1)])
    theme = models.ForeignKey('Theme', blank=True, null=True, on_delete = models.CASCADE, related_name='treasure_hunts_theme')
    participants = models.ManyToManyField(User, blank=True)
    created_by = models.ForeignKey(User, on_delete = models.CASCADE, blank=True, null=True, related_name='treasure_hunts_created_by')
    is_locked = models.BooleanField(default=False)
    status = models.CharField(max_length=1, choices = STATUS_CHOICES, default='O', null=False, blank=False)

    def __str__(self):
        return self.name

class Clue(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE, related_name='clues_treasure_hunt')
    step_no = models.IntegerField(validators=[MinValueValidator(1)])
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add = True)
    answer_description = models.TextField(blank=True, null=True)
    answer_latitude = models.CharField(max_length = 30)
    answer_longitude = models.CharField(max_length = 30)
    is_qr_based = models.BooleanField()

    def __str__(self):
        return self.description

class Theme(models.Model):
    name = models.CharField(max_length = 256)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.name

class Team(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE, related_name='teams_treasure_hunt')
    name = models.CharField(max_length = 256)
    team_members = models.ManyToManyField(User)
    logo = models.ImageField(upload_to='team_logos', blank=True, null=True)

    def __str__(self):
        return self.name

class TeamProgress(models.Model):
    clue = models.ForeignKey(Clue, blank=False, null=False,on_delete=models.CASCADE, related_name='team_progress_clue')
    solved_at = models.DateTimeField(auto_now_add = True)
    team = models.ForeignKey(Team, blank= False, null = False, on_delete=models.CASCADE, related_name='team_progress_team')

    def __str__(self):
        return str(self.clue.id) + ' ' + self.team.name


class Preset(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE, related_name='presets_treasure_hunt')

    def __str__(self):
        return self.treasure_hunt.name
