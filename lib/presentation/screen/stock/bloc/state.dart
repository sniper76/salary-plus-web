part of 'bloc.dart';

@freezed
class StockState with _$StockState, BaseStateMixin, PagingState {
  const StockState._();

  factory StockState({
    required bool isLoading,
    @Default(null) bool? isWholeMySolidarityListFetched,
    required List<SearchRanking> searchRankingList,
    required List<Solidarity> pagedMySolidarityList,
    required List<Solidarity> wholeMySolidarityList,
    required Paging mySolidarityPaging,
    @Default(null) String? errorToastMessage,
    @Default(null) String? notiToastMessage,
  }) = _StockState;

  factory StockState.initial() {
    return StockState(
      isLoading: true,
      isWholeMySolidarityListFetched: null,
      mySolidarityPaging: Paging.initial(),
      searchRankingList: [],
      pagedMySolidarityList: [],
      wholeMySolidarityList: [],
      errorToastMessage: null,
      notiToastMessage: null,
    );
  }

  @override
  Paging get paging => mySolidarityPaging;
}

extension StockStateExtesion on StockState {
  StockState copyWithNull({
    bool? isLoading,
    bool? isWholeMySolidarityListFetched,
    List<SearchRanking>? searchRankingList,
    List<Solidarity>? pagedMySolidarityList,
    List<Solidarity>? wholeMySolidarityList,
    Paging? mySolidarityPaging,
    String? errorToastMessage,
    String? notiToastMessage,
  }) {
    return StockState(
      isLoading: isLoading ?? this.isLoading,
      isWholeMySolidarityListFetched: isWholeMySolidarityListFetched,
      searchRankingList: searchRankingList ?? this.searchRankingList,
      pagedMySolidarityList: pagedMySolidarityList ?? this.pagedMySolidarityList,
      wholeMySolidarityList: wholeMySolidarityList ?? this.wholeMySolidarityList,
      mySolidarityPaging: mySolidarityPaging ?? this.mySolidarityPaging,
      errorToastMessage: errorToastMessage,
      notiToastMessage: notiToastMessage,
    );
  }
}
