import 'package:act_cms/presentation/bottomsheet/bottom_sheet_item.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_menu.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PostMenuBottomSheet extends StatelessWidget {
  final List<BottomSheetMenu> availableMenu;

  const PostMenuBottomSheet({super.key, required this.availableMenu});

  static const ownerMenu = [BottomSheetMenu.modify, BottomSheetMenu.delete];
  static const otherMenu = [BottomSheetMenu.report];

  static Future<BottomSheetMenu?> show(BuildContext context, {bool isOwner = false}) {
    return showModalBottomSheet<BottomSheetMenu>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return PostMenuBottomSheet(
          availableMenu: isOwner ? ownerMenu : otherMenu,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      useCancelButton: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        ...availableMenu.map(
          (e) => BottomSheetItem(
            title: e.title,
            icon: e.icon,
            iconColor: Colors.grey.shade500,
            onTap: () => context.router.pop(e),
          ),
        ),
      ],
    );
  }
}
