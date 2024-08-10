part of 'bloc.dart';

@immutable
abstract class CorporationListEvent {
  const CorporationListEvent._();

  const factory CorporationListEvent.init() = OnInit;

  const factory CorporationListEvent.setSearchType(CorporationSearchType searchType) = OnSetSearchType;

  const factory CorporationListEvent.onGetCorporationList({
    String? searchKeyword,
    int? page,
    int? size,
    CorporationSearchType? searchType,
  }) = OnGetCorporationList;
}

class OnInit extends CorporationListEvent {
  const OnInit() : super._();
}

class OnSetSearchType extends CorporationListEvent {
  final CorporationSearchType searchType;

  const OnSetSearchType(this.searchType) : super._();
}

class OnGetCorporationList extends CorporationListEvent {
  final CorporationSearchType? searchType;
  final String? searchKeyword;
  final int? page;
  final int? size;

  const OnGetCorporationList({
    this.searchType,
    this.searchKeyword,
    this.page,
    this.size,
  }) : super._();
}
