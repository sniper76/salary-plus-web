import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/screen/event_board/register/bloc/state.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:act_cms/presentation/widget/push_preview.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PushCheckDialog extends StatelessWidget {
  final EventBoardRegisterState state;

  const PushCheckDialog({required this.state, super.key});

  static Future<bool?> show(BuildContext context, EventBoardRegisterState state) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return PushCheckDialog(state: state);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '푸시내용 확인',
            style: context.textTheme.displaySmall,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              PushPreview(
                title: state.pushRequest?.title,
                targetDatetime: state.activeStartDate,
                content: state.pushRequest?.content ?? '',
                targetSearchType: state.targetType!,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          const Text(
            '푸시를 발송하면 되돌릴 수 없습니다.\n발송하시겠습니까?',
            style: TextStyle(color: Colors.red),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppRoundedButton(
                  text: '취소',
                  radius: 4,
                  backgroundColor: Colors.white,
                  textColor: Colors.grey.shade500,
                  border: BorderSide(color: Colors.grey.shade400),
                  onPressed: () => context.router.pop(false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AppRoundedButton(
                    text: '확인',
                    radius: 4,
                    backgroundColor: AppTheme.primaryColor.shade500,
                    onPressed: () => context.router.pop(true),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
