// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searching.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Searching _$SearchingFromJson(Map<String, dynamic> json) => Searching(
      period: (json['period'] as num?)?.toInt(),
      from: json['from'] as String?,
      to: json['to'] as String?,
    );

Map<String, dynamic> _$SearchingToJson(Searching instance) => <String, dynamic>{
      'period': instance.period,
      'from': instance.from,
      'to': instance.to,
    };
