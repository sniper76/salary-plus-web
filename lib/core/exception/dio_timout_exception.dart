import 'package:dio/dio.dart';

class DioTimoutException implements Exception {
  final String message;
  final DioException dioException;

  DioTimoutException({
    required this.message,
    required this.dioException,
  });

  @override
  String toString() {
    return 'DioException: $message';
  }
}
