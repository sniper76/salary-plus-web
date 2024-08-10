import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingListItem extends StatelessWidget {
  final String assetName;
  final String title;
  final String tailText;
  final VoidCallback? onPressed;

  const SettingListItem({
    Key? key,
    required this.assetName,
    required this.title,
    this.tailText = '',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SvgPicture.asset(assetName),
                  Text(
                    title,
                    style: context.textTheme.headlineSmall?.copyWith(height: 1),
                  ),
                ],
              ),
              if (tailText.isNotEmpty)
                Text(
                  tailText,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
