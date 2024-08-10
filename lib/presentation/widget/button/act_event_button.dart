import 'package:act_cms/config/theme.dart';
import 'package:flutter/material.dart';

class ActEventButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Size size;
  final String title;

  const ActEventButton({required this.onPressed, required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor[600],
        fixedSize: size,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
