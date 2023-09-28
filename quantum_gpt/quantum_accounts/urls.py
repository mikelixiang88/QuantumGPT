from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register_view, name='register'),
    path('login/', views.login_view, name='login'),
    path('myaccount/', views.check_account, name='myaccount'),
    path('otheraccount/', views.display_user, name='otheraccount'),
    path('update_teleporter/', views.update_teleporter, name='update_teleporter'),
]
