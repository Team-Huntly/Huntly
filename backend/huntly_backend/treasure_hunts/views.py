from rest_framework import generics, status
from rest_framework.response import Response
from .serializers import TreasureHuntSerializer, ThemeSerializer, ClueSerializer
from .models import TreasureHunt, Theme, Clue

class TreasureHuntListAPIView(generics.ListAPIView):
    queryset = TreasureHunt.objects.all()
    serializer_class = TreasureHuntSerializer

    def distance(self, lat1, lon1, lat2, lon2):
        from math import sin, cos, sqrt, atan2, radians

        # approximate radius of earth in km
        R = 6373.0

        lat1 = radians(lat1)
        lon1 = radians(lon1)
        lat2 = radians(lat2)
        lon2 = radians(lon2)

        dlon = lon2 - lon1
        dlat = lat2 - lat1

        a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
        c = 2 * atan2(sqrt(a), sqrt(1 - a))

        distance = R * c

        return distance

    def get(self, request, *args, **kwargs):
        lat = float(request.query_params.get('latitude', None))
        lon = float(request.query_params.get('longitude', None))
        if lat and lon:
            queryset = self.get_queryset()
            for hunt in queryset:
                hunt.distance = self.distance(float(lat), float(lon), float(hunt.location_longitude), float(hunt.location_longitude))
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