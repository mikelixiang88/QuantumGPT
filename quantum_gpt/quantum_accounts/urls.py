from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register_view, name='register'),
    path('login/', views.login_view, name='login'),
    path('myaccount/', views.check_account, name='myaccount'),
    path('displayuser/', views.display_user, name='displayuser'),
    path('displayuserID/<int:user_id>', views.display_userID, name='displayuserID'),
    path('update_teleporter/', views.update_teleporter, name='update_teleporter'),
]
