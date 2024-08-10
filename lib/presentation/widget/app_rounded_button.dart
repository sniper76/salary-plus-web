import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

enum SizeType { medium, small, xsmall }

extension SizeTypeExtention on SizeType {
  EdgeInsets get padding {
    switch (this) {
      case SizeType.medium:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
      case SizeType.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 7);
      case SizeType.xsmall:
        return const EdgeInsets.symmetric(horizontal: 6, vertical: 3);
    }
  }

  Size get minimumSize {
    switch (this) {
      case SizeType.medium:
        return const Size(48, 48);
      case SizeType.small:
        return const Size(48, 32);
      case SizeType.xsmall:
        return const Size(32, 24);
    }
  }
}

class AppRoundedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final SizeType sizeType;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final BorderSide? border;
  final double radius;
  final bool alignmentCenter;
  final Widget? suffixIcon;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const AppRoundedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.sizeType = SizeType.medium,
    this.width,
    this.height,
    this.textColor,
    this.textStyle,
    this.backgroundColor,
    this.border,
    this.radius = 40,
    this.margin,
    this.padding,
    this.alignmentCenter = true,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: sizeType.minimumSize,
          padding: padding ?? sizeType.padding,
          backgroundColor: backgroundColor ?? AppTheme.primaryColor.shade600,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            side: border ?? BorderSide.none,
            borderRadius: BorderRadius.circular(radius),
          ),
          alignment: alignmentCenter ? Alignment.center : Alignment.centerLeft,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: alignmentCenter ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle ??
                  context.textTheme.headlineMedium?.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
      ),
    );
  }
}
