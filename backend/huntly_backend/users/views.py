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


#Normal User Registration & Login for Huntly app
class RegisterUserAPIView(generics.CreateAPIView):
    queryset = get_user_model().objects.all()
    serializer_class = UserRegistrationSerializer
    permission_classes = (AllowAny,)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


# User Login API
class LoginUserAPIView(generics.GenericAPIView):
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


#Update User Profile
class UpdateUserAPIView(generics.UpdateAPIView):
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


# Fetch User Profile
class FetchProfileAPIView(generics.RetrieveAPIView):
    queryset = get_user_model().objects.all()
    serializer_class = UserViewSerializer

    def get_object(self, **kwargs):
        if self.kwargs.get('user_id'):
            return get_user_model().objects.get(id=self.kwargs.get('user_id'))
        return self.request.user


# Change Password
class ChangePasswordAPIView(generics.GenericAPIView):
    queryset = get_user_model().objects.all()
    serializer_class = ChangePasswordSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        # use save method from serializer
        serializer.save()
        return Response(
            {
                'message': 'Password updated successfully',
            },
            status=status.HTTP_200_OK
        )

class FetchUserHuntsAPIView(generics.ListAPIView):
    serializer_class = TreasureHuntSerializer

    def get_queryset(self):
        user = self.request.user
        return TreasureHunt.objects.filter(participants__id=user.id)