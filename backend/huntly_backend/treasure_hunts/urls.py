from django.urls import path

from .views import TreasureHuntCreateAPIView, TreasureHuntListAPIView, TreasureHuntRetrieveAPIView, TreasureHuntUpdateAPIView, TreasureHuntDeleteAPIView, ThemeListAPIView, ClueListAPIView, ClueCreateAPIView, ClueRetrieveAPIView, ClueUpdateAPIView

app_name = 'treasure_hunts'

urlpatterns = [
    path('', TreasureHuntListAPIView.as_view()),
    path('<int:id>/', TreasureHuntRetrieveAPIView.as_view()),
    path('create/', TreasureHuntCreateAPIView.as_view()),
    path('<int:id>/update/', TreasureHuntUpdateAPIView.as_view()),
    path('<int:id>/delete/', TreasureHuntDeleteAPIView.as_view()),
    path('themes/', ThemeListAPIView.as_view()),
    path('<int:treasure_hunt>/clues/', ClueListAPIView.as_view()),
    path('<int:treasure_hunt>/clues/create/', ClueCreateAPIView.as_view()),
    path('clues/<int:id>/', ClueRetrieveAPIView.as_view()),
    path('clues/<int:id>/update/', ClueUpdateAPIView.as_view()),
]
