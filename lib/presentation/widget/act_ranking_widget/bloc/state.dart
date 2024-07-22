part of 'bloc.dart';

@freezed
class RankingState with _$RankingState, BaseStateMixin {
  factory RankingState({
    required bool isLoading,
    required List<RankingStock> rankingStockList,
    required List<RankingSortType> rankingSortTypeList,
    required RankingSortType currentSortType,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
  }) = _RankingState;

  factory RankingState.initial() {
    return RankingState(
      isLoading: true,
      errorToastMessage: null,
      notiToastMessage: null,
      rankingStockList: [],
      rankingSortTypeList: RankingSortType.values,
      currentSortType: RankingSortType.stakeAsc,
    );
  }
}

extension RankingStateExtension on RankingState {
  RankingState copyWithNull({
    bool? isLoading,
    List<RankingStock>? rankingStockList,
    List<RankingSortType>? rankingSortTypeList,
    RankingSortType? currentSortType,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return RankingState(
      isLoading: isLoading ?? this.isLoading,
      rankingStockList: rankingStockList ?? this.rankingStockList,
      rankingSortTypeList: rankingSortTypeList ?? this.rankingSortTypeList,
      currentSortType: currentSortType ?? this.currentSortType,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}
