import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/presentation/widget/app_text_form_field.dart';
import 'package:act_cms/presentation/widget/custom_check_box.dart';
import 'package:act_cms/presentation/widget/ripple_button.dart';
import 'package:flutter/material.dart';

class ReplyRegisterToolBar extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool isAnonymous;
  final bool isEdit;
  final bool enabledAnonymous;
  final VoidCallback? onSavePressed;
  final VoidCallback? onCancelPressed;
  final VoidCallback? onDisableAnonymousPressed;
  final Function(bool)? onChangedAnonymous;

  const ReplyRegisterToolBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = '댓글을 남겨보세요',
    this.isAnonymous = false,
    this.isEdit = false,
    this.enabledAnonymous = true,
    this.onSavePressed,
    this.onCancelPressed,
    this.onDisableAnonymousPressed,
    this.onChangedAnonymous,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey.shade300,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    controller: controller,
                    focusNode: focusNode,
                    hintText: hintText,
                    border: 0,
                    keyboardType: TextInputType.text,
                    margin: EdgeInsets.zero,
                    onSubmitted: onSavePressed,
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 24,
                  children: [
                    if (!isEdit)
                      InkWell(
                        onTap: !enabledAnonymous ? onDisableAnonymousPressed : null,
                        child: CustomCheckBox(
                          isChecked: isAnonymous,
                          title: '익명',
                          enabled: !isEdit && enabledAnonymous,
                          onChanged: onChangedAnonymous,
                        ),
                      ),
                    Wrap(
                      spacing: 6,
                      children: [
                        ClipOval(
                          child: RippleButton(
                            onTap: onSavePressed,
                            backgroundColor: context.colorScheme.primary,
                            foregroundColor: Colors.white,
                            child: const Icon(
                              Icons.arrow_upward_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        if (isEdit)
                          ClipOval(
                            child: RippleButton(
                              onTap: onCancelPressed,
                              backgroundColor: context.colorScheme.onBackground,
                              foregroundColor: Colors.white,
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
