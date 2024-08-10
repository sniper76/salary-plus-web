import 'package:flutter/material.dart';

class ActFieldContainer extends StatelessWidget {
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  final List<Widget> children;
  final String title;
  final double? width;
  final Function()? onDelete;

  const ActFieldContainer({super.key, required this.children, required this.title, this.width = 80, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTitle(title),
        const SizedBox(width: 8),
        ...children,
      ],
    );
  }

  Widget _buildTitle(String title) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, textAlign: TextAlign.left, style: titleStyle),
          if (onDelete != null) IconButton(onPressed: onDelete, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
