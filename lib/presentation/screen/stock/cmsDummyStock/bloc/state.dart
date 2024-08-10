part of 'bloc.dart';

@immutable
class CmsDummyState extends BaseState {
  final List<SimpleStock> simpleStockList;
  final SimpleStock? selectedStock;
  final List<StockReferenceDate> referenceDates;
  final StockReferenceDate? selectedReferenceDate;
  final bool isComplete;
  final String searchKeyword;

  const CmsDummyState({
    bool isLoading = false,
    String? errorToastMessage,
    this.simpleStockList = const [],
    this.referenceDates = const [],
    this.searchKeyword = '',
    this.isComplete = false,
    this.selectedStock,
    this.selectedReferenceDate,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CmsDummyState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    bool? isComplete,
    List<SimpleStock>? simpleStockList,
    List<StockReferenceDate>? referenceDates,
    SimpleStock? selectedStock,
    String? searchKeyword,
    StockReferenceDate? selectedReferenceDate,
  }) {
    return CmsDummyState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      simpleStockList: simpleStockList ?? this.simpleStockList,
      selectedStock: selectedStock ?? this.selectedStock,
      referenceDates: referenceDates ?? this.referenceDates,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      selectedReferenceDate: selectedReferenceDate ?? this.selectedReferenceDate,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        simpleStockList,
        selectedStock,
        searchKeyword,
        selectedReferenceDate,
        isComplete,
      ];
}
