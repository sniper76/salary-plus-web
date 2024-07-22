import 'package:act_web/core/injection/data_source_injection.dart';
import 'package:act_web/core/injection/repository_injection.dart';
import 'package:act_web/core/injection/service_injection.dart';
import 'package:act_web/core/injection/use_case_injection.dart';
import 'package:dio/dio.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:get_it/get_it.dart';

class Injection {
  static initialize() async {
    // dio
    if (GetIt.I.isRegistered<Dio>() == false) {
      GetIt.I.registerSingleton<Dio>(Dio());
    }

    // event bus
    GetIt.I.registerSingleton<IEventBus>(EventBus());

    // service
    await ServiceInjection.inject();

    // data sources
    DataSourceInjection.inject();

    // repository
    RepositoryInjection.inject();

    // use case
    UseCaseInjection.inject();
  }
}
