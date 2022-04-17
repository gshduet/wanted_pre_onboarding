DATABASES = {
    'default' : {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'wanted',
        'USER': 'root',
        'PASSWORD': '1234',
        'HOST': '127.0.0.1',
        'PORT': '3306',
				'OPTIONS': {'charset': 'utf8mb4'}
    }
}

SECRET_KEY = 'django-insecure-4uu4)fa&44bf#=9-(%zm%i881l_wxkc8o-vja=ab3qgthb9*iq'

ALGORITHM = 'HS256'