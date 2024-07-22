import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:flutter/material.dart';

class CounterView extends StatelessWidget {
  final int value;
  final IconData icon;
  final double width;
  const CounterView({
    super.key,
    required this.value,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Wrap(
        spacing: 6,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey.shade400,
          ),
          Text(
            (value > 999) ? '${999.toNumberFormat}+' : value.toNumberFormat,
            style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400, height: 1.25),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
