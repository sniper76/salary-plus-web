import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;

  const AppBadge({
    Key? key,
    required this.child,
    this.radius = 40,
    this.color,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? const Color(0xff12B886);
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(minWidth: 24, minHeight: 18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? backgroundColor, width: 1),
      ),
      child: child,
    );
  }
}
