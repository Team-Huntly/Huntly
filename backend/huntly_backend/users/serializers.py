from django.contrib.auth import get_user_model
from rest_framework import serializers
from django.contrib.auth import authenticate

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'email', 'gender', 'date_of_birth',)



class UserRegistrationSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    password2 = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('id', 'email', 'password', 'password2')

    def validate(self, data):
        if data['password'] != data['password2']:
            raise serializers.ValidationError("Passwords must match.")
        return data

    def create(self, validated_data):
        user = User.objects.create_user(
            validated_data['email'],
            # bio =validated_data['bio'],
            # phone_no =validated_data['phone_no'],
            # date_of_birth =validated_data['date_of_birth'],
            # gender = validated_data['gender'],
            # profile_pic = validated_data['profile_pic'],
            password=validated_data['password']
        )
        return user


class UpdateUserSerializer(serializers.ModelSerializer):
    class Meta(UserSerializer.Meta):
        model: User
        fields = ('bio', 'phone_no', 'gender', 'date_of_birth', 'profile_pic')
    # TODO: Add phone number regex validation


class UserViewSerializer(serializers.ModelSerializer):
    class Meta(UserSerializer.Meta):
        model = User
        fields = ('first_name', 'bio')


    
class UserLoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)
        if user and user.is_active:
            return user
        raise serializers.ValidationError("Incorrect Credentials")
