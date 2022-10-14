from django.urls import path

from .views import RetrieveTreashureHuntRewardsAPIView, TreasureHuntCreateAPIView, TreasureHuntListAPIView, TreasureHuntRetrieveAPIView, \
     TreasureHuntUpdateAPIView, TreasureHuntDeleteAPIView, ThemeListAPIView, ClueListAPIView, ClueCreateAPIView,\
         ClueRetrieveAPIView, ClueUpdateAPIView, RegisterParticipantAPIView, UnregisterParticipantAPIView, \
            TeamProgressAPIView, TeamProgressCreateAPIView, LeaderboardRetrieveAPIView, RetrieveUserTeamAPIView, \
                RetrieveTreashureHuntRewardsAPIView

app_name = 'treasure_hunts'

urlpatterns = [
    path('', TreasureHuntListAPIView.as_view()),
    path('<int:id>/', TreasureHuntRetrieveAPIView.as_view()),
    path('create/', TreasureHuntCreateAPIView.as_view()),
    path('<int:id>/update/', TreasureHuntUpdateAPIView.as_view()),
    path('<int:id>/delete/', TreasureHuntDeleteAPIView.as_view()),
    path('<int:id>/register/', RegisterParticipantAPIView.as_view()),
    path('<int:id>/unregister/', UnregisterParticipantAPIView.as_view()),
    path('<int:id>/leaderboard/', LeaderboardRetrieveAPIView.as_view()),
    path('<int:id>/my-team/', RetrieveUserTeamAPIView.as_view()),
    path('<int:id>/rewards/', RetrieveTreashureHuntRewardsAPIView.as_view()),
    path('themes/', ThemeListAPIView.as_view()),
    path('<int:treasure_hunt>/clues/', ClueListAPIView.as_view()),
    path('<int:treasure_hunt>/clues/create/', ClueCreateAPIView.as_view()),
    path('clues/<int:id>/', ClueRetrieveAPIView.as_view()),
    path('clues/<int:id>/update/', ClueUpdateAPIView.as_view()),
    path('teams/<int:team_id>/progress/', TeamProgressAPIView.as_view()),
    path('teams/<int:team_id>/progress/create/', TeamProgressCreateAPIView.as_view()),


]
