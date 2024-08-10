part of 'bloc.dart';

@immutable
abstract class UsersEvent {
  const UsersEvent._();

  const factory UsersEvent.init() = UsersOnInit;

  const factory UsersEvent.refresh() = UsersRefresh;

  const factory UsersEvent.setRefresh() = UsersSetRefresh;

  const factory UsersEvent.usersOnUserDataList(List<User> userDataList) = UsersOnUserDataList;

  const factory UsersEvent.usersOnSelectCategory(UserSearchCategory selectedCategory) = UsersOnSelectCategory;

  const factory UsersEvent.fetchUsers({
    int page,
    int size,
    String? searchKeyword,
    UserSearchCategory searchCategory,
    UserSortType? sortType,
    UserFilterType? filterType,
  }) = FetchUsers;

  const factory UsersEvent.addRoleToUserEvent(int userId, String roleType) = AddRoleToUserEvent;

  const factory UsersEvent.assignAdminEvent(int userId) = AssignAdminEvent;

  const factory UsersEvent.fetchUsersLoadMore({
    int page,
  }) = UsersOnLoadMore;

  const factory UsersEvent.changeSortType(UserSortType changedSortType) = ChangeSortType;

  const factory UsersEvent.changeFilterType(UserFilterType changedFilterType) = ChangeFilterType;
}

class UsersOnInit extends UsersEvent {
  const UsersOnInit() : super._();
}

class UsersRefresh extends UsersEvent {
  const UsersRefresh() : super._();
}

class UsersSetRefresh extends UsersEvent {
  const UsersSetRefresh() : super._();
}

class UsersOnUserDataList extends UsersEvent {
  final List<User> userDataList;

  const UsersOnUserDataList(this.userDataList) : super._();
}

class UsersOnSelectCategory extends UsersEvent {
  final UserSearchCategory selectedCategory;

  const UsersOnSelectCategory(this.selectedCategory) : super._();
}

class FetchUsers extends UsersEvent {
  final int page;
  final int size;
  final String? searchKeyword;
  final UserSearchCategory? searchCategory;
  final UserSortType? sortType;
  final UserFilterType? filterType;

  const FetchUsers({
    this.page = 1,
    this.size = apiLoadSize,
    this.searchKeyword,
    this.searchCategory,
    this.sortType,
    this.filterType,
  }) : super._();
}

class UsersOnLoadMore extends UsersEvent {
  final int page;

  const UsersOnLoadMore({
    this.page = 1,
  }) : super._();
}

class AddRoleToUserEvent extends UsersEvent {
  final int userId;
  final String roleType;

  const AddRoleToUserEvent(this.userId, this.roleType) : super._();
}

class AssignAdminEvent extends UsersEvent {
  final int userId;

  const AssignAdminEvent(this.userId) : super._();
}

class ChangeSortType extends UsersEvent {
  final UserSortType changedSortType;

  const ChangeSortType(this.changedSortType) : super._();
}

class ChangeFilterType extends UsersEvent {
  final UserFilterType changedFilterType;

  const ChangeFilterType(this.changedFilterType) : super._();
}
