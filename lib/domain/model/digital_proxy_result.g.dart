// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_proxy_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalProxyResult _$DigitalProxyResultFromJson(Map<String, dynamic> json) =>
    DigitalProxyResult(
      templateId: json['templateId'] as String,
      templateName: json['templateName'] as String,
      templateRole: json['templateRole'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: DateTime.parse(json['endedAt'] as String),
    );

Map<String, dynamic> _$DigitalProxyResultToJson(DigitalProxyResult instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'templateName': instance.templateName,
      'templateRole': instance.templateRole,
      'startedAt': dateToJson(instance.startedAt),
      'endedAt': dateToJson(instance.endedAt),
    };
