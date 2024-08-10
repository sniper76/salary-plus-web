import 'package:flutter/material.dart';

class DataGridItem extends StatelessWidget {
  final String label;
  final Alignment alignment;

  const DataGridItem({Key? key, required this.label, this.alignment = Alignment.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Color(0xFF27292C),
          decoration: TextDecoration.none,
          fontFamily: 'NanumSquare',
          fontSize: 12,
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
          height: 1.33,
        ),
      ),
    );
  }
}
