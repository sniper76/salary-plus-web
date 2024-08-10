import 'package:act_cms/domain/model/enum/exposure_status.dart';
import 'package:act_cms/domain/model/enum/period_check.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';

abstract class EventBoardListEvent {
  const EventBoardListEvent._();

  const factory EventBoardListEvent.init() = OnInit;

  const factory EventBoardListEvent.refresh() = OnRefresh;

  const factory EventBoardListEvent.selectSearchType(BoardSearchType newSearchType) = OnSelectSearchType;

  const factory EventBoardListEvent.search(String? searchKeyword) = OnSearch;

  const factory EventBoardListEvent.selectPostStatusType(PostStatusType newPostStatusType) = OnSelectPostStatusType;

  const factory EventBoardListEvent.selectPeriodCheck(PeriodCheckStatus newPeriodCheckStatus) = OnSelectPeriodCheck;

  const factory EventBoardListEvent.selectSearchStartDate(DateTime newSearchStartDate) = OnSelectSearchStartDate;

  const factory EventBoardListEvent.selectSearchEndDate(DateTime newSearchEndDate) = OnSelectSearchEndDate;

  const factory EventBoardListEvent.loadMore(int page) = OnLoadMore;
}

class OnInit extends EventBoardListEvent {
  const OnInit() : super._();
}

class OnRefresh extends EventBoardListEvent {
  const OnRefresh() : super._();
}

class OnSelectSearchType extends EventBoardListEvent {
  final BoardSearchType newSearchType;
  const OnSelectSearchType(this.newSearchType) : super._();
}

class OnSearch extends EventBoardListEvent {
  final String? searchKeyword;
  const OnSearch(this.searchKeyword) : super._();
}

class OnSelectPostStatusType extends EventBoardListEvent {
  final PostStatusType newPostStatusType;
  const OnSelectPostStatusType(this.newPostStatusType) : super._();
}

class OnSelectPeriodCheck extends EventBoardListEvent {
  final PeriodCheckStatus newPeriodCheckStatus;

  const OnSelectPeriodCheck(this.newPeriodCheckStatus) : super._();
}

class OnSelectSearchStartDate extends EventBoardListEvent {
  final DateTime newSearchStartDate;

  const OnSelectSearchStartDate(this.newSearchStartDate) : super._();
}

class OnSelectSearchEndDate extends EventBoardListEvent {
  final DateTime newSearchEndDate;

  const OnSelectSearchEndDate(this.newSearchEndDate) : super._();
}

class OnLoadMore extends EventBoardListEvent {
  final int page;

  const OnLoadMore(this.page) : super._();
}

class OnGetEventsOrCampaigns extends EventBoardListEvent {
  final BoardSearchType? searchType;
  final ExposureStatus? exposureStatus;
  final String? searchKeyword;
  final PostStatusType? status;
  final DateTime? searchStartDate;
  final DateTime? searchEndDate;
  final int? page;
  final int? size;

  const OnGetEventsOrCampaigns({
    this.searchType,
    this.exposureStatus,
    this.searchKeyword,
    this.status,
    this.searchStartDate,
    this.searchEndDate,
    this.page,
    this.size,
  }) : super._();
}
