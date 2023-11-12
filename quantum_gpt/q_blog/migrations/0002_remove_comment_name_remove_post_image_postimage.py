# Generated by Django 4.2.1 on 2023-11-11 19:11

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('q_blog', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='comment',
            name='name',
        ),
        migrations.RemoveField(
            model_name='post',
            name='image',
        ),
        migrations.CreateModel(
            name='PostImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='post_images/')),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='q_blog.post')),
            ],
        ),
    ]
