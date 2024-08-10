import 'package:flutter/material.dart';

class ActDeleteButton extends StatelessWidget {
  final void Function()? onPressed;

  final bool isActive;
  late final ButtonStyle _style;
  late final Widget _titleWidget;

  ActDeleteButton({
    super.key,
    this.onPressed,
    Widget? titleWidget,
    ButtonStyle? style,
    this.isActive = true,
  }) {
    _style = style ?? ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xffFF0000)));
    _titleWidget = titleWidget ?? const Text('삭제');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive && onPressed != null ? onPressed : null,
      style: isActive ? _style : ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xffD9D9D9))),
      child: isActive ? _titleWidget : const Text('삭제', style: TextStyle(color: Colors.white)),
    );
  }
}
