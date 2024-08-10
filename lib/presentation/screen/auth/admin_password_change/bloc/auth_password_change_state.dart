part of 'auth_password_change_bloc.dart';

@immutable
class AuthPasswordChangeState extends BaseState {
  final bool isNewUser;
  final bool passwordChanged;
  final bool isPasswrodChangeCompleted;
  final String? currentPassword;
  final String? newPassword;
  final String? confirmPassword;
  final String? currentPasswordErrorText;
  final String? newPasswordErrorText;
  final String? confirmPasswordErrorText;
  final bool isButtonEnabled;
  final User? user;

  const AuthPasswordChangeState({
    bool isLoading = false,
    String? errorToastMessage,
    this.user,
    this.isNewUser = false,
    this.passwordChanged = false,
    this.isPasswrodChangeCompleted = false,
    this.currentPassword,
    this.newPassword,
    this.confirmPassword,
    this.currentPasswordErrorText = '패스워드를 입력해 주세요',
    this.newPasswordErrorText = '패스워드를 입력해 주세요',
    this.confirmPasswordErrorText = '패스워드를 입력해 주세요',
    this.isButtonEnabled = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  AuthPasswordChangeState copyWith({
    User? user,
    bool? isLoading,
    String? errorToastMessage,
    bool? isNewUser,
    bool? passwordChanged,
    bool? isPasswrodChangeCompleted,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    String? currentPasswordErrorText,
    String? newPasswordErrorText,
    String? confirmPasswordErrorText,
    bool? isButtonEnabled,
  }) {
    return AuthPasswordChangeState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      isNewUser: isNewUser ?? this.isNewUser,
      passwordChanged: passwordChanged ?? this.passwordChanged,
      isPasswrodChangeCompleted: isPasswrodChangeCompleted ?? this.isPasswrodChangeCompleted,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      currentPasswordErrorText: currentPasswordErrorText ?? this.currentPasswordErrorText,
      newPasswordErrorText: newPasswordErrorText ?? this.newPasswordErrorText,
      confirmPasswordErrorText: confirmPasswordErrorText ?? this.confirmPasswordErrorText,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        isNewUser,
        passwordChanged,
        isPasswrodChangeCompleted,
        currentPasswordErrorText,
        newPasswordErrorText,
        confirmPasswordErrorText,
        isButtonEnabled,
        newPassword,
        confirmPassword
      ];
}
