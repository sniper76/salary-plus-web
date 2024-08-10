import 'package:act_cms/config/constants.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_checked_item.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';

class JobBottomSheet extends StatelessWidget {
  final String selectedValue;

  const JobBottomSheet({super.key, this.selectedValue = ''});

  static Future<String?> show(BuildContext context, {String selectedValue = ''}) {
    return showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return JobBottomSheet(
            selectedValue: selectedValue,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      useCancelButton: false,
      children: [
        ...AppConfig.jobItems
            .map((e) => BottomSheetCheckedItem(
                  title: e,
                  icon: e == selectedValue ? Icons.radio_button_on : Icons.radio_button_off,
                  isChecked: e == selectedValue,
                  onTap: () => Navigator.of(context).pop(e),
                ))
            .toList(),
        const SizedBox(height: 12),
      ],
    );
  }
}
