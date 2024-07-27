part of 'bloc.dart';

@freezed
class LoginState with _$LoginState, BaseStateMixin {
  factory LoginState({
    required bool isLoading,
    bool? isLoggedIn,
    bool? isNewUser,
    @Default(null) User? user,
    bool? passwordChanged,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
    @Default([]) List<Post> globalBoardPosts,
  }) = _LoginState;

  factory LoginState.initial() {
    return LoginState(
      isLoading: true,
      isLoggedIn: false,
      isNewUser: null,
      user: null,
      passwordChanged: false,
      errorToastMessage: null,
      notiToastMessage: null,
      globalBoardPosts: [],
    );
  }
}

extension LoginStateExtesion on LoginState {
  LoginState copyWithNull({
    bool? isLoading,
    bool? isLoggedIn,
    bool? isNewUser,
    User? user,
    bool? passwordChanged,
    List<Post>? globalBoardPosts,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn,
      isNewUser: isNewUser,
      user: user,
      passwordChanged: passwordChanged,
      globalBoardPosts: globalBoardPosts ?? this.globalBoardPosts,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}
