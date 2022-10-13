import imp
from django.db import models
from treasure_hunts.models import TreasureHunt
from django.contrib.auth import get_user_model

User = get_user_model()

# Create your models here.
class Brand(models.Model):
    name = models.CharField(max_length = 256)
    logo = models.ImageField(upload_to='brand_logos', blank=True, null=True)
    added_at = models.DateTimeField(auto_now_add = True)

    def _str_(self):
        return self.name

class CouponDescription(models.Model):
    brand = models.ForeignKey(Brand, blank=False, null = False, on_delete=models.CASCADE)
    terms_and_conditions = models.TextField(blank=True, null=True)
    title = models.CharField(max_length = 256)
    description = models.TextField(blank=True, null=True)

    def _str_(self):
        return self.title

class Coupon(models.Model):
    coupon = models.ForeignKey(CouponDescription, blank=False, null = False, on_delete=models.CASCADE)
    code = models.CharField(max_length = 256)
    treasure_hunt = models.ForeignKey(TreasureHunt, blank=True, null = True, on_delete=models.CASCADE)
    user = models.ForeignKey(User, blank=True, null = True, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add = True)
    expiry_date = models.DateTimeField()

    def _str_(self):
        return self.code