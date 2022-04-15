from django.db   import models

from core.models import TimeStampModel


class User(TimeStampModel):
    name     = models.CharField(max_length=15, unique=True) # 로그인 시 사용 할 id
    password = models.CharField(max_length=255) # 로그인 시 사용할 password
    nickname = models.CharField(max_length=15, unique=True) # 사이트에서 사용할 nickname
    
    def __str__(self):
        return self.user_id
    
    class Meta:
        db_table = 'users'
