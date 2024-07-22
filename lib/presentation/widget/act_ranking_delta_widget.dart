import 'package:flutter/material.dart';

class ActRankingDeltaWidget extends StatelessWidget {
  final int rankingDelta;

  const ActRankingDeltaWidget({
    super.key,
    required this.rankingDelta,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_getDeltaStatusString(rankingDelta)}${rankingDelta == 0 ? '' : rankingDelta.abs()}',
      style: TextStyle(fontSize: 12.0, color: _getDeltaColor(rankingDelta)),
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
