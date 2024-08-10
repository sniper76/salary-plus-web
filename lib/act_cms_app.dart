import 'dart:async';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActCmsApp extends StatefulWidget {
  const ActCmsApp({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _ActCmsAppState state = context.findAncestorStateOfType<_ActCmsAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<ActCmsApp> createState() => _ActCmsAppState();
}

class _ActCmsAppState extends State<ActCmsApp> {
  final appRouter = AppRouter();
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _initialization() async {
    await Future.delayed(AnimationDuration.medium);
    FlutterNativeSplash.remove();

    await _requestTrackingIfNeeded();
  }

  _requestTrackingIfNeeded() async {
    if (await AppTrackingTransparency.trackingAuthorizationStatus == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  @override
  void initState() {
    super.initState();

    _initialization();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(
        deepLinkBuilder: (deepLink) {
          return deepLink;
        },
      ),
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }

        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ko', ''),
      ],
      locale: _locale,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      builder: EasyLoading.init(
        builder: (context, child) => Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) {
                return SelectionArea(
                  child: child ?? const SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
