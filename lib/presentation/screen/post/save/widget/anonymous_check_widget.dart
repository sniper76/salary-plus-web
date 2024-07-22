part of '../screen.dart';

class _AnonymousCheckWidget extends StatelessWidget {
  final bool isChecked;

  final void Function(bool) onChanged;

  const _AnonymousCheckWidget({
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCheckBox(
      isChecked: isChecked,
      title: '익명',
      enabled: true,
      onChanged: onChanged,
    );
  }
}
