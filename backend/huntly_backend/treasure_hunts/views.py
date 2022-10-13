from rest_framework import generics, status
from rest_framework.response import Response
from .serializers import TreasureHuntSerializer, ThemeSerializer, ClueSerializer
from .models import TreasureHunt, Theme, Clue

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


class ClueListAPIView(generics.ListAPIView):
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'treasure_hunt'


class ClueCreateAPIView(generics.CreateAPIView):
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context.update({
            'treasure_hunt': self.kwargs['treasure_hunt']
        })
        return context


class ClueRetrieveAPIView(generics.RetrieveAPIView):
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'


class ClueUpdateAPIView(generics.UpdateAPIView):
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'