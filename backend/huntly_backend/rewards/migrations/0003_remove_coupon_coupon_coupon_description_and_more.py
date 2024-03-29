# Generated by Django 4.1.2 on 2022-10-13 21:05

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('rewards', '0002_alter_brand_added_at_alter_coupon_created_at_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='coupon',
            name='coupon',
        ),
        migrations.AddField(
            model_name='coupon',
            name='description',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.CASCADE, related_name='coupons_description', to='rewards.coupondescription'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='coupon',
            name='user',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='coupons_user', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='coupondescription',
            name='brand',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='coupon_descriptions_brand', to='rewards.brand'),
        ),
    ]
