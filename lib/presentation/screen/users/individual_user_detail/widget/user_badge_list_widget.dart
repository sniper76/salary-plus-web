part of '../screen.dart';

class _UserBadgeListWidget extends StatelessWidget {
  final User user;

  const _UserBadgeListWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '뱃지노출',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: user.userBadgeVisibilities
                .map((badge) => ActSwitch(label: badge.label, value: badge.isVisible))
                .toList(),
          ),
        )
      ],
    );
  }
}
