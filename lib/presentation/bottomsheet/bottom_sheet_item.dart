import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final String title;
  final Color titleColor;
  final TextStyle? titleTextStyle;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onTap;

  const BottomSheetItem({
    Key? key,
    required this.title,
    this.titleColor = Colors.black,
    this.titleTextStyle,
    this.icon,
    this.iconColor = Colors.black,
    this.iconSize = 22,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  icon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            Text(
              title,
              style: titleTextStyle ??
                  context.textTheme.headlineMedium?.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
