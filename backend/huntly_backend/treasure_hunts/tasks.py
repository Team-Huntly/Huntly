from django_q.tasks import async_task, result
from django_q.models import Schedule
import requests
import random
from django.contrib.auth import get_user_model
from .models import TreasureHunt, Team, TeamProgress
from rewards.models import Coupon
from datetime import datetime, timedelta
import json


User = get_user_model()
ML_API = 'https://huntlymlapi.mixedbag.repl.co/service'

def form_teams():
    #  Filter treasure hunts that are open and have started_at within 30min from now
    treasure_hunts = TreasureHunt.objects.filter(status='O', started_at__gte=datetime.now() - timedelta(minutes=30))
    print(f"Forming teams for {treasure_hunts.count()} treasure hunts")
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
                print("ML API failed, creating random teams")
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


def distribute_rewards():
    print("Distributing rewards")
    # Filter treasure hunts that are allotted and ended_at less than current time
    treasure_hunts = TreasureHunt.objects.filter(status='A', ended_at__lte=datetime.now())
    print(f"Distributing rewards for {treasure_hunts.count()} treasure hunts")
    for treasure_hunt in treasure_hunts:
        #  Check if rewards are not yet distributed
        if Coupon.objects.filter(treasure_hunt=treasure_hunt).count() == 0:
            #  Calculate Leaderboard Teams
            leaderboard_teams = []
            for team in treasure_hunt.teams.all():
                progress = TeamProgress.objects.filter(team=team['id'], clue__treasure_hunt = treasure_hunt).order_by('-solved_at')
                team['no_of_clues'] = progress.count()
                if team['no_of_clues'] != 0:
                    team['last_solved_at'] = progress.first().solved_at
                    leaderboard_teams.append({
                        'id': team['id'],
                        'name': team['name'],
                        'no_of_clues': team['no_of_clues'],
                        'last_solved_at': team['last_solved_at']
                    })
                leaderboard_teams = sorted(leaderboard_teams, key=lambda k: (k['no_of_clues'], -k['last_solved_at'].timestamp()), reverse=True)

            # Allot random coupons to all members of first 3 leaderboard teams
            available_coupons = list(Coupon.objects.filter(treasure_hunt=None, user=None, expiry_date__gte=datetime.now()))
            num_teams = min(3, len(leaderboard_teams))
            if len(available_coupons) >= num_teams*treasure_hunt.team_size:
                selected_coupons = random.sample(available_coupons, num_teams*treasure_hunt.team_size)
                count=0
                for team in leaderboard_teams[:num_teams]:
                    for user in team.team_members.all():
                        selected_coupons[count].user = user
                        selected_coupons[count].save()
                        count+=1
            else:
                print("Not enough coupons")

            #  Change status to Finished
            treasure_hunt.status = 'F'
            treasure_hunt.save()