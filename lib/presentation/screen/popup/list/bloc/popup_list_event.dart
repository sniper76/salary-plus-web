part of 'popup_list_bloc.dart';

@immutable
abstract class PopupListEvent {
  const PopupListEvent._();

  const factory PopupListEvent.init() = PopupListOnInit;

  const factory PopupListEvent.refresh() = PopupListOnRefresh;

  const factory PopupListEvent.loadMore({
    String? searchKeyword,
    int? page,
    int? size,
    BoardSortType? sorts,
  }) = PopupListOnLoadMore;

  const factory PopupListEvent.changedSearchType(PopupSearchType searchType) = PopupListOnChangedSearchType;

  const factory PopupListEvent.changedSort(BoardSortType sortType) = PopupListOnChangedSort;

  const factory PopupListEvent.updatePopup(int popupId) = PopupListOnUpdatedPopup;

  const factory PopupListEvent.cancelPopup(int popupId) = PopupOnCancelPopup;
}

class PopupListOnInit extends PopupListEvent {
  const PopupListOnInit() : super._();
}

class PopupListOnRefresh extends PopupListEvent {
  const PopupListOnRefresh() : super._();
}

class PopupListOnLoadMore extends PopupListEvent {
  final String? searchKeyword;
  final int? page;
  final int? size;
  final BoardSortType? sorts;

  const PopupListOnLoadMore({
    this.searchKeyword,
    this.page,
    this.size,
    this.sorts,
  }) : super._();
}

class PopupListOnChangedSearchType extends PopupListEvent {
  final PopupSearchType searchType;

  const PopupListOnChangedSearchType(this.searchType) : super._();
}

class PopupListOnChangedSort extends PopupListEvent {
  final BoardSortType boardSortType;

  const PopupListOnChangedSort(this.boardSortType) : super._();
}

class PopupListOnUpdatedPopup extends PopupListEvent {
  final int popupId;

  const PopupListOnUpdatedPopup(this.popupId) : super._();
}

class PopupOnPageRefresh extends PopupListEvent {
  const PopupOnPageRefresh() : super._();
}

class PopupOnSetSearchType extends PopupListEvent {
  final PopupSearchType searchType;

  const PopupOnSetSearchType(this.searchType) : super._();
}

class PopupOnCancelPopup extends PopupListEvent {
  final int popupId;

  const PopupOnCancelPopup(this.popupId) : super._();
}
