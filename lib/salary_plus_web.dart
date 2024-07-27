import 'dart:async';

import 'package:salary_plus_web/config/constants.dart';
import 'package:salary_plus_web/config/theme.dart';
import 'package:salary_plus_web/core/route/app_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalaryPlusWeb extends StatefulWidget {
  const SalaryPlusWeb({super. key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _SalaryPlusWebState state = context.findAncestorStateOfType<_SalaryPlusWebState>()!;
    state.setLocale(newLocale);
  }

  @override
  State<SalaryPlusWeb> createState() => _SalaryPlusWebState();
}

class _SalaryPlusWebState extends State<SalaryPlusWeb> {
  final AppRouter appRouter = AppRouter();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
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
        navigatorObservers: () => [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
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
        // MonthYearPickerLocalizations.delegate,
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
    );
  }
}
