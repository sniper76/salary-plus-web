part of 'bloc.dart';

@freezed
class HomeState with _$HomeState, BaseStateMixin {
  factory HomeState({
    required bool isLoading,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
    @Default([]) List<Post> globalBoardPosts,
  }) = _HomeState;

  factory HomeState.initial() {
    return HomeState(
      isLoading: true,
      errorToastMessage: null,
      notiToastMessage: null,
      globalBoardPosts: [],
    );
  }
}

extension HomeStateExtesion on HomeState {
  HomeState copyWithNull({
    bool? isLoading,
    List<Post>? globalBoardPosts,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      globalBoardPosts: globalBoardPosts ?? this.globalBoardPosts,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}
