// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_push.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupPush _$GroupPushFromJson(Map<String, dynamic> json) => GroupPush(
      stockCode: json['stockCode'] as String?,
      stockName: json['stockName'] as String?,
      stockGroupName: json['stockGroupName'] as String?,
      stockGroupId: (json['stockGroupId'] as num?)?.toInt(),
      topic: json['topic'] as String?,
      stockTargetType: $enumDecodeNullable(
              _$PushTargetTypeEnumMap, json['stockTargetType'],
              unknownValue: PushTargetType.unknown) ??
          PushTargetType.unknown,
      sendType: $enumDecodeNullable(_$PushSendTypeEnumMap, json['sendType'],
              unknownValue: PushSendType.unknown) ??
          PushSendType.unknown,
      sendStatus: $enumDecodeNullable(
              _$PushSendStatusEnumMap, json['sendStatus'],
              unknownValue: PushSendStatus.unknown) ??
          PushSendStatus.unknown,
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      title: json['title'] as String,
    );

Map<String, dynamic> _$GroupPushToJson(GroupPush instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'stockCode': instance.stockCode,
      'stockName': instance.stockName,
      'stockGroupName': instance.stockGroupName,
      'title': instance.title,
      'stockGroupId': instance.stockGroupId,
      'topic': instance.topic,
      'stockTargetType': _$PushTargetTypeEnumMap[instance.stockTargetType]!,
      'sendType': _$PushSendTypeEnumMap[instance.sendType]!,
      'sendStatus': _$PushSendStatusEnumMap[instance.sendStatus]!,
    };

const _$PushTargetTypeEnumMap = {
  PushTargetType.all: 'ALL',
  PushTargetType.stock: 'STOCK',
  PushTargetType.stock_group: 'STOCK_GROUP',
  PushTargetType.unknown: 'UNKNOWN',
};

const _$PushSendTypeEnumMap = {
  PushSendType.schedule: 'SCHEDULE',
  PushSendType.immediately: 'IMMEDIATELY',
  PushSendType.unknown: 'UNKNOWN',
};

const _$PushSendStatusEnumMap = {
  PushSendStatus.ready: 'READY',
  PushSendStatus.processing: 'PROCESSING',
  PushSendStatus.complete: 'COMPLETE',
  PushSendStatus.fail: 'FAIL',
  PushSendStatus.unknown: 'UNKNOWN',
};
