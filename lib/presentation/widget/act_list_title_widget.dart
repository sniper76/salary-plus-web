import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActListTitleWidget extends StatelessWidget {
  final String titleSvgAssetPath;
  final String titleText;
  final Widget? trailingWidget;

  const ActListTitleWidget({
    super.key,
    required this.titleSvgAssetPath,
    required this.titleText,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                titleSvgAssetPath,
                width: 28,
              ),
              const SizedBox(width: 10.0),
              Text(
                titleText,
                style: context.textTheme.displaySmall,
              ),
            ],
          ),
          if (trailingWidget != null) trailingWidget!,
        ],
      ),
    );
  }
}
