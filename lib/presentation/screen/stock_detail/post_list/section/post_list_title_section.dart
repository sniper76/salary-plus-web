part of '../screen.dart';

class _PostListTitleSection extends StatelessWidget {
  final String stockCode;
  final BoardGroupType boardGroupType;
  final String? stockName;

  const _PostListTitleSection({
    required this.stockCode,
    required this.boardGroupType,
    this.stockName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActLogoWidget(
          width: 40,
          height: 40,
          stockCode: stockCode,
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          stockName ?? '',
          style: const TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 12.0),
        Text(
          stockCode,
          style: context.textTheme.displaySmall?.copyWith(color: Colors.grey.shade300),
        ),
      ],
    );
  }
}
