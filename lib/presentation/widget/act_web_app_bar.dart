import 'package:act_web/config/constants.dart';
import 'package:flutter/material.dart';

class ActWebAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget leading;
  final Color backgroundColor;
  final List<Widget> actions;

  const ActWebAppBar({
    super.key,
    required this.leading,
    required this.title,
    required this.backgroundColor,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: AppConfig.maxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading,
              Expanded(child: title),
              Row(
                children: actions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(AppConfig.maxWidth, 82);
}
