import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonContainer({super.key, required this.width, required this.height, this.borderRadius = 5});

  static final color = Colors.grey.withAlpha(100);
  static final highlightColor = Colors.grey.shade100;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius), color: color),
      ),
    );
  }
}
