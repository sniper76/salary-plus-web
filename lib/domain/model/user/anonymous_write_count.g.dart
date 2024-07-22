// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anonymous_write_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AnonymousWriteCountImpl _$$AnonymousWriteCountImplFromJson(
        Map<String, dynamic> json) =>
    _$AnonymousWriteCountImpl(
      post: WriteCount.fromJson(json['post'] as Map<String, dynamic>),
      comment: WriteCount.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AnonymousWriteCountImplToJson(
        _$AnonymousWriteCountImpl instance) =>
    <String, dynamic>{
      'post': instance.post,
      'comment': instance.comment,
    };
