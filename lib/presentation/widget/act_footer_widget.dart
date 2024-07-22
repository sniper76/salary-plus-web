import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ActFooterWidget extends StatelessWidget {
  const ActFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('㈜컨두잇', style: context.textTheme.displayMedium),
        const SizedBox(height: 12.0),
        Text(
          '사업자 등록번호: 571-81-02697 | 대표: 이상목\n07325 서울특별시 영등포구 의사당대로 83, 5층(여의도동 오투타워)',
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            InkWell(
              onTap: () {
                final Uri? policyUri = Uri.tryParse(AppConfig.policyUrl);
                if (policyUri != null) {
                  launchUrl(policyUri);
                }
              },
              child: Text(
                '이용약관',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 30.0),
            InkWell(
              onTap: () {
                final Uri? privacyUri = Uri.tryParse(AppConfig.privacyUrl);
                if (privacyUri != null) {
                  launchUrl(privacyUri);
                }
              },
              child: Text(
                '개인정보 처리방침',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
