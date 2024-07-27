part of 'bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.init() = _OnInit;

  const factory LoginEvent.login(String email, String password) = _OnLogin;
}