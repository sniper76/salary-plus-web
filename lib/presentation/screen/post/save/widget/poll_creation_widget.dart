part of '../screen.dart';

class _PollCreationWidget extends StatelessWidget {
  final void Function()? onTapPollCreationWidget;
  final bool isPollAdded;

  const _PollCreationWidget({required this.onTapPollCreationWidget, required this.isPollAdded});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapPollCreationWidget,
      child: SvgPicture.asset(
        'assets/images/ic_vote.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          isPollAdded ? context.colorScheme.primary : Colors.grey.shade700,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
