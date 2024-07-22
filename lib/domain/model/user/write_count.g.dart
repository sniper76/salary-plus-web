// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'write_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WriteCountImpl _$$WriteCountImplFromJson(Map<String, dynamic> json) =>
    _$WriteCountImpl(
      current: (json['current'] as num).toInt(),
      max: (json['max'] as num).toInt(),
    );

Map<String, dynamic> _$$WriteCountImplToJson(_$WriteCountImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'max': instance.max,
    };
