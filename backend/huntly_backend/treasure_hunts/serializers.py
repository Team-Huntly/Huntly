from code import interact
from rest_framework import serializers
from .models import TreasureHunt, Clue, Theme, Team, TeamProgress
from users.serializers import UserViewSerializer
from .utils import calc_distance
from django.contrib.auth import get_user_model
import requests
import json

User = get_user_model()

DIST_BUFFER = 0.1
ML_API = 'http://localhost:5000/predict'

class TeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'

    def to_representation(self, instance):
        team_members = UserViewSerializer(instance.team_members, many=True).data
        return {
            'id': instance.id,
            'name': instance.name,
             **({'logo': instance.logo.url} if instance.logo else {}),
            'treasure_hunt': instance.treasure_hunt.id,
            'team_members': team_members
        }


class ClueSerializer(serializers.ModelSerializer):
    class Meta:
        model = Clue
        exclude = ('created_at', 'treasure_hunt')

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

    def create(self, validated_data):
        treasure_hunt_id = self.context.get('treasure_hunt')
        if treasure_hunt_id:
            validated_data['treasure_hunt'] = TreasureHunt.objects.get(id=treasure_hunt_id)
            return Clue.objects.create(**validated_data)
        else :
            raise serializers.ValidationError('Treasure hunt id is required')

    def update(self, instance, validated_data):
        instance.description = validated_data.get('description', instance.description)
        instance.answer_description = validated_data.get('answer_description', instance.answer_description)
        instance.answer_latitude = validated_data.get('answer_latitude', instance.answer_latitude)
        instance.answer_longitude = validated_data.get('answer_longitude', instance.answer_longitude)
        instance.is_qr_based = validated_data.get('is_qr_based', instance.is_qr_based)
        instance.save() 
        return instance


class ThemeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Theme
        fields = '__all__'


class TreasureHuntSerializer(serializers.ModelSerializer):

    class Meta:
        model = TreasureHunt
        fields = ('name', 'started_at', 'ended_at', 'location_latitude', 'location_longitude', 'total_seats', 'team_size', 'theme', 'is_locked')

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
            'total_seats': instance.total_seats,
            'team_size': instance.team_size,
            'theme': ThemeSerializer(instance.theme).data,
            'clues': clues,
            'teams': teams,
            'participants': UserViewSerializer(instance.participants, many=True).data,
            'is_locked': instance.is_locked
        }

    def create(self, validated_data):
        validated_data['created_by'] = self.context.get('request').user
        return TreasureHunt.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.name = validated_data.get('name', instance.name)
        instance.started_at = validated_data.get('started_at', instance.started_at)
        instance.ended_at = validated_data.get('ended_at', instance.ended_at)
        instance.location_latitude = validated_data.get('location_latitude', instance.location_latitude)
        instance.location_longitude = validated_data.get('location_longitude', instance.location_longitude)
        instance.total_seats = validated_data.get('total_seats', instance.total_seats)
        instance.team_size = validated_data.get('team_size', instance.team_size)
        instance.theme = validated_data.get('theme', instance.theme)
        locked = validated_data.get('is_locked', instance.is_locked)    

        if validated_data.get('is_locked') and not instance.is_locked:
            bios =[]
            userids =[]
            for participant in instance.participants.all():
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
    

class TreasureHuntParticipantsSerializer(serializers.ModelSerializer):
    class Meta:
        model = TreasureHunt
        fields = ()

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


class TeamProgressSerializer(serializers.ModelSerializer):
    latitude = serializers.FloatField()
    longitude = serializers.FloatField()

    class Meta:
        model = TeamProgress
        exclude = ('solved_at', 'team',)

    def to_representation(self, instance):
        return {
            'id': instance.id,
            'team': TeamSerializer(instance.team).data,
            'clue': ClueSerializer(instance.clue).data,
            'solved_at': instance.solved_at
        }
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
        
    def create(self, validated_data):
        team_id = self.context.get('team_id')
        team = Team.objects.get(id=team_id)
        validated_data.pop('latitude')
        validated_data.pop('longitude')
        return TeamProgress.objects.create(**validated_data, team=team)

    def update(self, instance, validated_data):
        instance.is_completed = validated_data.get('is_completed', instance.is_completed)
        instance.completed_at = validated_data.get('completed_at', instance.completed_at)
        instance.save()
        return instance


class LeaderboardSerializer(serializers.ModelSerializer):
    class Meta:
        model = TreasureHunt
        fields = ()

    def get_leaderboard(self, instance):
        teams = Team.objects.filter(treasure_hunt=instance)
        teams = TeamSerializer(teams, many=True).data
        for team in teams:
            progress = TeamProgress.objects.filter(team=team['id'], clue__treasure_hunt = instance).order_by('-solved_at')
            team['no_of_clues'] = progress.count()
            if team['no_of_clues'] == 0:
                team['last_solved_at'] = None
            else:
                team['last_clue_solved_at'] = progress.first().solved_at
        teams = sorted(teams, key=lambda k: (k['no_of_clues'], -k['last_clue_solved_at']), reverse=True)
        return teams