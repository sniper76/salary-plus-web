import 'package:act_cms/presentation/bottomsheet/bottom_sheet_item.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_menu.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';

class CommentMenuBottomSheet extends StatelessWidget {
  final List<BottomSheetMenu> availableMenu;

  const CommentMenuBottomSheet({Key? key, required this.availableMenu}) : super(key: key);

  static const ownerMenu = [
    BottomSheetMenu.modify,
    BottomSheetMenu.delete,
  ];
  static const otherMenu = [BottomSheetMenu.report];

  static Future<BottomSheetMenu?> show(BuildContext context, {bool isOwner = false}) {
    return showModalBottomSheet<BottomSheetMenu>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return CommentMenuBottomSheet(
            availableMenu: isOwner ? ownerMenu : otherMenu,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      useCancelButton: false,
      children: [
        ...availableMenu
            .map(
              (e) => BottomSheetItem(
                title: e.title,
                icon: e.icon,
                onTap: () {
                  Navigator.of(context).pop(e);
                },
              ),
            )
            .toList(),
      ],
    );
  }
}
