// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_statistics_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatisticsSummary _$DashboardStatisticsSummaryFromJson(
        Map<String, dynamic> json) =>
    DashboardStatisticsSummary(
      upDown: $enumDecode(_$UpDownEnumMap, json['upDown'],
          unknownValue: UpDown.hyphen),
      upDownText: json['upDownText'] as String,
      upDownPercent: json['upDownPercent'] as String,
    );

Map<String, dynamic> _$DashboardStatisticsSummaryToJson(
        DashboardStatisticsSummary instance) =>
    <String, dynamic>{
      'upDown': _$UpDownEnumMap[instance.upDown]!,
      'upDownText': instance.upDownText,
      'upDownPercent': instance.upDownPercent,
    };

const _$UpDownEnumMap = {
  UpDown.up: 'Up',
  UpDown.down: 'Down',
  UpDown.hyphen: '-',
};
