part of 'bloc.dart';

@immutable
class CmsState extends BaseState {
  final Paging paging;
  final List<CorporationUser> corporations;
  final int paginatorIndex;
  final CorporationUser? selectedCorporation;
  final StockDetail? stockInfo;
  final String? leaderComment;
  final bool isLeaderSelected;
  final String toast;
  final DigitalDocumentAcceptUser? acceptUser;

  const CmsState({
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.paginatorIndex = 0,
    this.stockInfo,
    this.acceptUser,
    this.leaderComment,
    this.selectedCorporation,
    this.isLeaderSelected = false,
    this.corporations = const [],
    this.toast = "",
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CmsState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    StockDetail? stockInfo,
    String? leaderComment,
    bool? isLeaderSeleted,
    CorporationUser? selectedCorporation,
    String? toast,
    List<CorporationUser>? corporations,
    Paging? paging,
    DigitalDocumentAcceptUser? acceptUser,
    bool clearAcceptUser = false,
  }) {
    return CmsState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      stockInfo: stockInfo ?? this.stockInfo,
      leaderComment: leaderComment ?? this.leaderComment,
      isLeaderSelected: isLeaderSeleted ?? this.isLeaderSelected,
      selectedCorporation: selectedCorporation,
      toast: toast ?? this.toast,
      corporations: corporations ?? this.corporations,
      paging: paging ?? this.paging,
      acceptUser: clearAcceptUser ? null : acceptUser ?? this.acceptUser,
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
        stockInfo,
        leaderComment,
        selectedCorporation,
        isLeaderSelected,
        toast,
        acceptUser
      ];
}
