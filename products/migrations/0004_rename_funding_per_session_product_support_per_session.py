# Generated by Django 4.0.4 on 2022-04-16 17:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0003_alter_product_end_date'),
    ]

    operations = [
        migrations.RenameField(
            model_name='product',
            old_name='funding_per_session',
            new_name='support_per_session',
        ),
    ]
