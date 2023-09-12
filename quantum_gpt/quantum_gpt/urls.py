from django.urls import path
from django.views.generic import TemplateView

urlpatterns = [
    path('', TemplateView.as_view(template_name="index.html"), name='index'),
    path('app/', TemplateView.as_view(template_name="app.html"), name='app_page'),
]
