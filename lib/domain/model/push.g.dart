// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Push _$PushFromJson(Map<String, dynamic> json) => Push(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      title: json['title'] as String?,
      targetDatetime: json['targetDatetime'] == null
          ? null
          : DateTime.parse(json['targetDatetime'] as String),
      sentStartDatetime: json['sentStartDatetime'] == null
          ? null
          : DateTime.parse(json['sentStartDatetime'] as String),
      sentEndDatetime: json['sentEndDatetime'] == null
          ? null
          : DateTime.parse(json['sentEndDatetime'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PushToJson(Push instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'title': instance.title,
      'targetDatetime': instance.targetDatetime?.toIso8601String(),
      'sentStartDatetime': instance.sentStartDatetime?.toIso8601String(),
      'sentEndDatetime': instance.sentEndDatetime?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
