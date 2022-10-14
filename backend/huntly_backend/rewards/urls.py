from django.urls import path
from .views import BrandCreateAPIView

app_name = 'rewards'

urlpatterns = [
    path('brand/create', BrandCreateAPIView.as_view(), name='brand'),
]