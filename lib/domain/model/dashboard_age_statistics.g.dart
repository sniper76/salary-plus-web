// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_age_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardAgeStatistics _$DashboardAgeStatisticsFromJson(
        Map<String, dynamic> json) =>
    DashboardAgeStatistics(
      type: json['type'] as String,
      title: json['title'] as String,
      periodType: json['periodType'] as String,
      total: (json['total'] as num).toInt(),
      age10: DashboardStatisticsBasicItem.fromJson(
          json['age10'] as Map<String, dynamic>),
      age20: DashboardStatisticsBasicItem.fromJson(
          json['age20'] as Map<String, dynamic>),
      age30: DashboardStatisticsBasicItem.fromJson(
          json['age30'] as Map<String, dynamic>),
      age40: DashboardStatisticsBasicItem.fromJson(
          json['age40'] as Map<String, dynamic>),
      age50: DashboardStatisticsBasicItem.fromJson(
          json['age50'] as Map<String, dynamic>),
      age60: DashboardStatisticsBasicItem.fromJson(
          json['age60'] as Map<String, dynamic>),
      age70: DashboardStatisticsBasicItem.fromJson(
          json['age70'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardAgeStatisticsToJson(
        DashboardAgeStatistics instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'periodType': instance.periodType,
      'total': instance.total,
      'age10': instance.age10,
      'age20': instance.age20,
      'age30': instance.age30,
      'age40': instance.age40,
      'age50': instance.age50,
      'age60': instance.age60,
      'age70': instance.age70,
    };
