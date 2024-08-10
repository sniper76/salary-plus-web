part of 'push_group_list_bloc.dart';

@immutable
abstract class PushGroupListEvent {
  const PushGroupListEvent._();

  const factory PushGroupListEvent.init() = PushGroupListOnInit;

  const factory PushGroupListEvent.refresh() = PushGroupListOnRefresh;

  const factory PushGroupListEvent.loadMore({
    String? searchKeyword,
    int? page,
    int? size,
    BoardSortType? sorts,
  }) = PushGroupListOnLoadMore;

  const factory PushGroupListEvent.changedSearchType(PushSearchType searchType) = PushGroupListOnChangedSearchType;

  const factory PushGroupListEvent.changedSort(BoardSortType sortType) = PushGroupListOnChangedSort;

  const factory PushGroupListEvent.updatePush(int pushId) = PushGroupListOnUpdatedPush;

  const factory PushGroupListEvent.pageRefresh() = PushGroupListOnPageRefresh;

  const factory PushGroupListEvent.setSearchKeyword(String searchKeyword) = PushGroupListOnSetSearchKeyword;

  const factory PushGroupListEvent.setSearchType(PushSearchType searchType) = PushGroupListOnSetSearchType;

  const factory PushGroupListEvent.cancelPush(int pushId) = PushGroupOnCancelPush;
}

class PushGroupListOnInit extends PushGroupListEvent {
  const PushGroupListOnInit() : super._();
}

class PushGroupListOnRefresh extends PushGroupListEvent {
  const PushGroupListOnRefresh() : super._();
}

class PushGroupListOnLoadMore extends PushGroupListEvent {
  final String? searchKeyword;
  final int? page;
  final int? size;
  final BoardSortType? sorts;

  const PushGroupListOnLoadMore({
    this.searchKeyword,
    this.page,
    this.size,
    this.sorts,
  }) : super._();
}

class PushGroupListOnChangedSearchType extends PushGroupListEvent {
  final PushSearchType searchType;

  const PushGroupListOnChangedSearchType(this.searchType) : super._();
}

class PushGroupListOnChangedSort extends PushGroupListEvent {
  final BoardSortType boardSortType;

  const PushGroupListOnChangedSort(this.boardSortType) : super._();
}

class PushGroupListOnUpdatedPush extends PushGroupListEvent {
  final int pushId;

  const PushGroupListOnUpdatedPush(this.pushId) : super._();
}

class PushGroupListOnPageRefresh extends PushGroupListEvent {
  const PushGroupListOnPageRefresh() : super._();
}

class PushGroupListOnSetSearchKeyword extends PushGroupListEvent {
  final String searchKeyword;

  const PushGroupListOnSetSearchKeyword(this.searchKeyword) : super._();
}

class PushGroupListOnSetSearchType extends PushGroupListEvent {
  final PushSearchType searchType;

  const PushGroupListOnSetSearchType(this.searchType) : super._();
}

class PushGroupOnCancelPush extends PushGroupListEvent {
  final int pushId;

  const PushGroupOnCancelPush(this.pushId) : super._();
}
