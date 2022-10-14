"""
huntly_backend URL Configuration
"""

from django.contrib import admin
from django.urls import path, include, re_path
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from django.conf import settings
from django.conf.urls.static import static
schema_view = get_schema_view(
    openapi.Info(
        title="Huntly API",
        default_version='v1',
        description="Welcome to the world of Huntly",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    re_path(r'^docs(?P<format>\.json|\.yaml)$',
            schema_view.without_ui(cache_timeout=0), name='schema-json'),
    path('docs/', schema_view.with_ui('swagger', cache_timeout=0),
         name='schema-swagger-ui'),
    path('redocs/', schema_view.with_ui('redoc', cache_timeout=0),
         name='schema-redoc'),
    path('admin/', admin.site.urls),
    path('users/', include('users.urls')),
    path('treasure-hunts/', include('treasure_hunts.urls')),
    path('rewards/', include('rewards.urls')),
    path('memories/', include('memories.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
