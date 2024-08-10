import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_checked_item.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:flutter/material.dart';

class ReasonBottomSheet extends StatefulWidget {
  const ReasonBottomSheet({Key? key}) : super(key: key);

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return const ReasonBottomSheet();
        });
  }

  @override
  State<ReasonBottomSheet> createState() => _ReasonBottomSheetState();
}

class _ReasonBottomSheetState extends State<ReasonBottomSheet> {
  String _checkedItem = '';

  _onItemChanged(String item) {
    setState(() {
      _checkedItem = item;
    });
  }

  _onButtonPressed() {
    Navigator.of(context).pop(_checkedItem);
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      useCancelButton: false,
      title: '신고 사유를 선택하세요',
      children: [
        ...['광고, 홍보 글', '욕설, 비하발언 글', '음란성 글', '개인정보 포함', '주제와 무관한 글', '기타']
            .map(
              (e) => BottomSheetCheckedItem(
                title: e,
                isChecked: e == _checkedItem,
                icon: Icons.check_circle_outline,
                onTap: () => _onItemChanged(e),
              ),
            )
            .toList(),
        const SizedBox(
          height: 14,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: AppRoundedButton(
            text: '신고하기',
            backgroundColor: _checkedItem.isEmpty ? Colors.black26 : context.colorScheme.primary,
            textColor: _checkedItem.isEmpty ? Colors.grey.shade700 : Colors.white,
            radius: 6,
            onPressed: _checkedItem.isEmpty ? null : _onButtonPressed,
          ),
        ),
      ],
    );
  }
}
