// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_delta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayDelta _$TodayDeltaFromJson(Map<String, dynamic> json) => TodayDelta(
      descriptionLabel: json['descriptionLabel'] as String,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => DashboardItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodayDeltaToJson(TodayDelta instance) =>
    <String, dynamic>{
      'descriptionLabel': instance.descriptionLabel,
      'items': instance.items,
    };
