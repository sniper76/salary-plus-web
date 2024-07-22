import 'dart:io';

import 'package:act_web/config/constants.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/data/datasource/remote/api_request_header_handler.dart';
import 'package:dio/dio.dart';

class ApiRequestDioFactory {
  final UserAuthService authService;
  final ApiRequestHeaderHandler apiRequestHeaderHandler;

  final dio = Dio();
  final dioWithLongTimeout = Dio();
  final getDioForPolling = Dio();

  ApiRequestDioFactory({required this.authService, required this.apiRequestHeaderHandler}) : super() {
    _init(dio, 30000);
    _init(dioWithLongTimeout, 5 * 60 * 60 * 1000);
    _init(getDioForPolling, 5000);
  }

  void _init(Dio dio, int timeout) {
    dio.options.baseUrl = Constants.getEnvironment.getApiBaseUrl();
    dio.options.connectTimeout = Duration(milliseconds: timeout);
    dio.options.receiveTimeout = Duration(milliseconds: timeout);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          apiRequestHeaderHandler.setHeader(options, authService.accessToken);

          return handler.next(options);
        },
        onError: (error, handler) async {
          final response = error.response;
          if (response != null) {
            final statusCode = response.statusCode;
            if (statusCode == HttpStatus.unauthorized) {
              await authService.logout();
              return handler.next(error);
            } else if (statusCode == HttpStatus.forbidden) {
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get get => dio;

  Dio get getDioWithLongTimeout => dioWithLongTimeout;
}
