from django.urls import path

from .views import MemoryCreateAPIView

app_name = 'memories'

urlpatterns = [
    path('create/', MemoryCreateAPIView.as_view()),
]

