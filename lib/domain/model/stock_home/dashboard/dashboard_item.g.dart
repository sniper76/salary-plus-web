// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DashboardItemImpl _$$DashboardItemImplFromJson(Map<String, dynamic> json) =>
    _$DashboardItemImpl(
      title: json['title'] as String,
      value: json['value'] as String,
      variation: Variation.fromJson(json['variation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DashboardItemImplToJson(_$DashboardItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
      'variation': instance.variation,
    };
