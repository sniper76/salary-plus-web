part of '../widget.dart';

class _RankingTableMarketValueAndStakeColumnWidget extends StatelessWidget {
  final String mainString;
  final String subString;

  const _RankingTableMarketValueAndStakeColumnWidget({required this.mainString, required this.subString});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mainString,
            textScaler: TextScaler.noScaling,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            '($subString)',
            textScaler: TextScaler.noScaling,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
