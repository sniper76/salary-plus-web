import 'dart:io';

import 'package:act_web/core/exception/dio_timout_exception.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

Future<Result<T, Exception>> safeCall<T>(Future<T> call) async {
  try {
    final response = await call;
    return Success(response);
  } catch (e, _) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return Result.error(e);
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.cancel:
          return Result.error(
            DioTimoutException(
              message: '서비스 접속에 실패 하였습니다\n잠시 후 다시 시도해주세요 ${e.error}',
              dioException: e,
            ),
          );

        case DioExceptionType.badResponse:
          try {
            final errorMessage = e.response?.data['message'] ?? e.message;
            return Result.error(Exception(errorMessage));
          } catch (error, _) {
            return Result.error(Exception(error));
          }

        case DioExceptionType.unknown:
          if (e.error is SocketException) {
            return Result.error(Exception('서비스 접속에 실패 하였습니다\n잠시 후 다시 시도해주세요 ${e.error}'));
          }
          return Result.error(Exception(e.message));
        default:
          return Result.error(Exception(e.message));
      }
    }

    return Result.error(Exception('네트워크 연결상태가 불안정합니다\n네트워크를 확인해주세요 $e'));
  }
}
