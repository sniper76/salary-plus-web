import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MyDataUploadAgreementDialog extends StatelessWidget {
  const MyDataUploadAgreementDialog({super.key});

  static Future<bool?> show(BuildContext context) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return const MyDataUploadAgreementDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: '마이데이터 전자파일에 대한\n',
                  style: context.textTheme.displaySmall,
                  children: [
                    TextSpan(
                      text: '업로드',
                      style: context.textTheme.displaySmall?.copyWith(color: context.colorScheme.primary),
                    ),
                    const TextSpan(text: '를 진행합니다'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '서비스 이용을 위해 업로드에 대한\n동의가 필요합니다',
                  style:
                      context.textTheme.titleMedium?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '업로드 목적',
                      style: context.textTheme.labelLarge,
                    ),
                    Text(
                      '(컨두잇) 액트 서비스 이용',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '업로드 항목',
                      style: context.textTheme.labelLarge,
                    ),
                    Text(
                      '마이데이터 조회 정보',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '보관기간',
                      style: context.textTheme.labelLarge,
                    ),
                    Text(
                      '서비스 이용 기간 동안(탈퇴시 까지)',
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '* 고객님은 업로드 거절할 수 있으며, 비동의 시\n액트 서비스를 이용하실 수 없습니다.',
                      style: context.textTheme.labelLarge?.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppRoundedButton(
                      text: '비동의',
                      radius: 4,
                      backgroundColor: Colors.white,
                      textColor: Colors.grey.shade500,
                      border: BorderSide(color: Colors.grey.shade400),
                      onPressed: () => context.router.pop(false),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppRoundedButton(
                        text: '동의',
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
        ),
      ),
    );
  }
}
