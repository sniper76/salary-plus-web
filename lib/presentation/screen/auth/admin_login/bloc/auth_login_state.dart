part of 'auth_login_bloc.dart';

@immutable
class AuthLoginState extends BaseState {
  final bool isNewUser;
  final bool passwordChanged;
  final bool isLoggedIn;
  final User? user;

  const AuthLoginState({
    bool isLoading = false,
    String? errorToastMessage,
    this.user,
    this.isNewUser = false,
    this.passwordChanged = false,
    this.isLoggedIn = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  AuthLoginState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    bool? isNewUser,
    User? user,
    bool? passwordChanged,
    bool? isLoggedIn,
  }) {
    return AuthLoginState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      isNewUser: isNewUser ?? this.isNewUser,
      passwordChanged: passwordChanged ?? this.passwordChanged,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorToastMessage, isNewUser, passwordChanged, isLoggedIn, user];
}
