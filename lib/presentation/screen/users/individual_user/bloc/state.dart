part of 'bloc.dart';

@immutable
class UsersState extends BaseState implements PagingState {
  final UserSearchCategory selectedCategory;

  // final List<UserData> userDataList2;
  final List<User> userDataList;
  final String searchKeyword;
  @override
  final Paging paging;
  final List<UserSearchCategory> categories;
  final bool refreshPage;
  final int totalCount;
  final List<UserSortType> userSortTypeList;
  final List<UserSortTypeWrapper> userSortTypeWrapperList;
  final UserSortType selectedSortType;
  final List<UserFilterType> userFilterTypeList;
  final List<UserFilterTypeWrapper> userFilterTypeWrapperList;
  final UserFilterType selectedFilterType;

  UsersState({
    this.userDataList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.selectedCategory = UserSearchCategory.name,
    this.searchKeyword = "",
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.categories = UserSearchCategory.values,
    this.refreshPage = false,
    this.totalCount = 0,
    this.userSortTypeList = UserSortType.values,
    this.selectedSortType = UserSortType.createdAtDesc,
    this.userFilterTypeList = UserFilterType.values,
    this.selectedFilterType = UserFilterType.all,
  })  : userSortTypeWrapperList = userSortTypeList
            .map((UserSortType userSortType) => UserSortTypeWrapper(userSortType: userSortType))
            .toList(),
        userFilterTypeWrapperList = userFilterTypeList
            .map((UserFilterType userFilterType) => UserFilterTypeWrapper(userFilterType: userFilterType))
            .toList(),
        super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  UsersState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<User>? userDataList,
    String? searchKeyword,
    UserSearchCategory? selectedCategory,
    Paging? paging,
    List<UserSearchCategory>? categories,
    bool? refreshPage,
    int? totalCount,
    List<UserSortType>? userSortTypeList,
    UserSortType? selectedSortType,
    List<UserFilterType>? userFilterTypeList,
    UserFilterType? selectedFilterType,
  }) {
    return UsersState(
      userDataList: userDataList ?? this.userDataList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      // userDataList:  ?? this.userDataList,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      paging: paging ?? this.paging,
      categories: categories ?? this.categories,
      refreshPage: refreshPage ?? this.refreshPage,
      totalCount: totalCount ?? this.totalCount,
      userSortTypeList: userSortTypeList ?? this.userSortTypeList,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      userFilterTypeList: userFilterTypeList ?? this.userFilterTypeList,
      selectedFilterType: selectedFilterType ?? this.selectedFilterType,
    );
  }

  List<User> parseUserData(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        selectedCategory,
        userDataList,
        categories,
        refreshPage,
        totalCount,
        userSortTypeList,
        selectedSortType,
        userFilterTypeList,
        selectedFilterType,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
