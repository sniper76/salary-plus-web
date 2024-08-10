import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class NumberKeyPad extends StatelessWidget {
  final double? width;
  final double? height;
  final Function(int)? onKeyPressed;
  final VoidCallback? onBackKeyPressed;

  const NumberKeyPad({
    super.key,
    this.width,
    this.height,
    this.onKeyPressed,
    this.onBackKeyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      color: Colors.grey.shade100,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 1,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          if (index == 9) {
            return Container();
          } else if (index == 11) {
            return Container(
              child: TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.grey.shade400),
                onPressed: onBackKeyPressed,
                child: Icon(
                  Icons.arrow_back,
                  size: 26,
                  color: Colors.grey.shade700,
                ),
              ),
            );
          }
          final number = (index == 10) ? 0 : index + 1;
          return TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.grey.shade400),
            onPressed: () {
              onKeyPressed?.call(number);
            },
            child: Text(
              number.toString(),
              style: context.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400),
            ),
          );
        },
      ),
    );
  }
}
