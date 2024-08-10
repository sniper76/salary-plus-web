import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/enum/phone_type.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_item.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';

class PhoneTypeBottomSheet extends StatelessWidget {
  final types = PhoneType.values;
  final PhoneType? selectedType;

  const PhoneTypeBottomSheet({
    super.key,
    this.selectedType,
  });

  static Future<PhoneType?> show(
    BuildContext context, {
    PhoneType? selectedPhoneType,
  }) {
    return showModalBottomSheet<PhoneType>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return PhoneTypeBottomSheet(
          selectedType: selectedPhoneType,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: '통신사 선택',
      children: [
        ...types
            .map(
              (e) => BottomSheetItem(
                title: e.title,
                titleColor: e == selectedType ? context.colorScheme.primary : Colors.grey.shade700,
                onTap: () => Navigator.of(context).pop(e),
              ),
            )
            .toList(),
      ],
    );
  }
}
