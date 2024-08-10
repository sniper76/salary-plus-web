import 'package:act_cms/domain/model/error/act_exception.dart';
import 'package:act_cms/domain/model/error_data/stop_word_error_data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'stop_word_exception.g.dart';

@JsonSerializable()
class StopWordException extends ActException {
  final StopWordErrorData? errorData;

  StopWordException({
    int? statusCode,
    int? errorCode,
    required String message,
    this.errorData,
  }) : super(
          statusCode: statusCode,
          errorCode: errorCode,
          message: message,
        );

  @override
  String toString() {
    return message;
  }

  factory StopWordException.fromJson(Map<String, dynamic> json) => _$StopWordExceptionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StopWordExceptionToJson(this);
}
