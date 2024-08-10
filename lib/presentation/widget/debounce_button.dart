import 'package:flutter/material.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class DebounceButton extends StatelessWidget {
  final Future<void> Function() onTap;
  final Function(BuildContext context, Future<void> Function()? onTap) builder;
  final Duration coolTime;

  const DebounceButton({
    Key? key,
    required this.onTap,
    required this.builder,
    this.coolTime = const Duration(milliseconds: 1300),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapDebouncer(
      cooldown: coolTime,
      onTap: onTap,
      builder: (context, onTap) {
        return builder(context, onTap);
      },
    );
  }
}
