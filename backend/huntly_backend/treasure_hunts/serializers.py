from rest_framework import serializers
from .models import TreasureHunt, Clue, Theme, Team, TeamProgress
from rewards.models import Coupon
from users.serializers import UserViewSerializer
from rewards.serializers import CouponSerializer
from .utils import calc_distance
from django.contrib.auth import get_user_model
import requests
import json

User = get_user_model()

DIST_BUFFER = 0.1
ML_API = 'https://huntlymlapi.mixedbag.repl.co/service'


# Serializer for Treasure Hunt Model
class TeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'

    # Function to change the way the object is displayed
    def to_representation(self, instance):
        team_members = UserViewSerializer(instance.team_members, many=True).data
        return {
            'id': instance.id,
            'name': instance.name,
             **({'logo': instance.logo.url} if instance.logo else {}),
            'treasure_hunt': instance.treasure_hunt.id,
            'team_members': team_members
        }


# Serializer for Clue Model
class ClueSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clue
        exclude = ('created_at', 'treasure_hunt')

    # Function to change the way the object is displayed
    def to_representation(self, instance):
        return {
            'id': instance.id,
            'step_no': instance.step_no,
            'created_at': instance.created_at,
            'description': instance.description,
            'answer_description': instance.answer_description,
            'answer_latitude': instance.answer_latitude,
            'answer_longitude': instance.answer_longitude,
            'is_qr_based': instance.is_qr_based,
        }

    # Function to create a new clue
    def create(self, validated_data):
        treasure_hunt_id = self.context.get('treasure_hunt')
        if treasure_hunt_id:
            validated_data['treasure_hunt'] = TreasureHunt.objects.get(id=treasure_hunt_id)
            return Clue.objects.create(**validated_data)
        else :
            raise serializers.ValidationError('Treasure hunt id is required')

    # Function to update a clue
    def update(self, instance, validated_data):
        instance.description = validated_data.get('description', instance.description)
        instance.answer_description = validated_data.get('answer_description', instance.answer_description)
        instance.answer_latitude = validated_data.get('answer_latitude', instance.answer_latitude)
        instance.answer_longitude = validated_data.get('answer_longitude', instance.answer_longitude)
        instance.is_qr_based = validated_data.get('is_qr_based', instance.is_qr_based)
        instance.save()
        return instance


# Serializer for Theme Model
class ThemeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Theme
        fields = '__all__'


# Serializer for Treasure Hunt Model
class TreasureHuntSerializer(serializers.ModelSerializer):

    class Meta:
        model = TreasureHunt
        fields = ('name', 'started_at', 'ended_at', 'location_latitude', 'location_longitude', 'location_name', 'total_seats', 'team_size', 'theme', 'is_locked')

    # Function to change the way the object is displayed
    def to_representation(self, instance):
        clues = Clue.objects.filter(treasure_hunt=instance)
        clues = ClueSerializer(clues, many=True).data
        teams = Team.objects.filter(treasure_hunt=instance)
        teams = TeamSerializer(teams, many=True).data
        return {
            'id': instance.id,
            'name': instance.name,
            'created_by': UserViewSerializer(instance.created_by).data,
            'created_at': instance.created_at,
            'started_at': instance.started_at,
            'ended_at': instance.ended_at,
            'location_latitude': instance.location_latitude,
            'location_longitude': instance.location_longitude,
            'location_name': instance.location_name,
            'total_seats': instance.total_seats,
            'team_size': instance.team_size,
            'theme': ThemeSerializer(instance.theme).data,
            'clues': clues,
            'teams': teams,
            'participants': UserViewSerializer(instance.participants, many=True).data,
            'is_locked': instance.is_locked
        }

    # Function to create a new treasure hunt
    def create(self, validated_data):
        validated_data['created_by'] = self.context.get('request').user
        return TreasureHunt.objects.create(**validated_data)

    # Function to update a treasure hunt
    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.started_at = validated_data.get('started_at', instance.started_at)
        instance.ended_at = validated_data.get('ended_at', instance.ended_at)
        instance.location_latitude = validated_data.get('location_latitude', instance.location_latitude)
        instance.location_longitude = validated_data.get('location_longitude', instance.location_longitude)
        instance.location_name = validated_data.get('location_name', instance.location_name)
        instance.total_seats = validated_data.get('total_seats', instance.total_seats)
        instance.team_size = validated_data.get('team_size', instance.team_size)
        instance.theme = validated_data.get('theme', instance.theme)
        locked = validated_data.get('is_locked', instance.is_locked)

        if validated_data.get('is_locked') and not instance.is_locked and len(instance.participants.all()) >= 2*instance.team_size:
            bios =[]
            userids =[]
            for participant in instance.participants.all():
                interests={}
                if (participant.interests):
                    interests = json.loads(participant.interests)
                interests_string = ''
                for i in interests:
                    interests_string += interests[i] + ' '
                bios.append(participant.bio+' '+ interests_string)
                userids.append(participant.id)
            response = requests.post(ML_API, json={
            'team_size': instance.team_size,
             'bios': bios })
            if response.status_code == 200:
                instance.is_locked = locked
                instance.save()
                data = response.json()
                for i in data:
                    team = Team.objects.create(name='Team'+str(i), treasure_hunt=instance)
                    for j in data[i]:
                        team.team_members.add(User.objects.get(id=userids[j]))
                    team.save()
                return instance
            else:
                raise serializers.ValidationError('Error in forming teams')
        else:
            instance.is_locked = locked
            instance.save()
            return instance

    # Function to fetch rewards for a treasure hunt
    def get_rewards(self, instance):
        coupons =  Coupon.objects.filter(treasure_hunt=instance)
        coupons = CouponSerializer(coupons, many=True).data
        return coupons


