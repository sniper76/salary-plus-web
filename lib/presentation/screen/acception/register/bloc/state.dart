part of 'bloc.dart';

@immutable
class RegisterAcceptUserState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final UserType userType;
  final CorporationSearchType corporationSearchType;
  final UserSearchCategory individualSearchType;
  final String searchKeyword;
  final List<AcceptUser> acceptUser;
  final bool isComplete;

  const RegisterAcceptUserState({
    this.individualSearchType = UserSearchCategory.name,
    this.corporationSearchType = CorporationSearchType.corporationName,
    this.searchKeyword = "",
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.acceptUser = const [],
    this.userType = UserType.individual,
    this.isComplete = false,
    bool isLoading = false,
    String? errorToastMessage,
  }) : super(
          isLoading: isLoading,
          errorToastMessage: errorToastMessage ?? '',
        );

  RegisterAcceptUserState copyWith({
    bool? isLoading,
    bool? isComplete,
    String? errorToastMessage,
    Paging? paging,
    List<AcceptUser>? acceptUser,
    String? searchKeyword,
    CorporationSearchType? corporationSearchType,
    UserSearchCategory? individualSearchType,
    UserType? userType,
  }) =>
      RegisterAcceptUserState(
        paging: paging ?? this.paging,
        corporationSearchType: corporationSearchType ?? this.corporationSearchType,
        individualSearchType: individualSearchType ?? this.individualSearchType,
        searchKeyword: searchKeyword ?? this.searchKeyword,
        acceptUser: acceptUser ?? this.acceptUser,
        userType: userType ?? this.userType,
        errorToastMessage: errorToastMessage ?? '',
        isLoading: isLoading ?? this.isLoading,
        isComplete: isComplete ?? false,
      );

  @override
  List<Object> get props => [
        isLoading,
        errorToastMessage,
        paging,
        searchKeyword,
        corporationSearchType,
        individualSearchType,
        userType,
        acceptUser,
        isComplete,
      ];
}
