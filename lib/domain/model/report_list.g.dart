// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportList _$ReportListFromJson(Map<String, dynamic> json) => ReportList(
      reportId: (json['reportId'] as num).toInt(),
      contentId: (json['contentId'] as num).toInt(),
      contentType: json['contentType'] as String?,
      boardCategoryName: json['boardCategoryName'] as String?,
      boardCategoryDisplayName: json['boardCategoryDisplayName'] as String?,
      boardGroupName: json['boardGroupName'] as String?,
      stockCode: json['stockCode'] as String?,
      stockName: json['stockName'] as String?,
      reportStatus: json['reportStatus'] as String?,
      likeCount: (json['likeCount'] as num?)?.toInt(),
      commentCount: (json['commentCount'] as num?)?.toInt(),
      replyCount: (json['replyCount'] as num?)?.toInt(),
      viewCount: (json['viewCount'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ReportListToJson(ReportList instance) =>
    <String, dynamic>{
      'reportId': instance.reportId,
      'contentId': instance.contentId,
      'contentType': instance.contentType,
      'boardCategoryName': instance.boardCategoryName,
      'boardCategoryDisplayName': instance.boardCategoryDisplayName,
      'boardGroupName': instance.boardGroupName,
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'reportStatus': instance.reportStatus,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'replyCount': instance.replyCount,
      'viewCount': instance.viewCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'title': instance.title,
    };
