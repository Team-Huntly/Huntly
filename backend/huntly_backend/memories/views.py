from django.shortcuts import render
from .serializers import MemorySerializer
from .models import Memory
from rest_framework import generics

# Create your views here.
class MemoryCreateAPIView(generics.CreateAPIView):
    """
    Create a new memory
    """
    serializer_class = MemorySerializer
    queryset = Memory.objects.all()
    serializer_class = MemorySerializer