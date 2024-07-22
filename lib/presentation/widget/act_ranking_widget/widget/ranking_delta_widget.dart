part of '../widget.dart';

class _RankingDeltaWidget extends StatelessWidget {
  final RankingStock rankingStock;
  final RankingSortType sortType;

  const _RankingDeltaWidget({
    required this.sortType,
    required this.rankingStock,
  });

  @override
  Widget build(BuildContext context) {
    Map<RankingSortType, Widget> rankingDeltaWidgetMap = {
      RankingSortType.stakeAsc: _RankingStakeDeltaWidget(rankingStock: rankingStock),
      RankingSortType.marketValueAsc: _RankingMarketDeltaWidget(rankingStock: rankingStock),
    };

    return rankingDeltaWidgetMap[sortType] ?? const SizedBox.shrink();
  }
}

class _RankingMarketDeltaWidget extends StatelessWidget {
  final RankingStock rankingStock;

  const _RankingMarketDeltaWidget({required this.rankingStock});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getDeltaStatusString(rankingStock.marketValueRankDelta)}${rankingStock.marketValueRankDelta != 0 ? rankingStock.marketValueRankDelta.abs() : ''}',
      style: TextStyle(fontSize: 12.0, color: _getDeltaColor(rankingStock.marketValueRankDelta)),
      textScaler: TextScaler.noScaling,
    );
  }

  String _getDeltaStatusString(int deltaValue) {
    switch (deltaValue) {
      case > 0:
        return '↑';
      case < 0:
        return '↓';
      default:
        return '-';
    }
  }

  Color _getDeltaColor(int deltaValue) {
    switch (deltaValue) {
      case > 0:
        return Colors.red;
      case < 0:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}

class _RankingStakeDeltaWidget extends StatelessWidget {
  final RankingStock rankingStock;

  const _RankingStakeDeltaWidget({required this.rankingStock});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getDeltaStatusString(rankingStock.stakeRankDelta)}${rankingStock.stakeRankDelta != 0 ? rankingStock.stakeRankDelta.abs() : ''}',
      style: TextStyle(fontSize: 12.0, color: _getDeltaColor(rankingStock.stakeRankDelta)),
      textScaler: TextScaler.noScaling,
    );
  }

  String _getDeltaStatusString(int deltaValue) {
    switch (deltaValue) {
      case > 0:
        return '↑';
      case < 0:
        return '↓';
      default:
        return '-';
    }
  }

  Color _getDeltaColor(int deltaValue) {
    switch (deltaValue) {
      case > 0:
        return Colors.red;
      case < 0:
        return Colors.blue;
      default:
        return Colors.black;
    }
  }
}
