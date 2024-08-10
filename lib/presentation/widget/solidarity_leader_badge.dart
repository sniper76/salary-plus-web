import 'package:flutter/material.dart';

class SolidarityLeaderBadge extends StatelessWidget {
  const SolidarityLeaderBadge({super.key, this.width, this.height, this.fontSize = 12});

  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: width,
      height: height,
      decoration: BoxDecoration(color: const Color(0xffFF9650), borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          "주주대표",
          style: TextStyle(fontSize: fontSize ?? 12, color: Colors.white, height: 1.4, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
