from django.db import models
from email.policy import default
from django.contrib.auth import get_user_model

# Create your models here.

User = get_user_model()

# Create your models here.
class TreasureHunt(models.Model):
    name =  models.CharField(max_length = 256)
    created_at = models.DateField(auto_now_add = True)
    started_at = models.DateField()
    ended_at = models.DateField()
    location_latitude = models.CharField(max_length = 30)
    location_longitude = models.CharField(max_length = 30)
    total_seats = models.IntegerField()
    team_size = models.IntegerField()
    theme = models.ForeignKey('Theme', blank=False, null=False, on_delete = models.CASCADE)

    def _str_(self):
        return self.name

class Clue(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE)
    step_no = models.IntegerField()
    description = models.TextField(blank=True, null=True)
    created_at = models.DateField(auto_now_add = True)
    answer_description = models.TextField(blank=True, null=True)
    answer_latitude = models.CharField(max_length = 30)
    answer_longitude = models.CharField(max_length = 30)
    is_qr_based = models.BooleanField()

    def _str_(self):
        return self.description

class Theme(models.Model):
    name = models.CharField(max_length = 256)
    description = models.TextField(blank=True, null=True)

    def _str_(self):
        return self.name

class Team(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE)
    name = models.CharField(max_length = 256)
    team_members = models.ManyToManyField(User)
    logo = models.ImageField(upload_to='team_logos', blank=True, null=True)
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE)

    def _str_(self):
        return self.name

class TeamProgress(models.Model):
    clue = models.ForeignKey(Clue, blank=False, null = False, on_delete=models.CASCADE)
    solved_at = models.DateField(auto_now_add = True)
    team = models.ForeignKey(TreasureHunt, blank= False, null = False, on_delete=models.CASCADE)

    def _str_(self):
        return self.clue.id + ' ' + self.team.name


class Preset(models.Model):
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=False, null = False, on_delete=models.CASCADE)

    def _str_(self):
        return self.treasure_hunt.name
