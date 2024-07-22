part of '../widget.dart';

class _RankingTableOrderColumnWidget extends StatelessWidget {
  final String rankingString;
  final Widget subWidget;

  const _RankingTableOrderColumnWidget({
    required this.rankingString,
    required this.subWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            rankingString,
            textScaler: TextScaler.noScaling,
          ),
          const SizedBox(
            width: 10.0,
          ),
          subWidget
        ],
      ),
    );
  }
}
