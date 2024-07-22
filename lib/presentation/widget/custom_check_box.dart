import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final double size;
  final double? gap;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final String? title;
  final bool enabled;
  final double? fontSize;
  final Function(bool)? onChanged;

  const CustomCheckBox({
    super.key,
    this.isChecked = false,
    this.size = 24,
    this.title,
    this.enabled = true,
    this.onChanged,
    this.gap = 6,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius = BorderRadius.zero,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return InkWell(
      borderRadius: borderRadius,
      onTap: enabled ? () => onChanged?.call(!isChecked) : null,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: isChecked ? colorScheme.primary : Colors.white,
                border: Border.all(color: isChecked ? colorScheme.primary : Colors.grey.shade400, width: 1),
                borderRadius: BorderRadius.circular(size / 2),
              ),
              child: Icon(
                Icons.check_rounded,
                color: isChecked ? Colors.white : Colors.grey.shade300,
                size: 16,
              ),
            ),
            SizedBox(width: gap),
            if (title != null)
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: enabled ? Colors.black87 : Colors.grey.shade300,
                  leadingDistribution: TextLeadingDistribution.even,
                  fontSize: fontSize,
                ),
                textScaler: TextScaler.noScaling,
              ),
          ],
        ),
      ),
    );
  }
}
