import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_item.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';

class FilterItem {
  final String title;
  final String value;

  const FilterItem({required this.title, required this.value});
}

class FilterBottomSheet extends StatefulWidget {
  final List<FilterItem> filters;
  final String selectedValue;

  const FilterBottomSheet({Key? key, required this.filters, this.selectedValue = ''}) : super(key: key);

  static Future<String?> show(BuildContext context, {required List<FilterItem> filters, String selectedValue = ''}) {
    return showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return FilterBottomSheet(
            filters: filters,
            selectedValue: selectedValue,
          );
        });
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  _onButtonPressed(FilterItem selectedFilterItem) {
    Navigator.of(context).pop(selectedFilterItem.value);
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            '필터',
            style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        ...widget.filters
            .map((e) => BottomSheetItem(
                  title: e.title,
                  titleTextStyle: context.textTheme.bodyMedium?.copyWith(
                    color: e.value == widget.selectedValue ? Colors.grey.shade50 : Colors.grey.shade300,
                    fontWeight: e.value == widget.selectedValue ? FontWeight.bold : FontWeight.normal,
                  ),
                  icon: e.value == widget.selectedValue ? Icons.check : null,
                  iconSize: 16,
                  onTap: () => _onButtonPressed(e),
                ))
            .toList(),
        const SizedBox(height: 12),
      ],
    );
  }
}
