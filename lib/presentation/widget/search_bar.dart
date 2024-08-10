import 'package:act_cms/presentation/widget/button/act_event_button.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback onSearch;
  final Function onChange;
  final Widget? prefixWidget;
  final String hintText;

  const CustomSearchBar({
    super.key,
    this.controller,
    required this.onSearch,
    required this.onChange,
    this.prefixWidget,
    this.hintText = '검색',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefixWidget != null) prefixWidget!,
        if (prefixWidget != null) const SizedBox(width: 10),
        Expanded(
          child: _SearchTextField(
            controller: controller,
            hintText: hintText,
            onSearch: onSearch,
            onChange: onChange,
          ),
        ),
        const SizedBox(width: 10),
        ActEventButton(onPressed: onSearch, size: const Size(180, 50), title: '검색'),
      ],
    );
  }
}

class _SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback onSearch;
  final Function onChange;

  const _SearchTextField({
    required this.controller,
    required this.hintText,
    required this.onSearch,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) => onSearch(),
      onChanged: (value) => onChange(value),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );
  }
}
