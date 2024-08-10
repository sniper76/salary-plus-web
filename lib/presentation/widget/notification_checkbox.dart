import 'package:flutter/material.dart';

class NotificationCheckBox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;

  const NotificationCheckBox({super.key, required this.onChange, required this.isChecked});

  @override
  State<NotificationCheckBox> createState() => _NotificationCheckBoxState();
}

class _NotificationCheckBoxState extends State<NotificationCheckBox> {
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "알림 게시",
          style: titleStyle,
        ),
        Checkbox(
            value: widget.isChecked,
            onChanged: (checked) {
              setState(() {
                widget.onChange(widget.isChecked);
              });
            }),
      ],
    );
  }
}
