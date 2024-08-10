import 'package:json_annotation/json_annotation.dart';

part 'act_exception.g.dart';

@JsonSerializable()
class ActException implements Exception {
  final int? statusCode;
  final int? errorCode;
  final String message;

  ActException({
    this.statusCode,
    this.errorCode,
    required this.message,
  });

  @override
  String toString() {
    return message;
  }

  factory ActException.fromJson(Map<String, dynamic> json) => _$ActExceptionFromJson(json);

  Map<String, dynamic> toJson() => _$ActExceptionToJson(this);
}
