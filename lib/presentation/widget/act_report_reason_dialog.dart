import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/presentation/widget/act_login_dialog/bloc/bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ActReportReasonDialog extends StatefulWidget {
  const ActReportReasonDialog({super.key});

  static Future<String?> show({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return const ActReportReasonDialog();
      },
    );
  }

  @override
  ActReportReasonDialogState createState() => ActReportReasonDialogState();
}

class ActReportReasonDialogState extends State<ActReportReasonDialog> {
  String _checkedItem = '';

  _onItemChanged(String item) {
    setState(() {
      _checkedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        width: 500.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '신고 사유를 선택하세요',
                  style: context.textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    context.router.maybePop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            ...['광고, 홍보 글', '욕설, 비하발언 글', '음란성 글', '개인정보 포함', '주제와 무관한 글', '기타'].map((String reason) => InkWell(
                  onTap: () => _onItemChanged(reason),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  size: 22,
                                  color: reason == _checkedItem ? context.colorScheme.primary : Colors.grey.shade300,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  reason,
                                  style:
                                      context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700, height: 1.3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 14,
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: _checkedItem.isEmpty
                    ? null
                    : () {
                        context.router.maybePop(_checkedItem);
                      },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48.0)),
                child: const Text('신고하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<ActLoginBloc>();
    super.dispose();
  }
}
