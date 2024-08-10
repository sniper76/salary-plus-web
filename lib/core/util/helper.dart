import 'dart:async';
import 'dart:io';

import 'package:act_cms/domain/model/error/act_exception.dart';
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
          return Result.error(TimeoutException('서비스 접속에 실패 하였습니다\n잠시 후 다시 시도해주세요 ${e.error}'));
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.cancel:
          return Result.error(Exception('서비스 접속에 실패 하였습니다\n잠시 후 다시 시도해주세요 ${e.error}'));

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

typedef ErrorParserWithResponse<E extends Exception> = E Function(Response);
typedef DefaultErrorParser<E extends Exception> = E Function(Exception);

Future<Result<T, E>> safeCallWithCustomException<T, E extends ActException>(
  Future<T> call, {
  required ErrorParserWithResponse<E> errorParser,
  required DefaultErrorParser<E> defaultErrorParser,
}) async {
  try {
    final response = await call;
    return Success(response);
  } catch (e, _) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.cancel:
          return Result.error(defaultErrorParser(Exception('서비스 접속에 실패 하였습니다\n잠시 후 다시 시도해주세요 ${e.error}')));

        case DioExceptionType.badResponse:
          if (e.response != null) {
            try {
              return Result.error(errorParser(e.response!));
            } catch (error, _) {
              return Result.error(defaultErrorParser(Exception(error)));
            }
          } else {
            try {
              final errorMessage = e.response?.data['message'] ?? e.message;
              return Result.error(defaultErrorParser(Exception(errorMessage)));
            } catch (error, _) {
              return Result.error(defaultErrorParser(Exception(error)));
            }
          }
        case DioExceptionType.unknown:
          if (e.error is SocketException) {
            return Result.error(defaultErrorParser(Exception('서비스 접속에 실패 하였습니다\n잠시 후 다시 시도해주세요 ${e.error}')));
          }
          return Result.error(defaultErrorParser(Exception(e.message)));
        default:
          return Result.error(defaultErrorParser(Exception(e.message)));
      }
    }

    return Result.error(defaultErrorParser(Exception('네트워크 연결상태가 불안정합니다\n네트워크를 확인해주세요 $e')));
  }
}
