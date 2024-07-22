import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/presentation/widget/act_login_dialog/widget.dart';
import 'package:act_web/presentation/widget/act_text_form_field.dart';
import 'package:act_web/presentation/widget/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ActCommentTextField extends StatelessWidget {
  final UserAuthService userAuthService = GetIt.I<UserAuthService>();
  final TextEditingController commentController;
  final bool isAnonymousChecked;
  final Function(bool) onChangeAnonymousCheck;
  final Function() onSubmitComment;
  final String? hintText;

  ActCommentTextField({
    super.key,
    required this.commentController,
    required this.isAnonymousChecked,
    required this.onChangeAnonymousCheck,
    required this.onSubmitComment,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userAuthService,
      builder: (context, child) => InkWell(
        onTap: () async {
          if (userAuthService.isAuthenticated() == false) {
            await ActLoginDialog.tryLogin(context);
          }
        },
        child: ActTextFormField(
          enabled: userAuthService.isAuthenticated(),
          controller: commentController,
          maxLines: null,
          hintText: hintText ?? '댓글을 남겨보세요.',
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCheckBox(
                  isChecked: isAnonymousChecked,
                  title: '익명',
                  enabled: true,
                  onChanged: onChangeAnonymousCheck,
                ),
                const SizedBox(
                  width: 24.0,
                ),
                InkWell(
                  onTap: () {
                    onSubmitComment();
                    commentController.clear();
                  },
                  child: ClipOval(
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      color: context.colorScheme.primary,
                      child: const Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
