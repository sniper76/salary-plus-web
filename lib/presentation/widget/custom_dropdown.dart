import 'package:flutter/material.dart';

class CustomDropdown<DropdownType> extends StatelessWidget {
  final DropdownType value;
  final List<DropdownType> items;
  final String Function(DropdownType) getText;
  final void Function(DropdownType? newValue)? onChanged;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.getText,
    this.onChanged,
    this.hintText = '카테고리 선택',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: 200,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DropdownType>(
          focusColor: Colors.white,
          padding: const EdgeInsets.only(left: 24.0, right: 16.0),
          value: value,
          hint: Text(hintText),
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: onChanged,
          items: items.map((value) {
            return DropdownMenuItem<DropdownType>(
              value: value,
              child: Text(
                getText(value),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            );
          }).toList(),
          isExpanded: true,
        ),
      ),
    );
  }
}
