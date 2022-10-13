from rest_framework import serializers
from .models import Coupon, Brand
from users.serializers import UserViewSerializer


class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = '__all__'
    
    def to_representation(self, instance):
        return super().to_representation(instance)
    
    def create(self, validated_data):
        return super().create(validated_data)

class CouponDescriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = '__all__'

    def to_representation(self, instance):
        return super().to_representation(instance)


class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = '__all__'
    
    def to_representation(self, instance):
        brand = BrandSerializer(instance.brand)
        user = UserViewSerializer(instance.user)
        return {
            'code': instance.code,
            'expiry_date': instance.expiry_date,
            'created_at': instance.created_at,
            'brand': brand,
            'user': user
        }
