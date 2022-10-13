from django.urls import path, re_path

from . import views

app_name = 'users'

urlpatterns = [
    re_path('auth/' + r'social/(?P<backend>[^/]+)/$', views.register_by_access_token),
    path('register/', views.register.as_view()),
    path('login/', views.login.as_view()),
    path('update/', views.update.as_view()),
]
