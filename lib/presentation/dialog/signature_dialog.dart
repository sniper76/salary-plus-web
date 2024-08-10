import 'dart:io';

import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hand_signature/signature.dart';
import 'package:path_provider/path_provider.dart';

class SignatureDialog extends StatefulWidget {
  const SignatureDialog({super.key});

  static Future<File?> show(BuildContext context) {
    return showDialog<File?>(
      context: context,
      builder: (context) {
        return const SignatureDialog();
      },
    );
  }

  @override
  State<SignatureDialog> createState() => _SignatureDialogState();
}

class _SignatureDialogState extends State<SignatureDialog> {
  final _signatureController = HandSignatureControl(
    threshold: 3.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  _onClear() {
    _signatureController.clear();
  }

  _onCompleted() async {
    if (!_signatureController.isFilled) {
      EasyLoading.showError('서명을 해주세요');
      return;
    }

    final bytes = await _signatureController.toImage(width: 320, height: 200);
    if (bytes == null) return;

    final tempPath = await getTemporaryDirectory();
    final path = '${tempPath.path}/temp_signature_${DateTime.now().millisecondsSinceEpoch}.png';
    final butter = bytes.buffer;
    final signatureFile = await File(path).writeAsBytes(butter.asInt8List(bytes.offsetInBytes, bytes.lengthInBytes));
    context.router.pop(signatureFile);
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
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Text('서명', style: context.textTheme.displaySmall),
            const SizedBox(height: 15),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: HandSignature(
                  control: _signatureController,
                  width: 2.0,
                  maxWidth: 4.5,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _onClear,
          child: Text(
            '다시하기',
            style: context.textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
          ),
        ),
        TextButton(
          onPressed: _onCompleted,
          child: Text(
            '다음',
            style: context.textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
          ),
        ),
      ],
    );
  }
}
