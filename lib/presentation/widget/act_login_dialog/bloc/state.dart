part of 'bloc.dart';

@freezed
class ActLoginState with _$ActLoginState, BaseStateMixin {
  factory ActLoginState({
    required bool isLoading,
    required bool isPolling,
    required bool isVerificationExpired,
    required bool isLoginSuccess,
    required String loginDynamicLink,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
    @Default(null) WebVerification? webVerification,
    @Default(0) int seconds,
  }) = _ActLoginDialogState;

  factory ActLoginState.initial() {
    return ActLoginState(
      isLoading: true,
      isPolling: false,
      isVerificationExpired: false,
      isLoginSuccess: false,
      loginDynamicLink: '',
      errorToastMessage: null,
      notiToastMessage: null,
      webVerification: null,
      seconds: 0,
    );
  }
}

extension ActLoginStateExtension on ActLoginState {
  ActLoginState copyWithNull({
    bool? isLoading,
    bool? isPolling,
    bool? isVerificationExpired,
    bool? isLoginSuccess,
    String? loginDynamicLink,
    String? errorToastMessage,
    String? notiToastMessage,
    WebVerification? webVerification,
    int? seconds,
  }) {
    return ActLoginState(
      isLoading: isLoading ?? this.isLoading,
      isPolling: isPolling ?? this.isPolling,
      isVerificationExpired: isVerificationExpired ?? this.isVerificationExpired,
      loginDynamicLink: loginDynamicLink ?? this.loginDynamicLink,
      isLoginSuccess: isLoginSuccess ?? false,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
      webVerification: webVerification ?? this.webVerification,
      seconds: seconds ?? this.seconds,
    );
  }
}
