from django_cron import CronJobBase, Schedule
from .models import TreasureHunt, Team
from rewards.models import Coupon
from datetime import datetime, timedelta
import requests
import json
from django.contrib.auth import get_user_model

User = get_user_model()
ML_API = 'https://huntlymlapi.mixedbag.repl.co/service'

class FormTeamsCronJob:
    RUN_EVERY_MINS = 5 
    RETRY_AFTER_FAILURE_MINS = 1
    schedule = Schedule(run_every_mins=RUN_EVERY_MINS, retry_after_failure_mins=RETRY_AFTER_FAILURE_MINS)
    code = 'treasure_hunts.cron.FormTeamsCronJob' 

    def do(self):
        #  Filter treasure hunts that are open and have started_at within 30min from now
        treasure_hunts = TreasureHunt.objects.filter(status='O', started_at__gte=datetime.now() - timedelta(minutes=30))
        for treasure_hunt in treasure_hunts:
            if treasure_hunt.participants.count() >= 2*treasure_hunt.team_size+1:
                #  Form teams
                bios =[]
                userids =[]
                for participant in treasure_hunt.participants.all():
                    interests={}
                    if (participant.interests):
                        interests = json.loads(participant.interests)
                    interests_string = ''
                    for i in interests:
                        interests_string += interests[i] + ' '
                    bios.append(participant.bio+' '+ interests_string)
                    userids.append(participant.id)
                response = requests.post(ML_API, json={
                    'team_size': treasure_hunt.team_size,
                    'bios': bios 
                })
                if response.status_code == 200:
                    data = response.json()
                    for i in data:
                        team = Team.objects.create(name='Team'+str(i), treasure_hunt=treasure_hunt)
                        for j in data[i]:
                            team.team_members.add(User.objects.get(id=userids[j]))
                        team.save()
                else:
                    # Create random teams if ML API fails
                    participants = treasure_hunt.participants.all()
                    for i in range(0, len(participants), treasure_hunt.team_size):
                        team = Team.objects.create(name='Team'+str(i), treasure_hunt=treasure_hunt)
                        for j in range(i, i+treasure_hunt.team_size):
                            if j < len(participants):
                                team.team_members.add(participants[j])
                        team.save()

                #  Change status to Allotted
                treasure_hunt.status = 'A'
                treasure_hunt.save()
            else:
                #  Change status to Cancelled
                treasure_hunt.status = 'C'
                treasure_hunt.save()


# class DistributeRewardsCronJob:
#     RUN_EVERY_MINS = 5 
#     RETRY_AFTER_FAILURE_MINS = 1
#     schedule = Schedule(run_every_mins=RUN_EVERY_MINS, retry_after_failure_mins=RETRY_AFTER_FAILURE_MINS)
#     code = 'treasure_hunts.cron.DistributeRewardsCronJob' 

#     def do(self):
#         # Filter treasure hunts that are allotted and ended_at less than current time
#         treasure_hunts = TreasureHunt.objects.filter(status='A', ended_at__lte=datetime.now())
#         for treasure_hunt in treasure_hunts:
#             #  Check if rewards are not yet distributed
#             if Coupon.objects.filter(treasure_hunt=treasure_hunt).count() == 0:
#                 #  Distribute rewards
#                 for team in treasure_hunt.teams.all():

#                 #  Change status to Finished
#                 treasure_hunt.status = 'F'
#                 treasure_hunt.save()