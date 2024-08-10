import 'package:flutter/material.dart';

class ActElevatedButton extends StatelessWidget {
  final void Function()? onPressed;

  late final Widget _titleWidget;
   late final ButtonStyle? _style;

  ActElevatedButton({
    super.key,
    this.onPressed,
    Widget? titleWidget,
    ButtonStyle? buttonStyle,
  }) {
    _titleWidget = titleWidget ?? const Text('버튼');
    _style = buttonStyle;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      style: _style,
      child: _titleWidget,
    );
  }
}
