import 'package:act_cms/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigationBarItem extends BottomNavigationBarItem {
  final String? externalUrl;

  AppBottomNavigationBarItem({
    Key? key,
    required String iconAsset,
    required String label,
    Color? color,
    Color? selectedColor,
    this.externalUrl,
  }) : super(
          icon: SvgPicture.asset(
            iconAsset,
            colorFilter: ColorFilter.mode(color ?? Colors.grey.shade600, BlendMode.srcIn),
            width: 28,
            height: 28,
          ),
          activeIcon: SvgPicture.asset(
            iconAsset,
            colorFilter: ColorFilter.mode(selectedColor ?? AppTheme.primaryColor.shade500, BlendMode.srcIn),
            width: 28,
            height: 28,
          ),
          label: label,
        );
}
