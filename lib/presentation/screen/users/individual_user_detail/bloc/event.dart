part of 'bloc.dart';

@immutable
abstract class UserDetailEvent {
  const UserDetailEvent._();

  const factory UserDetailEvent.init() = UserDetailOnInit;

  const factory UserDetailEvent.fetchUserDetail({
    required int userId,
    int page,
    int size,
    String? sorts,
  }) = FetchUserDetail;

  const factory UserDetailEvent.fetchUserDummyStocks({
    required int userId,
    int page,
    int size,
    String? sorts,
  }) = FetchUserDummyStocks;

  const factory UserDetailEvent.fetchUserDetailLoadMore({
    int page,
    int size,
    String? sorts,
  }) = UserDetailOnLoadMore;

  const factory UserDetailEvent.updateNickname(String nickname) = UserDetailOnUpdateNickname;

  const factory UserDetailEvent.addDummyData(UserStockData dummyStock) = UserAddDummyStock;

  const factory UserDetailEvent.deleteDummyData(String stockCode) = UserDeleteDummyStock;

  const factory UserDetailEvent.downloadConfidential() = UserDetailOnDownLoadConfidential;
}

class UserDetailOnInit extends UserDetailEvent {
  const UserDetailOnInit() : super._();
}

class UserDetailOnUserDataList extends UserDetailEvent {
  final List<User> userDataList;

  const UserDetailOnUserDataList(this.userDataList) : super._();
}

class UserDetailOnUpdateNickname extends UserDetailEvent {
  final String nickname;

  const UserDetailOnUpdateNickname(this.nickname) : super._();
}

class UserAddDummyStock extends UserDetailEvent {
  final UserStockData dummyStock;

  const UserAddDummyStock(this.dummyStock) : super._();
}

class UserDeleteDummyStock extends UserDetailEvent {
  final String stockCode;

  const UserDeleteDummyStock(this.stockCode) : super._();
}

class FetchUserDetail extends UserDetailEvent {
  final int userId;
  final int page;
  final int size;
  final String? sorts;

  const FetchUserDetail({
    required this.userId,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class FetchUserDummyStocks extends UserDetailEvent {
  final int userId;
  final int? page;
  final int? size;
  final String? sorts;

  const FetchUserDummyStocks({
    required this.userId,
    this.page,
    this.size,
    this.sorts,
  }) : super._();
}

class UserDetailOnLoadMore extends UserDetailEvent {
  final int page;
  final int size;
  final String? sorts;

  const UserDetailOnLoadMore({
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class UserDetailOnDownLoadConfidential extends UserDetailEvent {
  const UserDetailOnDownLoadConfidential() : super._();
}
