import 'package:flutter/material.dart';

class SectionView extends StatelessWidget {
  final Widget body;
  final EdgeInsets? padding;

  const SectionView({
    super.key,
    required this.body,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: const BoxDecoration(color: Colors.white),
      child: body,
    );
  }
}
