import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const ChartContainer({super.key, required this.child, this.width = 320, this.height = 250});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 11,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
