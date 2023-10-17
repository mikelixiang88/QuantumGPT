from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register_view, name='register'),
    path('login/', views.login_view, name='login'),
    path('myaccount/', views.check_account, name='myaccount'),
    path('displayuser/', views.display_user, name='displayuser'),
    path('api/search_user/', views.search_user, name='search_user'),
    path('displayuserID/<int:user_id>', views.display_userID, name='displayuserID'),
    path('update_teleporter/', views.update_teleporter, name='update_teleporter'),
    path('follow/<int:user_id>/', views.follow_user, name='follow_user'),
    path('unfollow/<int:user_id>/', views.unfollow_user, name='unfollow_user'),
    path('get_followed_and_followers/', views.get_followed_and_followers, name='get_followed_and_followers'),
]
