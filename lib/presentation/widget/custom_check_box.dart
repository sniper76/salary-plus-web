import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final bool isChecked;
  final double size;
  final String? title;
  final bool enabled;
  final Function(bool)? onChanged;

  const CustomCheckBox({
    super.key,
    this.isChecked = false,
    this.size = 24,
    this.title,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return InkWell(
      onTap: enabled ? () => onChanged?.call(!isChecked) : null,
      child: Wrap(
        spacing: 6,
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
          if (title != null)
            Text(
              title ?? '',
              style: context.textTheme.headlineSmall?.copyWith(color: enabled ? Colors.black87 : Colors.grey.shade300),
            ),
        ],
      ),
    );
  }
}
