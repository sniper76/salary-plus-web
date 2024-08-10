part of 'cms_stock_bloc.dart';

@immutable
class CmsStockState extends BaseState implements PagingState {
  @override
  final Paging paging;
  final int paginatorIndex;
  final List<Stock> stockList;
  final bool isStockSeleted;
  final SimpleStock? seletedStock;
  final List<SimpleStock> candidatedStockList;
  final StockReferenceDate? assingedStockReferenceDate;
  final String toastMessage;
  final bool isRegistered;
  final int totalCount;
  final List<StockSortType> stockSortTypeList;
  final StockSortType selectedSortType;

  const CmsStockState({
    this.stockList = const [],
    bool isLoading = false,
    String? errorToastMessage,
    this.paging = const Paging(page: 1, size: apiLoadSize),
    this.paginatorIndex = 0,
    this.isStockSeleted = false,
    this.seletedStock,
    this.candidatedStockList = const [],
    this.assingedStockReferenceDate,
    this.toastMessage = "",
    this.isRegistered = false,
    this.totalCount = 0,
    this.stockSortTypeList = StockSortType.values,
    this.selectedSortType = StockSortType.stakeDesc,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CmsStockState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<Stock>? stockList,
    String? code,
    Paging? paging,
    int? paginatorIndex,
    bool? isStockSeleted,
    bool? clearSimpleStock,
    SimpleStock? seletedStock,
    List<SimpleStock>? cadiatedStockList,
    StockReferenceDate? assingedStockReferenceDate,
    String? toastMessage,
    bool? isRegistered,
    int? totalCount,
    List<StockSortType>? stockSortTypeList,
    StockSortType? selectedSortType,
  }) {
    return CmsStockState(
      stockList: stockList ?? this.stockList,
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      paging: paging ?? this.paging,
      paginatorIndex: paginatorIndex ?? this.paginatorIndex,
      isStockSeleted: isStockSeleted ?? this.isStockSeleted,
      seletedStock: clearSimpleStock ?? false ? null : seletedStock ?? this.seletedStock,
      candidatedStockList: cadiatedStockList ?? candidatedStockList,
      assingedStockReferenceDate: assingedStockReferenceDate ?? this.assingedStockReferenceDate,
      toastMessage: toastMessage ?? this.toastMessage,
      isRegistered: isRegistered ?? this.isRegistered,
      totalCount: totalCount ?? this.totalCount,
      stockSortTypeList: stockSortTypeList ?? this.stockSortTypeList,
      selectedSortType: selectedSortType ?? this.selectedSortType,
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
        stockList,
        paginatorIndex,
        isStockSeleted,
        seletedStock,
        candidatedStockList,
        assingedStockReferenceDate,
        toastMessage,
        isRegistered,
        totalCount,
        stockSortTypeList,
        selectedSortType,
      ];

  get accumulateIndex => (paging.page - 1) * paging.size;
}
