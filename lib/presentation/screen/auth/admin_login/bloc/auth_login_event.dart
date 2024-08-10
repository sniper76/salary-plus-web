part of 'auth_login_bloc.dart';

@immutable
abstract class AuthLoginEvent {
  AuthLoginEvent._();

  factory AuthLoginEvent.login(String email, String password) = AuthLoginEventOnLogin;

  factory AuthLoginEvent.confirm(String currentPassword, String newPassword, String confirmPassword) =
      AuthLoginEventOnConfirm;
}

class AuthLoginEventOnLogin extends AuthLoginEvent {
  final String email;
  final String password;

  AuthLoginEventOnLogin(this.email, this.password) : super._();
}

class AuthLoginEventOnConfirm extends AuthLoginEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  AuthLoginEventOnConfirm(this.currentPassword, this.newPassword, this.confirmPassword) : super._();
}
