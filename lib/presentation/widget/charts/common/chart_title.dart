import 'package:flutter/material.dart';

class ChartTitle extends StatelessWidget {
  final String? title;

  const ChartTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color(0xff999999)),
    );
  }
}
