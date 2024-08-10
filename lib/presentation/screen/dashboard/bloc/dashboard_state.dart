part of 'dashboard_bloc.dart';

@immutable
class DashboardState extends BaseState {
  final String selectedCategory;
  final List<DashboardStatistics> basicStatsMonthly;
  final List<DashboardStatistics> stockStatsMonthly;
  final DashboardGenderStatistics? genderStatsMonthly;
  final DashboardAgeStatistics? ageStatsMonthly;
  final List<DashboardStatistics> basicStatsDaily;
  final List<DashboardStatistics> stockStatsDaily;
  final DashboardGenderStatistics? genderStatsDaily;
  final DashboardAgeStatistics? ageStatsDaily;
  final List<SimpleStock> targetCandidateStockList;
  final SimpleStock? selectedSimpleStock;
  final Searching? search;

  const DashboardState({
    bool isLoading = false,
    String? errorToastMessage,
    this.basicStatsMonthly = const [],
    this.stockStatsMonthly = const [],
    this.genderStatsMonthly,
    this.ageStatsMonthly,
    this.basicStatsDaily = const [],
    this.stockStatsDaily = const [],
    this.genderStatsDaily,
    this.ageStatsDaily,
    this.selectedCategory = "MONTHLY",
    this.targetCandidateStockList = const [],
    this.selectedSimpleStock,
    this.search,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  DashboardState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    List<DashboardStatistics>? basicStatsMonthly,
    List<DashboardStatistics>? stockStatsMonthly,
    DashboardGenderStatistics? genderStatsMonthly,
    DashboardAgeStatistics? ageStatsMonthly,
    List<DashboardStatistics>? basicStatsDaily,
    List<DashboardStatistics>? stockStatsDaily,
    DashboardGenderStatistics? genderStatsDaily,
    DashboardAgeStatistics? ageStatsDaily,
    String? selectedCategory,
    List<SimpleStock>? targetCandidateStockList,
    SimpleStock? selectedSimpleStock,
    bool clearSelectedSimpleStock = false, // 추가된 플래그
    Searching? search,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      basicStatsMonthly: basicStatsMonthly ?? this.basicStatsMonthly,
      stockStatsMonthly: stockStatsMonthly ?? this.stockStatsMonthly,
      genderStatsMonthly: genderStatsMonthly ?? this.genderStatsMonthly,
      ageStatsMonthly: ageStatsMonthly ?? this.ageStatsMonthly,
      basicStatsDaily: basicStatsDaily ?? this.basicStatsDaily,
      stockStatsDaily: stockStatsDaily ?? this.stockStatsDaily,
      genderStatsDaily: genderStatsDaily ?? this.genderStatsDaily,
      ageStatsDaily: ageStatsDaily ?? this.ageStatsDaily,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      targetCandidateStockList: targetCandidateStockList ?? this.targetCandidateStockList,
      selectedSimpleStock: clearSelectedSimpleStock ? null : selectedSimpleStock ?? this.selectedSimpleStock,
      search: search ?? this.search,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorToastMessage,
        selectedCategory,
        basicStatsMonthly,
        stockStatsMonthly,
        genderStatsMonthly,
        ageStatsMonthly,
        basicStatsDaily,
        stockStatsDaily,
        genderStatsDaily,
        ageStatsDaily,
        targetCandidateStockList,
        selectedSimpleStock,
        search,
      ];

// get accumulateIndex => (paging.page - 1) * paging.size;
}
