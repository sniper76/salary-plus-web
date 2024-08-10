import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:act_cms/presentation/widget/app_text_form_field.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ActTextFieldDialog extends StatefulWidget {
  final String title;

  const ActTextFieldDialog({super.key, required this.title});

  static Future<String?> show(
    BuildContext context,
    String title,
  ) {
    return showDialog<String?>(
      context: context,
      builder: (context) {
        return ActTextFieldDialog(
          title: title,
        );
      },
    );
  }

  @override
  State<ActTextFieldDialog> createState() => _ActTextFieldDialogState();
}

class _ActTextFieldDialogState extends State<ActTextFieldDialog> {
  final TextEditingController controller = TextEditingController();

  _onCompleted() async {
    context.router.pop(controller.text);
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 22),
      content: SizedBox(
        width: 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: context.textTheme.displaySmall),
                InkWell(
                  onTap: context.router.pop,
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 5),
            AppTextFormField(
              controller: controller,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        AppRoundedButton(
          onPressed: _onCompleted,
          text: '입력',
        ),
      ],
    );
  }
}
