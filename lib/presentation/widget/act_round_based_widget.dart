import 'package:flutter/material.dart';

const containerWith = 525.0;
const containerMargin = 24.0;
const containerPadding = 24.0;
const actRoundBaseWidgetTotalWidth = containerMargin * 2 + containerWith;

class ActRoundBasedWidget extends StatelessWidget {
  final Widget child;

  const ActRoundBasedWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWith,
      margin: const EdgeInsets.all(containerMargin),
      padding: const EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}
