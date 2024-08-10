import 'package:flutter/material.dart';

class BasedLabel extends StatelessWidget {
  static const TextStyle defaultStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const double defaultWidth = 60;

  final String label;
  final List<Widget> children;
  final TextStyle? style;
  final double? width;

  const BasedLabel({super.key, required this.children, required this.label, this.style, this.width});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: width ?? defaultWidth,
        child: Text(
          label,
          style: style ?? defaultStyle,
        ),
      ),
      const SizedBox(width: 32),
      ...children
    ]);
  }
}
