part of 'widget.dart';

extension _ActRankingWidgetStateExension on _ActRankingWidgetState {
  void _onChangeSortType(RankingSortType sortType) {
    final RankingBloc bloc = GetIt.I<RankingBloc>();

    if (sortType == bloc.state.currentSortType) return;

    bloc.add(RankingEvent.sort(sortType));
  }
}
