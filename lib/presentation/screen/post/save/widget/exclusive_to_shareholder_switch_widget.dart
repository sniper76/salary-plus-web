part of '../screen.dart';

class _ExclusiveToShareholderSwitchWidget extends StatelessWidget {
  final bool isChecked;
  final void Function(bool?) onChanged;

  const _ExclusiveToShareholderSwitchWidget({required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            child: FittedBox(
              child: CupertinoSwitch(
                value: isChecked,
                onChanged: onChanged,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 6.0),
          Text(
            '주주만 공개',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1),
          )
        ],
      ),
    );
  }
}
