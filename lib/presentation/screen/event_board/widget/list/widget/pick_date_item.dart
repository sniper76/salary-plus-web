part of '../widget.dart';

class _PickDateItem extends StatelessWidget {
  final DateTime? selectedDateTime;
  final void Function() onTapFunction;
  final Color? color;

  const _PickDateItem({
    required this.selectedDateTime,
    required this.onTapFunction,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white),
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Center(
            child: Text(
              selectedDateTime?.toFormatString(pattern: 'yyyy-MM-dd HH:mm') ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
