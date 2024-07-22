part of '../widget.dart';

class _RankingTableHeaderWidget extends StatelessWidget {
  final String mainString;
  final String? subString;

  const _RankingTableHeaderWidget({
    required this.mainString,
    this.subString,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mainString,
            style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
            textScaler: TextScaler.noScaling,
            textAlign: TextAlign.center,
          ),
          if (subString != null)
            Text(
              subString!,
              style: context.textTheme.bodySmall?.copyWith(color: Colors.white),
              textScaler: TextScaler.noScaling,
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
