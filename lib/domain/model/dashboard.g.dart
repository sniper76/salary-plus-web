// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) => Dashboard(
      descriptionLabel: json['descriptionLabel'] as String?,
      items: json['items'] == null
          ? null
          : DashboardItem.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'descriptionLabel': instance.descriptionLabel,
      'items': instance.items,
    };
