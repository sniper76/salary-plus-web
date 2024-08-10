import 'package:act_cms/presentation/widget/act_admin_badge.dart';
import 'package:act_cms/presentation/widget/solidarity_leader_badge.dart';
import 'package:act_cms/presentation/widget/user_profile_image.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String? profileImageUrl;
  final bool isAdmin;
  final bool isSolidarityLeader;
  final String name;
  final String? nickname;
  final String number;
  final String? email;
  final List<Widget>? actionButtons;

  const UserItem({
    super.key,
    required this.name,
    required this.number,
    this.profileImageUrl,
    this.isAdmin = false,
    this.isSolidarityLeader = false,
    this.nickname,
    this.email,
    this.actionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Wrap(
          spacing: 28,
          children: [
            UserProfileImage(url: profileImageUrl ?? '', size: 80),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBadges(),
                _buildUserInfo(),
              ],
            ),
          ],
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: actionButtons ?? []),
      ],
    );
  }

  Widget _buildBadges() {
    return Row(
      children: [
        isAdmin ? const ActAdminBadge() : const SizedBox(height: 20),
        if (isSolidarityLeader) ...[const SizedBox(height: 8), const SolidarityLeaderBadge()]
      ],
    );
  }

  Widget _buildUserInfo() {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText("$name ($nickname)", style: const TextStyle(fontSize: 12)),
          SelectableText(number, style: const TextStyle(fontSize: 12)),
          SelectableText(email ?? "no email", style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
