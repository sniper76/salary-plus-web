// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardItem _$DashboardItemFromJson(Map<String, dynamic> json) =>
    DashboardItem(
      title: json['title'] as String,
      value: json['value'] as String,
      variation: json['variation'] == null
          ? null
          : Variation.fromJson(json['variation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardItemToJson(DashboardItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'variation': instance.variation,
    };
