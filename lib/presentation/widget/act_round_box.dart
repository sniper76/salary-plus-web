import 'package:flutter/material.dart';

class ActRoundBox extends StatelessWidget {
  final Widget child;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;

  const ActRoundBox({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(16),
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      boxShadow: [
        BoxShadow(
          color: Color(0x19000000),
          blurRadius: 11,
          offset: Offset(0, 3),
        ),
      ],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: decoration,
      child: child,
    );
  }
}
