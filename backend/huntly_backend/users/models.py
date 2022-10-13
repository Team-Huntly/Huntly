from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager


# This is the model for the user. It is a subclass of the AbstractUser class

class CustomUserManager(BaseUserManager):
    use_in_migrations = True
    def create_user(self, email, **kwargs):
        if not email:
            raise ValueError("Users must have an email address")
        email = self.normalize_email(email)
        user = self.model(email=email, **kwargs)
        if 'password' in kwargs:
            user.set_password(kwargs['password'])
        user.save()
        return user


    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_staff', True)
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

class CustomUser(AbstractUser):
    GENDER_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
        ('NB','Non-Binary')
    )
    username = None
    email = models.EmailField(unique=True)
    gender = models.CharField(max_length=2, choices=GENDER_CHOICES)
    date_of_birth = models.DateField(blank=True,null=True)
    phone_no = models.CharField(max_length=15, blank=True, null=True)
    bio = models.TextField(blank=True, null=True)
    profile_pic = models.ImageField(upload_to='profile_pics', blank=True, null=True)
    is_superuser = models.BooleanField(default=False)
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []
    objects = CustomUserManager()

    def __str__(self):
        return self.email
