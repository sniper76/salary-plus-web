part of 'bloc.dart';

@freezed
class StockHomeState with _$StockHomeState, BaseStateMixin {
  const StockHomeState._();

  factory StockHomeState({
    required bool isLoading,
    required bool isNotFound,
    required StockHome? stockHome,
    @Default([]) List<Post> debatePostList,
    @Default([]) List<Post> analysisPostList,
    @Default([]) List<Post> actionPostList,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
  }) = _StockHomeState;

  factory StockHomeState.initial() {
    return StockHomeState(
      isLoading: true,
      isNotFound: false,
      stockHome: null,
      errorToastMessage: null,
      notiToastMessage: null,
    );
  }
}

extension StockHomeStateExtesion on StockHomeState {
  StockHomeState copyWithNull({
    bool? isLoading,
    bool? isNotFound,
    StockHome? stockHome,
    List<Post>? debatePostList,
    List<Post>? analysisPostList,
    List<Post>? actionPostList,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return StockHomeState(
      isLoading: isLoading ?? this.isLoading,
      isNotFound: isNotFound ?? this.isNotFound,
      stockHome: stockHome ?? this.stockHome,
      debatePostList: debatePostList ?? this.debatePostList,
      analysisPostList: analysisPostList ?? this.analysisPostList,
      actionPostList: actionPostList ?? this.actionPostList,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}
