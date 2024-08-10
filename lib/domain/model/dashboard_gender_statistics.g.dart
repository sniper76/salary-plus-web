// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_gender_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardGenderStatistics _$DashboardGenderStatisticsFromJson(
        Map<String, dynamic> json) =>
    DashboardGenderStatistics(
      type: json['type'] as String,
      title: json['title'] as String,
      periodType: json['periodType'] as String,
      total: (json['total'] as num).toInt(),
      male: DashboardStatisticsBasicItem.fromJson(
          json['male'] as Map<String, dynamic>),
      female: DashboardStatisticsBasicItem.fromJson(
          json['female'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardGenderStatisticsToJson(
        DashboardGenderStatistics instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'periodType': instance.periodType,
      'total': instance.total,
      'male': instance.male,
      'female': instance.female,
    };
