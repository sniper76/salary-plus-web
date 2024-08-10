part of 'auth_password_change_bloc.dart';

@immutable
abstract class AuthPasswordChangeEvent {
  AuthPasswordChangeEvent._();

  factory AuthPasswordChangeEvent.submit(String currentPassword, String newPassword, String confirmPassword) =
      AuthPasswordChangeOnSubmit;

  factory AuthPasswordChangeEvent.currentPassword(String password) = AuthPasswordChangeOnEditCurrentPassword;

  factory AuthPasswordChangeEvent.newPassword(String password) = AuthPasswordChangeOnEditNewPassword;

  factory AuthPasswordChangeEvent.confirmPassword(String password) = AuthPasswordChangeOnEditConfirmPassword;
}

class AuthPasswordChangeOnSubmit extends AuthPasswordChangeEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  AuthPasswordChangeOnSubmit(this.currentPassword, this.newPassword, this.confirmPassword) : super._();
}

class AuthPasswordChangeOnEditCurrentPassword extends AuthPasswordChangeEvent {
  final String password;

  AuthPasswordChangeOnEditCurrentPassword(this.password) : super._();
}

class AuthPasswordChangeOnEditNewPassword extends AuthPasswordChangeEvent {
  final String password;

  AuthPasswordChangeOnEditNewPassword(this.password) : super._();
}

class AuthPasswordChangeOnEditConfirmPassword extends AuthPasswordChangeEvent {
  final String password;

  AuthPasswordChangeOnEditConfirmPassword(this.password) : super._();
}
