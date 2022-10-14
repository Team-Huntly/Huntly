from rest_framework import serializers
from .models import Memory
from users.serializers import UserViewSerializer
from django.contrib.auth import get_user_model
import requests
import json

User = get_user_model()

class MemorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Memory
        exclude = ('clicked_by',)

    def to_representation(self, instance):
        return {
            'id': instance.id,
            'clicked_by': UserViewSerializer(instance.clicked_by).data,
            'image': instance.image.url,
            'added_at': instance.added_at
        }

    def create(self, validated_data):
        validated_data['clicked_by'] = self.context.get('request').user
        memory = Memory.objects.create(**validated_data)
        return memory