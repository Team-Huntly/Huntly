from rest_framework import serializers
from .models import Coupon, Brand, CouponDescription
from users.serializers import UserViewSerializer


# Serializer for Brand Model
class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Brand
        fields = '__all__'
    
    # Function to change the way the object is displayed
    def to_representation(self, instance):
        return super().to_representation(instance)
    
    # Function to create a new brand
    def create(self, validated_data):
        return super().create(validated_data)


# Serializer for Coupon Description Model
class CouponDescriptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CouponDescription
        fields = '__all__'

    # Function to change the way the object is displayed
    def to_representation(self, instance):
        codes = Coupon.objects.filter(description=instance)
        return {
            'id': instance.id,
            'brand': BrandSerializer(instance.brand).data,
            'terms_and_conditions': instance.terms_and_conditions,
            'title': instance.title,
            'description': instance.description,
        }


# Serializer for Coupon Model
class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = '__all__'
    
    # Function to change the way the object is displayed
    def to_representation(self, instance):
        return {
            'id': instance.id,
            'code': instance.code,
            'description': CouponDescriptionSerializer(instance.description).data,
            'treasure_hunt': instance.treasure_hunt.id,
            'user': UserViewSerializer(instance.user).data,
            'created_at': instance.created_at,
            'expiry_date': instance.expiry_date
        }
        
