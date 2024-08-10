import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ActSwitch extends StatelessWidget {
  final String label;
  final void Function(bool newState)? onChanged;
  final bool value;

  const ActSwitch({super.key, required this.label, this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 150, child: Text(label, style: context.textTheme.bodySmall)),
        AbsorbPointer(
          absorbing: onChanged == null,
          child: Switch(value: value, onChanged: onChanged ?? (bool checked) {}),
        ),
      ],
    );
  }
}
