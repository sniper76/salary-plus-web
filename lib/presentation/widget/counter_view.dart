import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  final int value;
  final IconData icon;

  const CounterView({super.key, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey.shade400,
        ),
        Text(
          (value > 99999) ? '${99999.toNumberFormat}+' : value.toNumberFormat,
          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400, height: 1.25),
          maxLines: 1,
        ),
      ],
    );
  }
}
