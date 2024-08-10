part of 'bloc.dart';

abstract class RegisterAcceptUserEvent {
  const RegisterAcceptUserEvent._();

  const factory RegisterAcceptUserEvent.onInit() = OnInit;

  const factory RegisterAcceptUserEvent.onChangeCategories({
    UserType? userType,
    CorporationSearchType? corporationSearchType,
    UserSearchCategory? individualSearchType,
  }) = OnChangeCategories;

  const factory RegisterAcceptUserEvent.onGetUserList() = OnGetUserList;

  const factory RegisterAcceptUserEvent.onChangeSearchKeyword(String searchKeyword) = OnChangeSearchKeyword;

  const factory RegisterAcceptUserEvent.onSearchIndividualList() = OnSearchIndividualList;

  const factory RegisterAcceptUserEvent.onSearchCorporationList() = OnSearchCorporationList;

  const factory RegisterAcceptUserEvent.onChangePaging(int page) = OnChangePaging;

  const factory RegisterAcceptUserEvent.onAssignAcceptUser({
    required AcceptUser acceptUser,
    required String stockCode,
  }) = OnAssignAcceptUser;
}

class OnInit extends RegisterAcceptUserEvent {
  const OnInit() : super._();
}

class OnChangeCategories extends RegisterAcceptUserEvent {
  final UserType? userType;
  final CorporationSearchType? corporationSearchType;
  final UserSearchCategory? individualSearchType;

  const OnChangeCategories({this.userType, this.corporationSearchType, this.individualSearchType}) : super._();
}

class OnChangeSearchKeyword extends RegisterAcceptUserEvent {
  final String searchKeyword;

  const OnChangeSearchKeyword(this.searchKeyword) : super._();
}

class OnGetUserList extends RegisterAcceptUserEvent {
  const OnGetUserList() : super._();
}

class OnSearchIndividualList extends RegisterAcceptUserEvent {
  const OnSearchIndividualList() : super._();
}

class OnSearchCorporationList extends RegisterAcceptUserEvent {
  const OnSearchCorporationList() : super._();
}

class OnChangePaging extends RegisterAcceptUserEvent {
  final int page;

  const OnChangePaging(this.page) : super._();
}

class OnAssignAcceptUser extends RegisterAcceptUserEvent {
  final AcceptUser acceptUser;
  final String stockCode;

  const OnAssignAcceptUser({required this.acceptUser, required this.stockCode}) : super._();
}
