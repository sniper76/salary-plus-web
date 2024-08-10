part of 'bloc.dart';

@immutable
class CmsState extends BaseState {
  final StockDetail? stockInfo;

  final String periodStockQuantityDaliy;
  final String periodStockQuantityMonthly;
  final bool isStockQuantity;
  final List<StockSummary>? stockQuantityDaliy;
  final List<StockSummary>? stockQuantityMonthly;

  final String periodMemberCountDaliy;
  final String periodMemberCountMonthly;
  final bool isMemberCount;
  final List<StockSummary>? memberCountDaliy;
  final List<StockSummary>? memberCountMonthly;

  final String periodMarketValueDaliy;
  final String periodMarketValueMonthly;
  final bool isMarketValue;
  final List<StockSummary>? marketValueDaliy;
  final List<StockSummary>? marketValueMonthly;

  final String periodStakeDaliy;
  final String periodStakeMonthly;
  final bool isStake;
  final List<StockSummary>? stakeDaliy;
  final List<StockSummary>? stakeMonthly;

  final List<bool> openState;

  const CmsState({
    bool isLoading = false,
    String? errorToastMessage,
    this.stockInfo,
    this.openState = const [false, false, false, false],
    this.stockQuantityDaliy = const [],
    this.stockQuantityMonthly = const [],
    this.memberCountDaliy = const [],
    this.memberCountMonthly = const [],
    this.marketValueDaliy = const [],
    this.marketValueMonthly = const [],
    this.stakeDaliy = const [],
    this.stakeMonthly = const [],
    this.periodStockQuantityDaliy = "202311",
    this.periodMemberCountDaliy = "202311",
    this.periodMarketValueDaliy = "202311",
    this.periodStakeDaliy = "202311",
    this.periodStockQuantityMonthly = "2023",
    this.periodMemberCountMonthly = "2023",
    this.periodMarketValueMonthly = "2023",
    this.periodStakeMonthly = "2023",
    this.isStockQuantity = false,
    this.isMemberCount = false,
    this.isMarketValue = false,
    this.isStake = false,
  }) : super(isLoading: isLoading, errorToastMessage: errorToastMessage ?? '');

  CmsState copyWith({
    bool? isLoading,
    String? errorToastMessage,
    StockDetail? stockInfo,
    List<bool>? openState,
    String? periodStockQuantityDaliy,
    String? periodMemberCountDaliy,
    String? periodMarketValueDaliy,
    String? periodStakeDaliy,
    String? periodStockQuantityMonthly,
    String? periodMemberCountMonthly,
    String? periodMarketValueMonthly,
    String? periodStakeMonthly,
    bool? isStockQuantity,
    bool? isMemberCount,
    bool? isMarketValue,
    bool? isStake,
    List<StockSummary>? stockQuantityDaliy,
    List<StockSummary>? stockQuantityMonthly,
    List<StockSummary>? memberCountDaliy,
    List<StockSummary>? memberCountMonthly,
    List<StockSummary>? marketValueDaliy,
    List<StockSummary>? marketValueMonthly,
    List<StockSummary>? stakeDaliy,
    List<StockSummary>? stakeMonthly,
  }) {
    return CmsState(
      isLoading: isLoading ?? this.isLoading,
      errorToastMessage: errorToastMessage ?? '',
      stockInfo: stockInfo ?? this.stockInfo,
      openState: openState ?? this.openState,
      periodStockQuantityDaliy: periodStockQuantityDaliy ?? this.periodStockQuantityDaliy,
      periodMemberCountDaliy: periodMemberCountDaliy ?? this.periodMemberCountDaliy,
      periodMarketValueDaliy: periodMarketValueDaliy ?? this.periodMarketValueDaliy,
      periodStakeDaliy: periodStakeDaliy ?? this.periodStakeDaliy,
      periodStockQuantityMonthly: periodStockQuantityMonthly ?? this.periodStockQuantityMonthly,
      periodMemberCountMonthly: periodMemberCountMonthly ?? this.periodMemberCountMonthly,
      periodMarketValueMonthly: periodMarketValueMonthly ?? this.periodMarketValueMonthly,
      periodStakeMonthly: periodStakeMonthly ?? this.periodStakeMonthly,
      isStockQuantity: isStockQuantity ?? this.isStockQuantity,
      isMemberCount: isMemberCount ?? this.isMemberCount,
      isMarketValue: isMarketValue ?? this.isMarketValue,
      isStake: isStake ?? this.isStake,
      stockQuantityDaliy: stockQuantityDaliy ?? this.stockQuantityDaliy,
      stockQuantityMonthly: stockQuantityMonthly ?? this.stockQuantityMonthly,
      memberCountDaliy: memberCountDaliy ?? this.memberCountDaliy,
      memberCountMonthly: memberCountMonthly ?? this.memberCountMonthly,
      marketValueDaliy: marketValueDaliy ?? this.marketValueDaliy,
      marketValueMonthly: marketValueMonthly ?? this.marketValueMonthly,
      stakeDaliy: stakeDaliy ?? this.stakeDaliy,
      stakeMonthly: stakeMonthly ?? this.stakeMonthly,
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
        openState,
        periodStockQuantityDaliy,
        periodMemberCountDaliy,
        periodMarketValueDaliy,
        periodStakeDaliy,
        periodStockQuantityMonthly,
        periodMemberCountMonthly,
        periodMarketValueMonthly,
        periodStakeMonthly,
        isStockQuantity,
        isMemberCount,
        isMarketValue,
        isStake,
        stockQuantityDaliy,
        stockQuantityMonthly,
        memberCountDaliy,
        memberCountMonthly,
        marketValueDaliy,
        marketValueMonthly,
        stakeDaliy,
        stakeMonthly,
      ];
}
