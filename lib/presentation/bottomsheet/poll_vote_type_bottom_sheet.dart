import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_checked_item.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:flutter/material.dart';

class PollVoteTypeBottomSheet extends StatelessWidget {
  final PollVoteType selectedValue;

  const PollVoteTypeBottomSheet({super.key, this.selectedValue = PollVoteType.person});

  static Future<PollVoteType?> show(BuildContext context, {PollVoteType selectedValue = PollVoteType.person}) {
    return showModalBottomSheet<PollVoteType>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return PollVoteTypeBottomSheet(
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
        ...PollVoteType.values
            .where((element) => element != PollVoteType.unknown)
            .map((e) => BottomSheetCheckedItem(
                  title: e.title,
                  icon: e == selectedValue ? Icons.radio_button_on : Icons.radio_button_off,
                  isChecked: e == selectedValue,
                  onTap: () => Navigator.of(context).pop(e),
                ))
            .toList(),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
