import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ActUserLabelWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color? borderColor;
  final Color textColor;

  const ActUserLabelWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(minWidth: 24, minHeight: 18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: borderColor ?? backgroundColor, width: 1),
      ),
      child: Text(
        text,
        style: context.textTheme.labelMedium?.copyWith(color: textColor),
      ),
    );
  }
}
