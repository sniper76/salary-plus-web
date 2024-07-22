part of 'bloc.dart';

@freezed
class ActPostListWidgetEvent with _$ActPostListWidgetEvent {
  const factory ActPostListWidgetEvent.init() = _OnInit;

  const factory ActPostListWidgetEvent.refresh() = _OnRefresh;

  const factory ActPostListWidgetEvent.fetchPostList({required int page, int? size}) = _OnFetchPostList;

  const factory ActPostListWidgetEvent.changePage({required int page}) = _OnChangePage;

  const factory ActPostListWidgetEvent.chagePageSize({required int size}) = _OnChangePageSize;

  const factory ActPostListWidgetEvent.changeBoardGroupCategory(BoardGroupCategory boardGroupCategory) =
      _OnChangeBoardGroupCategory;

  const factory ActPostListWidgetEvent.changeBoardSortType(BoardSortType boardSortType) = _OnChangeBoardSortType;

  factory ActPostListWidgetEvent.updatePost(int postId, String stockCode, BoardGroupType boardGroupType) =
      _OnUpdatePost;
}
