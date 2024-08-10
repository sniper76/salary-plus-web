part of 'push_group_list_bloc.dart';

@immutable
class PushGroupListState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final List<PushSearchType> pushSearchTypes;
  final String searchKeyword;
  final PushSearchType searchType;
  final List<GroupPush> pushes;
  final bool isLoadingMore;
  final bool refreshPage;
  final List<SimpleStock> sourceCandidateStockList;
  final int totalCount;

  const PushGroupListState({
    bool isLoading = false,
    String? errorToastMessage,
    this.pushSearchTypes = PushSearchType.values,
    this.searchKeyword = '',
    this.searchType = PushSearchType.pushContent,
    this.pushes = const [],
    this.isLoadingMore = false,
    this.paging = const Paging(),
    this.refreshPage = false,
    this.sourceCandidateStockList = const [],
    this.totalCount = 0,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  PushGroupListState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<PushSearchType>? pushSearchTypes,
    String? searchKeyword,
    PushSearchType? searchType,
    List<GroupPush>? pushes,
    bool? isLoadingMore,
    Paging? paging,
    bool? refreshPage,
    List<SimpleStock>? sourceCandidateStockList,
    int? totalCount,
  }) {
    return PushGroupListState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      pushSearchTypes: pushSearchTypes ?? this.pushSearchTypes,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      searchType: searchType ?? this.searchType,
      pushes: pushes ?? this.pushes,
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
        pushSearchTypes,
        searchKeyword,
        searchType,
        pushes,
        paging,
        isLoadingMore,
        refreshPage,
        sourceCandidateStockList,
        totalCount,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
