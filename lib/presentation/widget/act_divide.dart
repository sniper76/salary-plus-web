import 'package:flutter/material.dart';

class ActDivide extends StatelessWidget {
  final double? height;

  const ActDivide({super.key, this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Container(height: height, color: Colors.grey.shade200);
  }
}
