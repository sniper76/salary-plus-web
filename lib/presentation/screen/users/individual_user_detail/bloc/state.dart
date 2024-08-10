part of 'bloc.dart';

@immutable
class UserDetailState extends BaseState implements PagingState {
  // final List<UserData> userDataList2;
  final int userId;
  final User? userData;
  @override
  final Paging paging;
  final Paging dummyPaging;
  final List<UserStockData> userStockData;
  final List<UserStockData> userStockDummyData;
  final String? confidentialDownloadLink;

  const UserDetailState({
    required this.userId,
    this.userData,
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.dummyPaging = const Paging(page: 1, size: apiLoadSize),
    this.userStockData = const [],
    this.userStockDummyData = const [],
    this.confidentialDownloadLink,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  UserDetailState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    User? userData,
    Paging? paging,
    Paging? dummyPaging,
    List<UserStockData>? userStockData,
    List<UserStockData>? userStockDummyData,
    String? confidentialDownloadLink,
  }) {
    return UserDetailState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      userId: userId,
      userData: userData ?? this.userData,
      paging: paging ?? this.paging,
      dummyPaging: dummyPaging ?? this.dummyPaging,
      userStockData: userStockData ?? this.userStockData,
      userStockDummyData: userStockDummyData ?? this.userStockDummyData,
      confidentialDownloadLink: confidentialDownloadLink ?? '',
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
        userId,
        userData,
        paging,
        userStockData,
        userStockDummyData,
        dummyPaging,
        confidentialDownloadLink,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
