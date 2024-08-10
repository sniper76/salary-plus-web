import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/uri_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:auto_route/auto_route.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

extension ContextExtension on BuildContext {
  /// theme
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  /// color
  ColorScheme get colorScheme => theme.colorScheme;

  /// media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get pixelRatio => mediaQuery.devicePixelRatio;

  bool get isPhone => size.width < 600;

  bool get isTablet => size.width >= 600 && size.width < 720;

  bool get isDesktop => size.width >= 720;

  openLink(String path, {bool inAppWebView = true}) async {
    final uri = Uri.parse(path);
    if (uri.isAppScheme) {
      final lastPath = uri.pathSegments.last;
      if (AppConfig.stockTabMenuNames.contains(lastPath) && router.current.path == '/stock/:stockCode') {
        final eventBus = getIt<IEventBus>();
        eventBus.fire(StockMainTabChangedEvent(tabName: lastPath, path: path, queryString: uri.query));
      } else {
        pushNamedSafety(path);
      }
    } else if (uri.isWebScheme && inAppWebView) {
      openWebView(uri);
    } else if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      showAlertDialog(
        title: '미지원 링크',
        message: '해당 링크는 미지원하는 링크입니다.\n관리자에게 문의해주세요',
      );
    }
  }

  openWebView(Uri uri) {
    router.push(WebRoute(url: uri.toString()));
  }

  Future<T?> pushNamedSafety<T extends Object?>(String path) {
    return router.pushNamed(path, onFailure: (e) {
      showAlertDialog(
        title: '페이지 이동 실패',
        message: '해당 페이지를 찾을 수 없습니다\n관리자에게 문의해주세요',
      );
    });
  }

  Future<bool> showAlertDialog({
    required String title,
    String? message,
    String positiveButtonText = '확인',
  }) async {
    final ret = await showDialog<bool>(
          context: this,
          builder: (context) {
            return PointerInterceptor(
              child: AlertDialog(
                title: Text(
                  title,
                  style: textTheme.displaySmall,
                ),
                titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 22),
                content: (message?.isNotEmpty == true)
                    ? Text(
                        message ?? '',
                        textAlign: TextAlign.center,
                        style: textTheme.headlineSmall?.copyWith(color: Colors.grey.shade500),
                      )
                    : null,
                contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 22),
                actions: [
                  TextButton(
                    onPressed: () => context.router.pop(true),
                    child: Text(
                      positiveButtonText,
                      style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
    return ret;
  }

  Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String positiveButtonText = '확인',
    String negativeButtonText = '취소',
  }) async {
    final ret = await showDialog<bool>(
          barrierColor: Colors.grey.withAlpha(200),
          context: this,
          builder: (context) {
            return PointerInterceptor(
              child: AlertDialog(
                title: Text(
                  title,
                  style: textTheme.displaySmall,
                ),
                titlePadding: const EdgeInsets.only(left: 24, right: 24, top: 22),
                content: message.isNotEmpty
                    ? Text(
                        message,
                        style: textTheme.headlineSmall?.copyWith(color: Colors.grey.shade700),
                      )
                    : null,
                contentPadding: const EdgeInsets.only(left: 24, right: 24, top: 14, bottom: 22),
                actions: [
                  TextButton(
                    onPressed: () => context.router.pop(false),
                    child: Text(
                      negativeButtonText,
                      style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.router.pop(true),
                    child: Text(
                      positiveButtonText,
                      style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
    return ret;
  }

  showFullImage(String url) {
    router.push(FullImageRoute(url: url));
  }

  showAnonymousLimitAlert({required int current, required int max}) {
    showAlertDialog(
      title: '익명 작성 제한',
      message: '하루 동안 작성할 수 있는 \n익명 횟수를 초과 하였습니다\n(현재 : $current개 / 최대 : $max개)',
    );
  }

  showDigitalDocumentCancelConfirmAlert() async {
    final ret = await showConfirmDialog(
        title: '${BoardCategoryType.digitalDelegation.title} 종료',
        message: '종료시 작성된 모든 내용이 초기화 됩니다. 종료 하시겠습니까?',
        positiveButtonText: '종료하기');
    if (ret) {
      router.popUntil((route) {
        return !(route.data?.path.contains('digitaldocument') ?? false);
      });
    }
  }
}
