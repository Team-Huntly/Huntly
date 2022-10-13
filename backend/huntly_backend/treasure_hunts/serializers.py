from rest_framework import serializers
from .models import TreasureHunt, Clue, Theme, Team, TeamProgress


class ThemeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Theme
        fields = '__all__'


class TreasureHuntSerializer(serializers.ModelSerializer):

    class Meta:
        model = TreasureHunt
        fields = ('name', 'started_at', 'ended_at', 'location_latitude', 'location_longitude', 'total_seats', 'team_size', 'no_of_clues', 'theme')

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
        instance.no_of_clues = validated_data.get('no_of_clues', instance.no_of_clues)
        instance.theme = validated_data.get('theme', instance.theme)
        instance.save()
        return instance

    def to_representation(self, instance):
        return {
            'id': instance.id,
            'name': instance.name,
            'started_at': instance.started_at,
            'ended_at': instance.ended_at,
            'location_latitude': instance.location_latitude,
            'location_longitude': instance.location_longitude,
            'total_seats': instance.total_seats,
            'team_size': instance.team_size,
            'no_of_clues': instance.no_of_clues,
            'theme': ThemeSerializer(instance.theme).data,
        }

