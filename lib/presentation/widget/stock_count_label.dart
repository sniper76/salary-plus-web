import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/widget/app_badge.dart';
import 'package:flutter/material.dart';

class StockCountLabel extends StatelessWidget {
  final String text;

  const StockCountLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBadge(
      radius: 4,
      color: const Color(0xffE7F5EB),
      child: Text(
        text,
        style: context.textTheme.labelMedium?.copyWith(color: const Color(0xff0E9F33)),
      ),
    );
  }
}
