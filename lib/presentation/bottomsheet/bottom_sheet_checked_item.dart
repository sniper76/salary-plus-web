import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class BottomSheetCheckedItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final IconData? icon;
  final Widget? suffix;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixIconTapped;

  const BottomSheetCheckedItem({
    super.key,
    required this.title,
    this.isChecked = false,
    this.icon,
    this.suffix,
    this.onTap,
    this.onSuffixIconTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        icon,
                        size: 22,
                        color: isChecked ? context.colorScheme.primary : Colors.grey.shade300,
                      ),
                    ),
                  Expanded(
                    child: Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            if (suffix != null)
              GestureDetector(
                onTap: onSuffixIconTapped,
                child: suffix,
              ),
          ],
        ),
      ),
    );
  }
}
