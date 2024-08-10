part of 'popup_list_bloc.dart';

@immutable
class PopupListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final List<PopupSearchType> popupSearchTypes;
  final String searchKeyword;
  final PopupSearchType searchType;
  final List<Popup> popups;
  final bool isLoadingMore;
  final bool refreshPage;
  final List<SimpleStock> sourceCandidateStockList;
  final int totalCount;

  const PopupListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.popupSearchTypes = PopupSearchType.values,
    this.searchKeyword = '',
    this.searchType = PopupSearchType.popup_title,
    this.popups = const [],
    this.isLoadingMore = false,
    this.paging = const Paging(),
    this.refreshPage = false,
    this.sourceCandidateStockList = const [],
    this.totalCount = 0,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PopupListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<PopupSearchType>? popupSearchTypes,
    String? searchKeyword,
    PopupSearchType? searchType,
    List<Popup>? popups,
    bool? isLoadingMore,
    Paging? paging,
    bool? refreshPage,
    List<SimpleStock>? sourceCandidateStockList,
    int? totalCount,
  }) {
    return PopupListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      popupSearchTypes: popupSearchTypes ?? this.popupSearchTypes,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      searchType: searchType ?? this.searchType,
      popups: popups ?? this.popups,
      paging: paging ?? this.paging,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      refreshPage: refreshPage ?? this.refreshPage,
      sourceCandidateStockList: sourceCandidateStockList ?? this.sourceCandidateStockList,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        popupSearchTypes,
        searchKeyword,
        searchType,
        popups,
        paging,
        isLoadingMore,
        refreshPage,
        sourceCandidateStockList,
        totalCount,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
