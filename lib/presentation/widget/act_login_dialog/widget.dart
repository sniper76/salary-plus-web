import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/string_extension.dart';
import 'package:act_web/core/util/format_utils.dart';
import 'package:act_web/presentation/widget/act_login_dialog/bloc/bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';

part 'widget/dialog_title_widget.dart';
part 'widget/web_login_guide_dialog.dart';

part 'section/content_section.dart';
part 'section/footer_section.dart';

part 'handler.dart';

class ActLoginDialog extends StatefulWidget {
  const ActLoginDialog({super.key});

  static Future<bool?> show({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return const ActLoginDialog();
      },
    );
  }

  static Future<bool> tryLogin(BuildContext context) async {
    return ActLoginDialog.show(context: context).then(
      (bool? isLoginSuccess) {
        if (isLoginSuccess == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('로그인에 실패했습니다.'),
            ),
          );
          return false;
        } else if (isLoginSuccess == true) {
          context.showAlertDialog(
            title: '웹 로그인 완료',
            message: '웹 로그인을 위한 인증이 완료되었습니다.'.wordBreak,
          );
          return true;
        }
        return false;
      },
    );
  }

  @override
  ActLoginDialogState createState() => ActLoginDialogState();
}

class ActLoginDialogState extends State<ActLoginDialog> {
  @override
  void initState() {
    super.initState();
    if (GetIt.I.isRegistered<ActLoginBloc>() == false) {
      GetIt.I.registerSingleton(ActLoginBloc());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<ActLoginBloc>()..add(const ActLoginEvent.init()),
      child: BlocListener<ActLoginBloc, ActLoginState>(
        listener: (context, state) {
          if (state.errorToastMessage?.isNotEmpty == true) {
            context.router.maybePop(false);
          }

          if (state.isLoginSuccess == true) {
            context.router.maybePop(true);
          }
        },
        child: Dialog(
          child: Container(
            padding: const EdgeInsets.all(32.0),
            width: 500.0,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _DialogTitleWidget(title: '웹 로그인'),
                SizedBox(height: 24.0),
                _ContentSection(),
                _FooterSection(),
              ],
            ),
          ),
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
