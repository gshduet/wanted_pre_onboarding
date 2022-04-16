# Generated by Django 4.0.4 on 2022-04-16 18:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0006_productdetail'),
    ]

    operations = [
        migrations.RenameModel(
            old_name='ProductDetail',
            new_name='Detail',
        ),
        migrations.AlterField(
            model_name='product',
            name='delete_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='supporter',
            name='delete_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]