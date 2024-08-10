import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final Color color;
  final double radius;
  final EdgeInsets padding;

  const Label({
    super.key,
    required this.text,
    this.radius = 4,
    this.color = Colors.blue,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: const BoxConstraints(minWidth: 24, minHeight: 20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: color,
          height: 1.18,
        ),
      ),
    );
  }
}
