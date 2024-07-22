part of 'bloc.dart';

@freezed
class ActPostListWidgetState with _$ActPostListWidgetState, BaseStateMixin, PagingState {
  const ActPostListWidgetState._();

  const factory ActPostListWidgetState({
    required List<Post> postList,
    required bool isLoading,
    required Paging postPaging,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
    @Default([]) List<BoardGroupCategory> boardGroupCategoryList,
    BoardGroupCategory? selectedBoardGroupCategory,
    @Default([BoardSortType.createdAt, BoardSortType.viewCount, BoardSortType.likeCount])
    List<BoardSortType> boardSortTypeList,
    @Default(BoardSortType.createdAt) BoardSortType selectedBoardSortType,
  }) = _ActPostListWidgetState;

  factory ActPostListWidgetState.initial() {
    return ActPostListWidgetState(
      isLoading: true,
      postList: [],
      postPaging: Paging.initial(),
      selectedBoardGroupCategory: null,
      errorToastMessage: null,
      notiToastMessage: null,
    );
  }

  @override
  Paging get paging => postPaging;
}

extension ActPostListWidgetStateExtension on ActPostListWidgetState {
  ActPostListWidgetState copyWithNull({
    List<Post>? postList,
    bool? isLoading,
    Paging? postPaging,
    String? errorToastMessage,
    String? notiToastMessage,
    List<BoardGroupCategory>? boardGroupCategoryList,
    BoardGroupCategory? selectedBoardGroupCategory,
    List<BoardSortType>? boardSortTypeList,
    BoardSortType? selectedBoardSortType,
  }) {
    return ActPostListWidgetState(
      postList: postList ?? this.postList,
      isLoading: isLoading ?? this.isLoading,
      postPaging: postPaging ?? this.postPaging,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
      boardGroupCategoryList: boardGroupCategoryList ?? this.boardGroupCategoryList,
      selectedBoardGroupCategory: selectedBoardGroupCategory ?? this.selectedBoardGroupCategory,
      boardSortTypeList: boardSortTypeList ?? this.boardSortTypeList,
      selectedBoardSortType: selectedBoardSortType ?? this.selectedBoardSortType,
    );
  }
}
