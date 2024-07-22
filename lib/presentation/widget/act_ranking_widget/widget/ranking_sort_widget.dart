part of '../widget.dart';

class _RankingSortWidget extends StatelessWidget {
  final RankingSortType type;
  final bool isSelectedType;
  final Function() onChangeRankingSort;

  const _RankingSortWidget({
    required this.isSelectedType,
    required this.type,
    required this.onChangeRankingSort,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChangeRankingSort,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '●',
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.bold,
              color: isSelectedType ? AppTheme.primaryColor[400] : Colors.grey.shade400,
            ),
            textScaler: TextScaler.noScaling,
          ),
          const SizedBox(
            width: 5.0,
          ),
          Text(
            type.label,
            textScaler: TextScaler.noScaling,
            style: TextStyle(
              fontSize: 16.0,
              color: isSelectedType ? Colors.black : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
