from django.urls import path
from . import views

urlpatterns = [
    # Other URL patterns...
    path('post/create/', views.create_post, name='create_post'),
    path('post/edit/<int:post_id>/', views.edit_post, name='edit_post'),
    path('blog/<int:post_id>/', views.blog_detail, name='blog_detail'),
    path('blog_idx', views.blog_index, name='blog_index'),
    path('upload_image/', views.image_upload_view, name='upload_image'),
    path('post/<int:post_id>/delete/', views.delete_post, name='delete_post'),
    path('post/<int:post_id>/add_comment/', views.add_comment, name='add_comment'),
]
