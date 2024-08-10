import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/kcb_terms_agreement_type.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_checked_item.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class KcbTermsAgreementBottomSheet extends StatefulWidget {
  const KcbTermsAgreementBottomSheet({Key? key}) : super(key: key);

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return const KcbTermsAgreementBottomSheet();
        });
  }

  @override
  State<KcbTermsAgreementBottomSheet> createState() => _KcbTermsAgreementBottomSheetState();
}

class _KcbTermsAgreementBottomSheetState extends State<KcbTermsAgreementBottomSheet> {
  final _checkedAgreementMap = <KcbTermsAgreementType, bool>{};
  List<KcbTermsAgreementType> _agreements = KcbTermsAgreementType.values;

  bool get _isRequiredAgreed => _agreements.where((a) => a.isRequired).every((a) => _checkedAgreementMap[a] == true);

  bool get _isAllAgreed {
    return _agreements.every((agreement) => _checkedAgreementMap[agreement] == true);
  }

  _agreeAll() {
    setState(() {
      _agreements.forEach((agreement) {
        _checkedAgreementMap[agreement] = true;
      });
    });
  }

  void toggleIndividual(KcbTermsAgreementType agreement) {
    setState(() {
      _checkedAgreementMap[agreement] = !(_checkedAgreementMap[agreement] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      title: '본인확인을 위해\n약관 동의가 필요합니다',
      useCancelButton: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        InkWell(
          onTap: _agreeAll,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.check,
                    size: 22,
                    color: _isAllAgreed ? context.colorScheme.primary : Colors.grey.shade300,
                  ),
                ),
                Expanded(
                  child: Text(
                    '전체동의',
                    style: context.textTheme.headlineMedium?.copyWith(color: Colors.grey.shade700, height: 1.2),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ..._agreements.map(
          (agreement) => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: BottomSheetCheckedItem(
              title: ' ${agreement.isRequired ? '[필수]' : '[선택]'} ${agreement.title}',
              onTap: () => toggleIndividual(agreement),
              icon: Icons.check,
              isChecked: _checkedAgreementMap[agreement] ?? false,
              suffix: Container(
                height: 22,
                width: 22,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey.shade300,
                ),
              ),
              onSuffixIconTapped: () => context.router.push(
                WebRoute(url: agreement.url, title: agreement.title),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: AppRoundedButton(
            width: double.infinity,
            text: '동의하고 이용하기',
            backgroundColor: _isRequiredAgreed ? AppTheme.primaryColor.shade600 : Colors.grey.shade400,
            radius: 4,
            onPressed: _isRequiredAgreed
                ? () {
                    context.router.pop(true);
                  }
                : null,
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () => context.router.pop(false),
            child: Text(
              '나중에 하기',
              style: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
