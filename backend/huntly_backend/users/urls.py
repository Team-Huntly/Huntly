from django.urls import path, re_path

from .views import register_by_access_token, RegisterUserAPIView, LoginUserAPIView, UpdateUserAPIView, FetchProfileAPIView, \
     ChangePasswordAPIView, FetchUserHuntsAPIView, FetchUserRewardsAPIView,FetchUserPastHuntsAPIView, FetchUserUpcomingHuntsAPIView, \
        FetchUserCreatedHuntsAPIView, UserMemoriesListAPIView

app_name = 'users'

urlpatterns = [
    re_path('auth/' + r'social/(?P<backend>[^/]+)/$', register_by_access_token),
    path('register/', RegisterUserAPIView.as_view()),
    path('login/', LoginUserAPIView.as_view()),
    path('update/', UpdateUserAPIView.as_view()),
    path('change-password/', ChangePasswordAPIView.as_view()),
    path('profile/', FetchProfileAPIView.as_view()),
    path('<int:user_id>/profile/', FetchProfileAPIView.as_view()),
    path('hunts/', FetchUserHuntsAPIView.as_view()),
    path('hunts/past/', FetchUserPastHuntsAPIView.as_view()),
    path('hunts/upcoming/', FetchUserUpcomingHuntsAPIView.as_view()),
    path('hunts/created/', FetchUserCreatedHuntsAPIView.as_view()),
    path('rewards/', FetchUserRewardsAPIView.as_view()),
    path('memories/', UserMemoriesListAPIView.as_view()),
]
