# Generated by Django 4.2.5 on 2023-11-12 03:59

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('q_blog', '0003_alter_post_content'),
    ]

    operations = [
        migrations.DeleteModel(
            name='PostImage',
        ),
    ]