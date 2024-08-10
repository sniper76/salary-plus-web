// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'act_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActException _$ActExceptionFromJson(Map<String, dynamic> json) => ActException(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      errorCode: (json['errorCode'] as num?)?.toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$ActExceptionToJson(ActException instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'errorCode': instance.errorCode,
      'message': instance.message,
    };
