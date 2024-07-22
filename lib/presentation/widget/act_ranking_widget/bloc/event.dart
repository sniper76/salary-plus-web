part of 'bloc.dart';

@freezed
class RankingEvent with _$RankingEvent {
  const factory RankingEvent.init() = _OnInit;

  const factory RankingEvent.sort(RankingSortType selectedSortType) = _OnSort;

  const factory RankingEvent.refresh([RankingSortType? selectedSortType]) = _OnRefresh;
}
