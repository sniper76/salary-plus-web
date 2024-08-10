// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_statistics_basic_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatisticsBasicItem _$DashboardStatisticsBasicItemFromJson(
        Map<String, dynamic> json) =>
    DashboardStatisticsBasicItem(
      title: json['title'] as String,
      value: (json['value'] as num).toInt(),
      percent: json['percent'] as String,
      upDown: $enumDecode(_$UpDownEnumMap, json['upDown'],
          unknownValue: UpDown.hyphen),
      upDownText: json['upDownText'] as String,
      upDownPercent: json['upDownPercent'] as String,
    );

Map<String, dynamic> _$DashboardStatisticsBasicItemToJson(
        DashboardStatisticsBasicItem instance) =>
    <String, dynamic>{
      'upDown': _$UpDownEnumMap[instance.upDown]!,
      'upDownText': instance.upDownText,
      'upDownPercent': instance.upDownPercent,
      'title': instance.title,
      'value': instance.value,
      'percent': instance.percent,
    };

const _$UpDownEnumMap = {
  UpDown.up: 'Up',
  UpDown.down: 'Down',
  UpDown.hyphen: '-',
};
