import 'package:act_cms/core/util/file_download_utill.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/cms_main/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_side_menu_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:act_cms/presentation/widget/act_top_menu_bar.dart';

import 'package:act_cms/act_cms_app.dart';

class MainScreen extends StatefulWidget {
  final List<SideMenuRoute> route;

  const MainScreen({super.key, required this.route});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _closeSnackBarAndExecute(BuildContext context, void Function() action) {
    action();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void showMultipleSnackBars(BuildContext context, List<String> fileKeys) {
    void showSnackBar(int index) {
      if (index >= fileKeys.length) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: Text('요청된 파일이 준비되었습니다.')),
                  _buildSnackBarButton(context, '링크복사', () {
                    FileDownloadUtils(context: context).pasteLink(key: fileKeys[index]);
                  }),
                  _buildSnackBarButton(context, '다운로드', () {
                    FileDownloadUtils(context: context).downloadLink(key: fileKeys[index]);
                  })
                ],
              ),
              duration: const Duration(hours: 1),
            ),
          )
          .closed
          .then((_) => showSnackBar(index + 1));
    }

    showSnackBar(0);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout(
      scaffoldKey: _scaffoldKey,
      create: (context) => MainBloc()..add(const MainEvent.initial()),
      listener: (context, MainState state) => {
        if (state.zipFileDownloadList.isNotEmpty) {showMultipleSnackBars(context, state.zipFileDownloadList)}
      },
      builder: (context, bloc, state) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ActSideMenuBar(
            routes: widget.route,
            user: state.userMe,
            onLogout: () {
              bloc.add(const MainEvent.onLogout());
            },
            onSetLocale: () {
              Locale newLocale;
              if (Localizations.localeOf(context).languageCode == 'en') {
                newLocale = const Locale('ko', '');
              } else {
                newLocale = const Locale('en', '');
              }
              ActCmsApp.setLocale(context, newLocale);
            },
          ),
          const Expanded(child: AutoRouter())
        ],
      ),
    );
  }

  Widget _buildSnackBarButton(BuildContext context, String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: () => _closeSnackBarAndExecute(context, onPressed),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
