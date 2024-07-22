import 'dart:async';
import 'package:act_web/act_web.dart';
import 'package:act_web/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:url_strategy/url_strategy.dart';

void mainCommon() async {
  final log = Logger('ActWeb');
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    await Injection.initialize();

    setPathUrlStrategy();

    runApp(const ActWeb());
  }, (error, stackTrace) {
    log.shout("Error in main", error, stackTrace);
  });
}
