import 'package:act_web/config/theme.dart';
import 'package:act_web/core/route/app_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ActWeb extends StatefulWidget {
  const ActWeb({super.key});

  @override
  State<ActWeb> createState() => _ActWebState();
}

class _ActWebState extends State<ActWeb> {
  final AppRouter appRouter = AppRouter();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ko', 'KR')],
      locale: const Locale('ko', 'KR'),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      color: Colors.white,
    );
  }
}
