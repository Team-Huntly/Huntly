from rest_framework import generics, status
from rest_framework.response import Response
from uritemplate import partial
from .serializers import TreasureHuntSerializer, ThemeSerializer, ClueSerializer, TreasureHuntParticipantsSerializer, \
    TeamProgressSerializer, LeaderboardSerializer, TeamSerializer
from .models import TreasureHunt, Theme, Clue, TeamProgress, Team
from .utils import calc_distance

RADIUS = 10

class TreasureHuntListAPIView(generics.ListAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer

    def get(self, request, *args, **kwargs):
        lat = request.query_params.get('latitude', None)
        lon = request.query_params.get('longitude', None)
        if lat and lon:
            queryset = self.get_queryset()
            for hunt in queryset:
                hunt_distance = calc_distance(float(lat), float(lon), float(hunt.location_longitude), float(hunt.location_longitude))
                if hunt_distance > RADIUS:  
                    queryset = queryset.exclude(id=hunt.id)
                    
            # queryset = sorted(queryset, key=lambda x: x.distance)
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        else:
            return super().get(request, *args, **kwargs)


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


class RegisterParticipantAPIView(generics.UpdateAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntParticipantsSerializer
    http_method_names = ['patch']
    lookup_field = 'id'

    def patch(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        updated_treasure_hunt = TreasureHuntSerializer(serializer.register_participant(instance)).data
        return Response(updated_treasure_hunt, status=status.HTTP_200_OK)


class UnregisterParticipantAPIView(generics.UpdateAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntParticipantsSerializer
    http_method_names = ['patch']
    lookup_field = 'id'

    def patch(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        updated_treasure_hunt = TreasureHuntSerializer(serializer.unregister_participant(instance)).data
        return Response(updated_treasure_hunt, status=status.HTTP_200_OK)

class TeamProgressAPIView(generics.ListAPIView):
    queryset = TeamProgress.objects.all()
    serializer_class = TeamProgressSerializer
    lookup_field = 'id'

    def get_queryset(self):
        team_id = self.kwargs['team_id']
        return TeamProgress.objects.filter(team__id=team_id)

    def get(self, request, *args, **kwargs):
        queryset = self.get_queryset()
        if queryset:
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

class TeamProgressCreateAPIView(generics.CreateAPIView):
    queryset = TeamProgress.objects.all()
    serializer_class = TeamProgressSerializer

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context.update({
            'team_id': self.kwargs['team_id']
        })
        return context


class LeaderboardRetrieveAPIView(generics.RetrieveAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = LeaderboardSerializer
    lookup_field = 'id'

    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.get_leaderboard(instance))
    

class RetrieveUserTeamAPIView(generics.RetrieveAPIView):
    queryset = Team.objects.all()
    serializer_class = TeamSerializer

    def get(self, request, *args, **kwargs):
        user = request.user
        treasure_hunt_id = kwargs.get('id', None)
        if user and treasure_hunt_id:
            try:
                team = self.get_queryset().get(team_members__id = user.id, treasure_hunt__id=treasure_hunt_id)
            except Team.DoesNotExist:
                return Response(status=status.HTTP_404_NOT_FOUND)
            serializer = self.get_serializer(team)
            return Response(serializer.data)
        else:
            return Response(status=status.HTTP_400_BAD_REQUEST)

class RetrieveTreashureHuntRewardsAPIView(generics.RetrieveAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'

    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.get_rewards(instance))
