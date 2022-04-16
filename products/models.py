from django.db import models

from core.models import TimeStampModel


class Product(TimeStampModel):
    user                = models.ForeignKey('users.User', on_delete=models.PROTECT) # 게시자 명
    title               = models.CharField(max_length=30) # 제목
    context             = models.TextField() # 상품 설명
    target_amount       = models.DecimalField(max_digits=10, decimal_places=2) # 목표 금액
    support_per_session = models.DecimalField(max_digits=10, decimal_places=2) # 1회 당 펀딩 금액
    end_date            = models.DateField() # 펀딩 종료일
    delete_at           = models.DateTimeField(null=True, blank=True) # soft_delete 구현을 위한 컬럼
    is_delete           = models.BooleanField(default=False)
    supporters          = models.ManyToManyField(
        'users.User', through='Supporter', related_name='products',
        null=True, blank=True
    ) # 후원자 식별을 위한 supporter 컬럼

    class Meta:
        db_table = 'products'


class Detail(TimeStampModel):
    product         = models.OneToOneField('Product', on_delete=models.CASCADE)
    supporter_count = models.PositiveIntegerField() # 상품 후원자 수
    current_amount  = models.DecimalField(max_digits=10, decimal_places=2) # 현재 후원 금액
    achievment_rate = models.DecimalField(max_digits=10, decimal_places=0) # 현재 후원 달성도 (%)

    class Meta:
        db_table = 'details'


class Supporter(models.Model):
    user      = models.ForeignKey('users.User', on_delete=models.CASCADE) # 후원자
    product   = models.ForeignKey('Product', on_delete=models.CASCADE) # 후원상품
    delete_at = models.DateTimeField(null=True, blank=True)
    is_delete = models.BooleanField(default=False)

    class Meta:
        db_table = 'supporters'
