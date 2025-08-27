from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView
from django.urls import path
from .views import LoginView, PasswordResetRequestView, PasswordResetConfirmView, UserDetailView, ChangePasswordView

urlpatterns = [

    path("login/", LoginView.as_view(), name="login"),
    path("password-reset/", PasswordResetRequestView.as_view(), name="password-reset"),
    path("password-reset-confirm/", PasswordResetConfirmView.as_view(), name="password-reset-confirm"),

    path("users/me/", UserDetailView.as_view(), name="user-detail"),
    path("users/me/change-password/", ChangePasswordView.as_view(), name="change-password"),

]

