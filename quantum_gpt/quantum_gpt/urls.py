from django.urls import path, include
from django.views.generic import TemplateView
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('', TemplateView.as_view(template_name="index.html"), name='index'),
    path('', include('quantum_app.urls')),  # This includes all URLs of app1
    path('', include('quantum_accounts.urls')),  # This includes all URLs of app2
    path('', include('quantum_chat.urls')),
    path('', include('q_blog.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
