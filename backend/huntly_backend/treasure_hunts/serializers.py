from rest_framework import serializers
from .models import TreasureHunt, Clue, Theme, Team, TeamProgress
from users.serializers import UserViewSerializer


class TeamSerializer(serializers.ModelSerializer):
    class Meta:
        model = Team
        fields = '__all__'

    def to_representation(self, instance):
        team_members = UserViewSerializer(instance.team_members, many=True).data
        return {
            'id': instance.id,
            'name': instance.name,
            'logo': instance.logo.url,
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
        fields = ('name', 'started_at', 'ended_at', 'location_latitude', 'location_longitude', 'total_seats', 'team_size', 'theme', 'participants')

    def to_representation(self, instance):
        clues = Clue.objects.filter(treasure_hunt=instance)
        clues = ClueSerializer(clues, many=True).data
        teams = Team.objects.filter(treasure_hunt=instance)
        teams = TeamSerializer(teams, many=True).data
        return {
            'id': instance.id,
            'name': instance.name,
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
            'participants': UserViewSerializer(instance.participants, many=True).data
        }

    def create(self, validated_data):
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
        instance.participants = validated_data.get('participants', instance.participants)
        instance.save()
        return instance

