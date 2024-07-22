import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

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
                    onPressed: () => context.router.maybePop(true),
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
                    onPressed: () => context.router.maybePop(false),
                    child: Text(
                      negativeButtonText,
                      style: textTheme.titleLarge?.copyWith(color: colorScheme.primary),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.router.maybePop(true),
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
}
