from rest_framework import generics, status
from rest_framework.response import Response
from .serializers import TreasureHuntSerializer, ThemeSerializer
from .models import TreasureHunt, Theme

class TreasureHuntListAPIView(generics.ListAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer

class TreasureHuntCreateAPIView(generics.CreateAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer

class TreasureHuntRetrieveAPIView(generics.RetrieveAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'

class TreasureHuntUpdateAPIView(generics.UpdateAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'

class TreasureHuntDeleteAPIView(generics.DestroyAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'

class ThemeListAPIView(generics.ListAPIView):
    queryset = Theme.objects.all()
    serializer_class = ThemeSerializer