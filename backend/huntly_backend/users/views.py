from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from social_django.utils import psa
from rest_framework import generics, status
from django.contrib.auth import get_user_model
from .serializers import UpdateUserSerializer, UserRegistrationSerializer, UserLoginSerializer, UserViewSerializer, ChangePasswordSerializer
from treasure_hunts.serializers import TreasureHuntSerializer
from rewards.serializers import CouponSerializer
from treasure_hunts.models import TreasureHunt
from rewards.models import Coupon
from datetime import datetime
from treasure_hunts.serializers import MemoryThreadListSerializer
from treasure_hunts.models import TreasureHunt


#Google Auth Registration for Huntly app
@api_view(['POST'])
@permission_classes([AllowAny])
@psa()
def register_by_access_token(request, backend):
    token = request.data.get('access_token')
    user = request.backend.do_auth(token)
    if user:
        token, _ = Token.objects.get_or_create(user=user)
        return Response(
            {
                'token': token.key
            },
            status=status.HTTP_200_OK,
            )
    else:
        return Response(
            {
                'errors': {
                    'token': 'Invalid token'
                    }
            },
            status=status.HTTP_400_BAD_REQUEST,
        )


class RegisterUserAPIView(generics.CreateAPIView):
    """
    Register a new user using email and password
    """
    queryset = get_user_model().objects.all()
    serializer_class = UserRegistrationSerializer
    permission_classes = [AllowAny]
    queryset = get_user_model().objects.all()
    serializer_class = UserRegistrationSerializer
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class LoginUserAPIView(generics.GenericAPIView):
    """
    Login a user using email and password
    """
    queryset = get_user_model().objects.all()
    serializer_class = UserLoginSerializer
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data
        if user:
            token, _ = Token.objects.get_or_create(user=user)
            return Response(
                {
                    'token': token.key
                },
                status=status.HTTP_200_OK,
                )
        else:
            return Response(
                {
                    'errors': {
                        'token': 'Invalid token'
                        }
                },
                status=status.HTTP_400_BAD_REQUEST,
            )


class UpdateUserAPIView(generics.UpdateAPIView):
    """
    Update logged in user's details
    """
    queryset = get_user_model().objects.all()
    serializer_class = UpdateUserSerializer

    def get_object(self):
        return self.request.user
    queryset = get_user_model().objects.all()
    serializer_class = UpdateUserSerializer

    def update(self, request, *args, **kwargs):
        partial = kwargs.pop('partial', False)
        instance = request.user
        serializer = self.get_serializer(instance, data=request.data, partial=partial)
        serializer.is_valid(raise_exception=True)
        self.perform_update(serializer)

        if getattr(instance, '_prefetched_objects_cache', None):
            instance._prefetched_objects_cache = {}

        return Response(serializer.data)


class FetchProfileAPIView(generics.RetrieveAPIView):
    """
    Fetch logged in user's details
    """
    queryset = get_user_model().objects.all()
    serializer_class = UserViewSerializer

    def get_object(self, **kwargs):
        if self.kwargs.get('user_id'):
            return get_user_model().objects.get(id=self.kwargs.get('user_id'))
        return self.request.user


class ChangePasswordAPIView(generics.GenericAPIView):
    """
    Change logged in user's password
    """
    queryset = get_user_model().objects.all()
    serializer_class = ChangePasswordSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(
            {
                'message': 'Password updated successfully',
            },
            status=status.HTTP_200_OK
        )


class FetchUserHuntsAPIView(generics.ListAPIView):
    """
    Fetch logged in user's hunts
    """
    serializer_class = TreasureHuntSerializer

    def get_queryset(self):
        user = self.request.user
        return TreasureHunt.objects.filter(participants__id=user.id)


class FetchUserUpcomingHuntsAPIView(generics.ListAPIView):
    """
    Fetch logged in user's recent hunts
    """
    serializer_class = TreasureHuntSerializer

    def get_queryset(self):
        user = self.request.user
        return TreasureHunt.objects.filter(participants__id=user.id, ended_at__gt=datetime.now())


class FetchUserPastHuntsAPIView(generics.ListAPIView):
    """
    Fetch logged in user's past hunts
    """
    serializer_class = TreasureHuntSerializer

    def get_queryset(self):
        user = self.request.user
        return TreasureHunt.objects.filter(participants__id=user.id, ended_at__lte=datetime.now())


class FetchUserCreatedHuntsAPIView(generics.ListAPIView):
    """
    Fetch logged in user's created hunts
    """
    serializer_class = TreasureHuntSerializer

    def get_queryset(self):
        user = self.request.user
        return TreasureHunt.objects.filter(created_by=user)


class FetchUserRewardsAPIView(generics.ListAPIView):
    """
    Fetch logged in user's rewards
    """
    serializer_class = CouponSerializer

    def get_queryset(self):
        user = self.request.user
        return Coupon.objects.filter(user=user)

class UserMemoriesListAPIView(generics.ListAPIView):
    """
    Fetch logged in user's memories
    """
    serializer_class = MemoryThreadListSerializer

    def get_queryset(self):
        user = self.request.user
        return TreasureHunt.objects.filter(participants__id=user.id, ended_at__lte=datetime.now())

        