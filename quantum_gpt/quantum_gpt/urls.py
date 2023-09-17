from django.urls import path, include
from django.views.generic import TemplateView

urlpatterns = [
    path('', TemplateView.as_view(template_name="index.html"), name='index'),
    path('', include('quantum_app.urls')),  # This includes all URLs of app1
    path('', include('quantum_accounts.urls')),  # This includes all URLs of app2
]
