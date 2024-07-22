import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/route/app_router.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/usecase/auth/fetch_user_me.dart';
import 'package:act_web/presentation/widget/act_login_dialog/widget.dart';
import 'package:act_web/presentation/widget/act_logo.dart';
import 'package:act_web/presentation/widget/act_web_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultActWebAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DefaultActWebAppBar({super.key});

  @override
  State<DefaultActWebAppBar> createState() => _DefaultActWebAppBarState();

  @override
  Size get preferredSize => const Size(AppConfig.maxWidth, 82);
}

class _DefaultActWebAppBarState extends State<DefaultActWebAppBar> {
  final UserAuthService authService = GetIt.I<UserAuthService>();

  @override
  void didUpdateWidget(covariant DefaultActWebAppBar oldWidget) {
    if (authService.hasAccessToken()) {
      final FetchUserMe fetchUserMe = GetIt.I<FetchUserMe>();
      fetchUserMe().then(
        (result) {
          result.when(
            (_) {},
            (exception) {
              authService.logout();
              authService.setNeedLoginFlag(true);
              context.router.replaceAll([const HomeRoute()]);
            },
          );
        },
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: authService,
        builder: (context, child) {
          if (authService.needLoginPopup == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              authService.setNeedLoginFlag(false);
              await ActLoginDialog.tryLogin(context);
            });
          }

          return ActWebAppBar(
            backgroundColor: Colors.white,
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: const ActLogo(),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    if (AutoRouter.of(context).current.name == StockRoute.name) {
                      return;
                    } else {
                      context.router.push(const StockRoute());
                    }
                  },
                  child: Text(
                    '종목',
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                InkWell(
                  onTap: () {
                    launchUrl(Uri.parse(AppConfig.infoPageUrl));
                  },
                  child: Text(
                    '서비스소개',
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (AutoRouter.of(context).current.name == PostSaveRoute.name) {
                    return;
                  } else {
                    context.router.push(PostSaveRoute());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  fixedSize: const Size(100.0, 45.0),
                ),
                child: const Text('글쓰기'),
              ),
              const SizedBox(width: 40.0),
              authService.isAuthenticated() == false
                  ? ElevatedButton(
                      onPressed: () async {
                        await ActLoginDialog.tryLogin(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(100.0, 45.0),
                      ),
                      child: const Text('로그인'),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        context.showConfirmDialog(title: '안내', message: '로그아웃 하시겠습니까?').then((bool confirmRes) {
                          if (confirmRes == false) return;
                          authService.logout();
                          context.router.replaceAll([const HomeRoute()]);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(100.0, 45.0),
                      ),
                      child: const Text('로그아웃'),
                    ),
              const SizedBox(width: 20.0),
            ],
          );
        });
  }
}
