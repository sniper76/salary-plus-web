part of '../widget.dart';

class _RankingTableStockNameColumnWidget extends StatelessWidget {
  final String stockNameString;
  final int index;

  const _RankingTableStockNameColumnWidget({
    required this.stockNameString,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('${stockNameString}_$index'),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      alignment: Alignment.centerLeft,
      height: 56.0,
      child: Text(
        stockNameString,
        textScaler: TextScaler.noScaling,
      ),
    );
  }
}
