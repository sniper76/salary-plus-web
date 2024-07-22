import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/route/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActLogo extends StatelessWidget {
  final Color? color;
  final BoxFit? boxFit;

  const ActLogo({super.key, this.color, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (AutoRouter.of(context).current.name == HomeRoute.name) {
          return;
        } else {
          context.router.replace(const HomeRoute());
        }
      },
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        semanticsLabel: 'act app log',
        fit: boxFit ?? BoxFit.fill,
        colorFilter: ColorFilter.mode(
          color ?? context.colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