# Serializer for Treasure Hunt Participants
class TreasureHuntParticipantsSerializer(serializers.ModelSerializer):
    class Meta:
        model = TreasureHunt
        fields = ()

    # Function to add a participant to a treasure hunt
    def register_participant(self, instance):
        user = self.context.get('request').user
        if user is not None:
            treasure_hunt = instance
            if treasure_hunt.participants.filter(id=user.id).exists():
                raise serializers.ValidationError('User is already registered')
            if treasure_hunt.is_locked:
                raise serializers.ValidationError('Registration is closed')
            treasure_hunt.participants.add(user)
            treasure_hunt.save()
            return treasure_hunt
        raise serializers.ValidationError('User not found')

    # Function to remove a participant from a treasure hunt
    def unregister_participant(self, instance):
        user = self.context.get('request').user
        if user is not None:
            treasure_hunt = instance
            if not treasure_hunt.participants.filter(id=user.id).exists():
                raise serializers.ValidationError('User is not registered')
            if treasure_hunt.is_locked:
                raise serializers.ValidationError('Registration is locked')
            treasure_hunt.participants.remove(user)
            treasure_hunt.save()
            return treasure_hunt
        raise serializers.ValidationError('User not found')


# Serializer for Team Progress Model
class TeamProgressSerializer(serializers.ModelSerializer):
    latitude = serializers.FloatField()
    longitude = serializers.FloatField()

    class Meta:
        model = TeamProgress
        exclude = ('solved_at', 'team',)

    # Function to change the way the object is displayed
    def to_representation(self, instance):
        return {
            'id': instance.id,
            'team': TeamSerializer(instance.team).data,
            'clue': ClueSerializer(instance.clue).data,
            'solved_at': instance.solved_at
        }

    # Function to validate the data recieved in the request
    def validate(self, data):
        latitude = data.get('latitude')
        longitude = data.get('longitude')
        if latitude is None or longitude is None:
            raise serializers.ValidationError('Latitude and longitude are required')
        distance = calc_distance(float(latitude), float(longitude), float(data.get('clue').answer_latitude), float(data.get('clue').answer_longitude))
        if distance > DIST_BUFFER:
            raise serializers.ValidationError('You are not at the correct location')
        super().validate(data)
        return data

    # Function to create a new team progress
    def create(self, validated_data):
        team_id = self.context.get('team_id')
        team = Team.objects.get(id=team_id)
        validated_data.pop('latitude')
        validated_data.pop('longitude')
        return TeamProgress.objects.create(**validated_data, team=team)

    # Function to update a team progress
    def update(self, instance, validated_data):
        instance.is_completed = validated_data.get('is_completed', instance.is_completed)
        instance.completed_at = validated_data.get('completed_at', instance.completed_at)
        instance.save()
        return instance


# Serializer for Leaderboard
class LeaderboardSerializer(serializers.ModelSerializer):
    class Meta:
        model = TreasureHunt
        fields = ()

    # Function to fetch the leaderboard for a treasure hunt
    def get_leaderboard(self, instance):
        teams = Team.objects.filter(treasure_hunt=instance)
        teams = TeamSerializer(teams, many=True).data
        leaderboard_teams = []
        other_teams = []
        for team in teams:
            progress = TeamProgress.objects.filter(team=team['id'], clue__treasure_hunt = instance).order_by('-solved_at')
            team['no_of_clues'] = progress.count()
            if team['no_of_clues'] == 0:
                team['last_solved_at'] = None
                other_teams.append(team)
            else:
                team['last_solved_at'] = progress.first().solved_at
                leaderboard_teams.append(team)
        leaderboard_teams = sorted(leaderboard_teams, key=lambda k: (k['no_of_clues'], -k['last_solved_at'].timestamp()), reverse=True)
        leaderboard_teams.extend(other_teams)
        return teams
