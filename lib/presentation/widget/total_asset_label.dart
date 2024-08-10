import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/widget/app_badge.dart';
import 'package:flutter/material.dart';

class TotalAssetLabel extends StatelessWidget {
  final String text;

  const TotalAssetLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBadge(
      radius: 4,
      color: const Color(0xffFFEFF9),
      child: Text(
        text,
        style: context.textTheme.labelMedium?.copyWith(color: const Color(0xffDD0A7F)),
      ),
    );
  }
}
