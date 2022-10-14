from django.urls import path

from .views import RetrieveTreashureHuntRewardsAPIView, TreasureHuntCreateAPIView, TreasureHuntListAPIView, TreasureHuntRetrieveAPIView, \
     TreasureHuntUpdateAPIView, TreasureHuntDeleteAPIView, ThemeListAPIView, ClueListAPIView, ClueCreateAPIView,\
         ClueRetrieveAPIView, ClueUpdateAPIView, RegisterParticipantAPIView, UnregisterParticipantAPIView, \
            TeamProgressAPIView, TeamProgressCreateAPIView, LeaderboardRetrieveAPIView, RetrieveUserTeamAPIView, \
                RetrieveTreashureHuntRewardsAPIView, MemoryThreadRetrieveAPIView, MemoryThreadListAPIView, ClueListCreateAPIView

app_name = 'treasure_hunts'

urlpatterns = [

    # Treasure hunt
    path('', TreasureHuntListAPIView.as_view()),
    path('<int:id>/', TreasureHuntRetrieveAPIView.as_view()),
    path('create/', TreasureHuntCreateAPIView.as_view()),
    path('<int:id>/update/', TreasureHuntUpdateAPIView.as_view()),
    path('<int:id>/delete/', TreasureHuntDeleteAPIView.as_view()),

    # Gameplay
    path('<int:id>/register/', RegisterParticipantAPIView.as_view()),
    path('<int:id>/unregister/', UnregisterParticipantAPIView.as_view()),
    path('<int:id>/leaderboard/', LeaderboardRetrieveAPIView.as_view()),
    path('<int:id>/my-team/', RetrieveUserTeamAPIView.as_view()),
    path('<int:id>/rewards/', RetrieveTreashureHuntRewardsAPIView.as_view()),

    # Theme
    path('themes/', ThemeListAPIView.as_view()),

    # Clues
    path('<int:treasure_hunt>/clues/', ClueListAPIView.as_view()),
    path('<int:treasure_hunt>/clues/create/', ClueCreateAPIView.as_view()),
    path('<int:treasure_hunt>/clues/create/list/', ClueListCreateAPIView.as_view()),

    path('clues/<int:id>/', ClueRetrieveAPIView.as_view()),
    path('clues/<int:id>/update/', ClueUpdateAPIView.as_view()),

    # Team progress
    path('teams/<int:team_id>/progress/', TeamProgressAPIView.as_view()),
    path('teams/<int:team_id>/progress/create/', TeamProgressCreateAPIView.as_view()),

    # Memory Thread
    path('memory-threads/', MemoryThreadListAPIView.as_view()),
    path('<int:id>/memory-thread/', MemoryThreadRetrieveAPIView.as_view()),
]
