from django.urls import path

from .views import TreasureHuntCreateAPIView, TreasureHuntListAPIView, TreasureHuntRetrieveAPIView, TreasureHuntUpdateAPIView, TreasureHuntDeleteAPIView, ThemeListAPIView

app_name = 'treasure_hunts'

urlpatterns = [
    path('', TreasureHuntListAPIView.as_view()),
    path('<int:id>/', TreasureHuntRetrieveAPIView.as_view()),
    path('create/', TreasureHuntCreateAPIView.as_view()),
    path('<int:id>/update/', TreasureHuntUpdateAPIView.as_view()),
    path('<int:id>/delete/', TreasureHuntDeleteAPIView.as_view()),
    path('themes/', ThemeListAPIView.as_view()),
]
