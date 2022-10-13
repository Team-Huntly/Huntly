from rest_framework import generics, status
from rest_framework.response import Response
from uritemplate import partial
from .serializers import TreasureHuntSerializer, ThemeSerializer, ClueSerializer, TreasureHuntParticipantsSerializer
from .models import TreasureHunt, Theme, Clue
from .utils import calc_distance

class TreasureHuntListAPIView(generics.ListAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer

    def get(self, request, *args, **kwargs):
        lat = request.query_params.get('latitude', None)
        lon = request.query_params.get('longitude', None)
        if lat and lon:
            queryset = self.get_queryset()
            for hunt in queryset:
                hunt.distance = calc_distance(float(lat), float(lon), float(hunt.location_longitude), float(hunt.location_longitude))
            queryset = sorted(queryset, key=lambda x: x.distance)
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        else:
            #return all hunts
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
