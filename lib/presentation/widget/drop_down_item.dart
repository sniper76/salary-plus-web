import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:flutter/material.dart';

class DropdownItem<T> extends StatelessWidget {
  final String title;
  final T currentValue;
  final List<T> items;
  final String Function(T) getText;
  final void Function(T?) onChanged;
  const DropdownItem({
    super.key,
    required this.title,
    required this.currentValue,
    required this.items,
    required this.getText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 150,
          child: CustomDropdown<T>(
            value: currentValue,
            items: items,
            getText: getText,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
