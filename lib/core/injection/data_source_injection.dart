import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/data/datasource/local/local_storage_datasource.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/datasource/remote/api_request_dio_factory.dart';
import 'package:act_web/data/datasource/remote/api_request_header_handler.dart';
import 'package:get_it/get_it.dart';

class DataSourceInjection {
  static inject() {
    GetIt.I.registerSingleton<ApiRequestHeaderHandler>(ApiRequestHeaderHandler());
    GetIt.I.registerSingleton<ApiRequestDioFactory>(
      ApiRequestDioFactory(
        authService: GetIt.I<UserAuthService>(),
        apiRequestHeaderHandler: GetIt.I<ApiRequestHeaderHandler>(),
      ),
    );

    GetIt.I.registerSingleton<ApiDataSource>(
      ApiDataSource(
        ApiRequestDioFactory(
          authService: GetIt.I<UserAuthService>(),
          apiRequestHeaderHandler: GetIt.I<ApiRequestHeaderHandler>(),
        ),
        GetIt.I<ApiRequestDioFactory>().get,
      ),
    );

    // for polling
    GetIt.I.registerSingleton<ApiDataSource>(
      ApiDataSource(
        ApiRequestDioFactory(
          authService: GetIt.I<UserAuthService>(),
          apiRequestHeaderHandler: GetIt.I<ApiRequestHeaderHandler>(),
        ),
        GetIt.I<ApiRequestDioFactory>().getDioForPolling,
      ),
      instanceName: 'polling_api_datasource',
    );

    GetIt.I.registerSingleton<LocalStorageDataSource>(LocalStorageDataSource());
  }
}
