// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anonymous_write_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnonymousWriteCount _$AnonymousWriteCountFromJson(Map<String, dynamic> json) =>
    AnonymousWriteCount(
      post: WriteCount.fromJson(json['post'] as Map<String, dynamic>),
      comment: WriteCount.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnonymousWriteCountToJson(
        AnonymousWriteCount instance) =>
    <String, dynamic>{
      'post': instance.post,
      'comment': instance.comment,
    };
