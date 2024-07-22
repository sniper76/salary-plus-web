part of '../screen.dart';

class _SolidarityLeaderElectionNoticeWidget extends StatelessWidget {
  const _SolidarityLeaderElectionNoticeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.campaign,
            size: 40.0,
          ),
          const SizedBox(width: 12.0),
          Text(
            '현재 주주대표 선출이 진행중입니다. 앱에서 주주대표 지원 및 투표에 참여해주세요.',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
