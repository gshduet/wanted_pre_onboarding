from enum import auto
from django.db import models

from core.models import TimeStampModel


class Product(TimeStampModel):
    user                = models.ForeignKey('users.User', on_delete=models.PROTECT) # 게시자 명
    title               = models.CharField(max_length=30) # 제목
    context             = models.TextField() # 상품 설명
    target_amount       = models.DecimalField(max_digits=10, decimal_places=2) # 목표 금액
    funding_per_session = models.DecimalField(max_digits=10, decimal_places=2) # 1회 당 펀딩 금액
    end_date            = models.DateTimeField() # 펀딩 종료일
    delete_at           = models.DateTimeField(auto_now=True, null=True, blank=True) # soft_delete 구현을 위한 컬럼
    donators            = models.ManyToManyField(
        'users.User', through='Donator', related_name='products',
        null=True, blank=True
    ) # 후원자 식별을 위한 donator 컬럼
    
    def __str__(self):
        return self.title

    class Meta:
        db_table = 'products'


class Donator(models.Model):
    user      = models.ForeignKey('users.User', on_delete=models.CASCADE)
    product   = models.ForeignKey('Product', on_delete=models.CASCADE)
    delete_at = models.DateTimeField(auto_now=True, null=True, blank=True)
    
    def __str__(self):
        return self.prduct

    class Meta:
        db_table = 'donators'
