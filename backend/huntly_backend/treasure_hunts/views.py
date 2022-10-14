from rest_framework import generics, status
from rest_framework.response import Response
from uritemplate import partial
from .serializers import TreasureHuntSerializer, ThemeSerializer, ClueSerializer, TreasureHuntParticipantsSerializer, \
    TeamProgressSerializer, LeaderboardSerializer, TeamSerializer
from .models import TreasureHunt, Theme, Clue, TeamProgress, Team
from .utils import calc_distance

RADIUS = 10


class TreasureHuntListAPIView(generics.ListAPIView):
    """
    List all treasure hunts near a location
    """
    serializer_class = TreasureHuntSerializer
    queryset = TreasureHunt.objects.all()

    def get(self, request, *args, **kwargs):
        lat = request.query_params.get('latitude', None)
        lon = request.query_params.get('longitude', None)
        if lat and lon:
            queryset = self.get_queryset()
            for hunt in queryset:
                hunt_distance = calc_distance(float(lat), float(lon), float(hunt.location_latitude), float(hunt.location_longitude))
                if hunt_distance > RADIUS:  
                    queryset = queryset.exclude(id=hunt.id)
                    
            # queryset = sorted(queryset, key=lambda x: x.distance)
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        else:
            return super().get(request, *args, **kwargs)
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer

    def get(self, request, *args, **kwargs):
        lat = request.query_params.get('latitude', None)
        lon = request.query_params.get('longitude', None)
        if lat and lon:
            queryset = self.get_queryset()
            for hunt in queryset:
                hunt_distance = calc_distance(float(lat), float(lon), float(hunt.location_latitude), float(hunt.location_longitude))
                if hunt_distance > RADIUS:  
                    queryset = queryset.exclude(id=hunt.id)
                    
            # queryset = sorted(queryset, key=lambda x: x.distance)
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        else:
            return super().get(request, *args, **kwargs)


class TreasureHuntCreateAPIView(generics.CreateAPIView):
    """
    Create a new treasure hunt
    """
    serializer_class = TreasureHuntSerializer
    queryset = TreasureHunt.objects.all()
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer


class TreasureHuntRetrieveAPIView(generics.RetrieveAPIView):
    """
    Retrieve a treasure hunt by id
    """
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'


class TreasureHuntUpdateAPIView(generics.UpdateAPIView):
    """
    Update a treasure hunt by id
    """
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'


class TreasureHuntDeleteAPIView(generics.DestroyAPIView):
    """
    Delete a treasure hunt by id
    """
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'


class ThemeListAPIView(generics.ListAPIView):
    """
    List all themes
    """
    serializer_class = ThemeSerializer
    queryset = Theme.objects.all()
    queryset = Theme.objects.all()
    serializer_class = ThemeSerializer


class ClueListAPIView(generics.ListAPIView):
    """
    List all clues for a treasure hunt
    """
    serializer_class = ClueSerializer
    queryset = Clue.objects.all()
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'treasure_hunt'


class ClueCreateAPIView(generics.CreateAPIView):
    """
    Create a new clue for a treasure hunt
    """
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data, context={'request': request, 'treasure_hunt': kwargs['treasure_hunt']})
        serializer.is_valid(raise_exception=True)
        serializer.save()
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class ClueRetrieveAPIView(generics.RetrieveAPIView):
    """
    Retrieve a clue by id
    """
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'


class ClueUpdateAPIView(generics.UpdateAPIView):
    """
    Update a clue by id
    """
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'
    queryset = Clue.objects.all()
    serializer_class = ClueSerializer
    lookup_field = 'id'


class RegisterParticipantAPIView(generics.UpdateAPIView):
    """
    Register a participant for a treasure hunt
    """
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
    """
    Unregister a participant for a treasure hunt
    """
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
    """
    List all teams' progress for a treasure hunt
    """
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
    """
    Update a team's progress for a treasure hunt by adding a new TeamProgress object
    """
    queryset = TeamProgress.objects.all()
    serializer_class = TeamProgressSerializer

    def get_serializer_context(self):
        context = super().get_serializer_context()
        context.update({
            'team_id': self.kwargs['team_id']
        })
        return context


class LeaderboardRetrieveAPIView(generics.RetrieveAPIView):
    """
    Retrieve a leaderboard by using the TeamProgress model
    """
    queryset = TreasureHunt.objects.all()
    serializer_class = LeaderboardSerializer
    lookup_field = 'id'

    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.get_leaderboard(instance))
    

class RetrieveUserTeamAPIView(generics.RetrieveAPIView):
    """
    Retrieve logged in user's team
    """
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
    """
    Retrieve a treasure hunt's rewards
    """
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer
    lookup_field = 'id'

    def get(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = self.get_serializer(instance)
        return Response(serializer.get_rewards(instance))
