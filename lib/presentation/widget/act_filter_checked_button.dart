import 'package:act_web/config/theme.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ActFilterCheckedButton extends StatelessWidget {
  final String text;
  final bool isChecked;
  final VoidCallback? onTap;

  const ActFilterCheckedButton({
    super.key,
    required this.text,
    this.isChecked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            ClipOval(
              child: Container(
                width: 6,
                height: 6,
                color: isChecked ? AppTheme.primaryColor.shade500 : Colors.grey.shade300,
              ),
            ),
            Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isChecked ? Colors.grey.shade700 : Colors.grey.shade500,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
