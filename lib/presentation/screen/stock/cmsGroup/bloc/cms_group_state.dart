part of 'cms_group_bloc.dart';

@immutable
class CmsStockGroupState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final int paginatorIndex;
  final List<StockGroup> allStockGroupList;
  final List<StockGroup> stockGroupList;
  final List<SimpleStockGroup> cadiatedStocGroupkList;
  final int? stockGroupId;
  final String searchKeyword;
  final int totalCount;

  const CmsStockGroupState({
    this.allStockGroupList = const [],
    this.stockGroupList = const [],
    this.cadiatedStocGroupkList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.paginatorIndex = 0,
    this.stockGroupId,
    this.searchKeyword = "",
    this.totalCount = 0,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CmsStockGroupState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<StockGroup>? allStockGroupList,
    List<StockGroup>? stockGroupList,
    List<SimpleStockGroup>? cadiatedStocGroupkList,
    int? stockGroupId,
    Paging? paging,
    int? paginatorIndex,
    String? searchKeyword,
    bool clearStockGroupId = false,
    int? totalCount,
  }) {
    return CmsStockGroupState(
      allStockGroupList: allStockGroupList ?? this.allStockGroupList,
      stockGroupList: stockGroupList ?? this.stockGroupList,
      cadiatedStocGroupkList: cadiatedStocGroupkList ?? this.cadiatedStocGroupkList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      stockGroupId: clearStockGroupId ? null : stockGroupId ?? this.stockGroupId,
      paging: paging ?? this.paging,
      paginatorIndex: paginatorIndex ?? this.paginatorIndex,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      totalCount: totalCount ?? this.totalCount,
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
        allStockGroupList,
        stockGroupList,
        cadiatedStocGroupkList,
        stockGroupId,
        paginatorIndex,
        totalCount,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
