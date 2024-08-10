// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WriteCount _$WriteCountFromJson(Map<String, dynamic> json) => WriteCount(
      current: (json['current'] as num).toInt(),
      max: (json['max'] as num).toInt(),
    );

Map<String, dynamic> _$WriteCountToJson(WriteCount instance) =>
    <String, dynamic>{
      'current': instance.current,
      'max': instance.max,
    };
