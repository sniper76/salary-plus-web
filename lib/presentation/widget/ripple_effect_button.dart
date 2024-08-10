import 'package:flutter/material.dart';

class RippleEffectButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  const RippleEffectButton({
    super.key,
    required this.child,
    this.margin,
    this.decoration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Ink(
        decoration: decoration,
        child: InkWell(
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
