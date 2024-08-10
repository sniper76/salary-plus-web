import 'package:flutter/material.dart';

class ActFilterButton extends StatelessWidget {
  static const mainColor = Color(0xff2A4ABA);
  final String text;
  final bool isSelected;
  final void Function()? onPressed;

  const ActFilterButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: isSelected ? mainColor : Colors.grey,
          side: BorderSide(color: isSelected ? mainColor : Colors.grey),
        ),
        child: Text(text),
      ),
    );
  }
}
