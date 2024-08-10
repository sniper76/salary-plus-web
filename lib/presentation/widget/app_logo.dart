import 'package:act_cms/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  final Color? color;

  const AppLogo({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.svg',
      colorFilter: ColorFilter.mode(
        context.colorScheme.primary,
        BlendMode.srcIn,
      ),
    );
  }
}
