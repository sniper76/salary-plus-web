import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  bool? enabled;

  CustomTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.enabled,
    this.labelText,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: keyboardType,
        enabled: enabled,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
