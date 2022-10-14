from rest_framework import generics, status
from rest_framework.response import Response
from .serializers import BrandSerializer, CouponSerializer
from .models import Brand, Coupon

class BrandCreateAPIView(generics.CreateAPIView):
    serializer_class = BrandSerializer
    queryset = Brand.objects.all()

class CouponCreateAPIView(generics.CreateAPIView):
    serializer_class = CouponSerializer
    queryset = Coupon

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)