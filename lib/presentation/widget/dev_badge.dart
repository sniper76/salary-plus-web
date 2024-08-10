import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class DevBadge extends StatelessWidget {
  const DevBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      child: Text(
        'DEV',
        style: context.textTheme.titleMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}
