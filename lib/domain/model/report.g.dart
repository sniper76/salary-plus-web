// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      reportId: (json['reportId'] as num?)?.toInt(),
      contentId: (json['contentId'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      nickname: json['nickname'] as String?,
      contentType: json['contentType'] as String?,
      reportStatus: json['reportStatus'] as String?,
      reason: json['reason'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      reportHistoryList: (json['reportHistoryList'] as List<dynamic>?)
          ?.map((e) => ReportHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'reportId': instance.reportId,
      'contentId': instance.contentId,
      'userId': instance.userId,
      'nickname': instance.nickname,
      'contentType': instance.contentType,
      'reportStatus': instance.reportStatus,
      'reason': instance.reason,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'reportHistoryList': instance.reportHistoryList,
    };
