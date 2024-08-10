import 'package:act_cms/config/theme.dart';
import 'package:act_cms/domain/model/enum/user_role.dart';
import 'package:flutter/material.dart';

class ActAdminBadge extends StatelessWidget {
  const ActAdminBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(color: AppTheme.primaryColor[700], borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          UserRole.admin.value,
          style: const TextStyle(fontSize: 12, color: Colors.white, height: 1.4, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
