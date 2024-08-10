import 'dart:async';
import 'package:act_cms/act_cms_app.dart';
import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

void mainCommon() async {
  final log = Logger('ActCmsApp');
  runZonedGuarded(() async {
    final bindings = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: bindings);

    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    await Injection.initialize();
    setPathUrlStrategy();
    runApp(const ActCmsApp());
  }, (error, stackTrace) {
    log.shout("Error in main", error, stackTrace);
  });
}
