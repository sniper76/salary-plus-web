import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget child;

  const RippleButton({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: const Size(20, 20),
          foregroundColor: foregroundColor ?? context.colorScheme.primary,
          backgroundColor: backgroundColor,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: padding,
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
