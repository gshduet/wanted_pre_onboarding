# Generated by Django 4.0.4 on 2022-04-16 09:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0002_rename_donator_supporter_remove_product_donators_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='product',
            name='end_date',
            field=models.DateField(),
        ),
    ]
