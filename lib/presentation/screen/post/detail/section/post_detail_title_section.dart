part of '../screen.dart';

class _PostDetailTitleSection extends StatelessWidget {
  final String? stockCode;
  final String? stockName;

  const _PostDetailTitleSection({this.stockCode, this.stockName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActLogoWidget(
          width: 40.0,
          height: 40.0,
          stockCode: stockCode ?? '',
        ),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          stockName ?? '',
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
        ),
        const SizedBox(width: 12.0),
        Text(
          stockCode ?? '',
          style: context.textTheme.displaySmall?.copyWith(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
