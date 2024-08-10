// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportHistory _$ReportHistoryFromJson(Map<String, dynamic> json) =>
    ReportHistory(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num).toInt(),
      reportStatus: json['reportStatus'] as String,
      reason: json['reason'] as String?,
      result: json['result'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReportHistoryToJson(ReportHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'reportStatus': instance.reportStatus,
      'reason': instance.reason,
      'result': instance.result,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
