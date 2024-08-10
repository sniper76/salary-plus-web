part of 'push_individual_list_bloc.dart';

@immutable
abstract class PushIndividualListEvent {
  const PushIndividualListEvent._();

  const factory PushIndividualListEvent.init() = PushIndividualListOnInit;

  const factory PushIndividualListEvent.setSearchType(PushSearchType searchType) = PushIndividualListOnSetSearchType;

  const factory PushIndividualListEvent.getPushList({
    PushSearchType? searchType,
    String? searchKeyword,
    int? page,
    int? size,
    BoardSortType? sort,
  }) = PushIndividualListOnGetList;
}

class PushIndividualListOnInit extends PushIndividualListEvent {
  const PushIndividualListOnInit() : super._();
}

class PushIndividualListOnSetSearchType extends PushIndividualListEvent {
  final PushSearchType searchType;

  const PushIndividualListOnSetSearchType(this.searchType) : super._();
}

class PushIndividualListOnGetList extends PushIndividualListEvent {
  final PushSearchType? searchType;
  final String? searchKeyword;
  final int? page;
  final int? size;
  final BoardSortType? sort;

  const PushIndividualListOnGetList({this.searchKeyword, this.searchType, this.page, this.size, this.sort}) : super._();
}
