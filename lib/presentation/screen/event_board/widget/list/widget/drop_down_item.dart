part of '../widget.dart';

class _DropdownItem<T> extends StatelessWidget {
  final String title;
  final EventBoardListState state;
  final T currentValue;
  final List<T> items;
  final String Function(T) getText;
  final void Function(T?) onChanged;
  const _DropdownItem({
    required this.title,
    required this.state,
    required this.currentValue,
    required this.items,
    required this.getText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 150,
          child: CustomDropdown<T>(
            value: currentValue,
            items: items,
            getText: getText,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
