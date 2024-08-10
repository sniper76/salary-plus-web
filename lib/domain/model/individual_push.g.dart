// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_push.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndividualPush _$IndividualPushFromJson(Map<String, dynamic> json) =>
    IndividualPush(
      user: PushUser.fromJson(json['user'] as Map<String, dynamic>),
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$IndividualPushToJson(IndividualPush instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'user': instance.user,
    };
