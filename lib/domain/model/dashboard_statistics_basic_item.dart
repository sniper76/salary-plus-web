import 'package:act_cms/domain/model/dashboard_statistics_summary.dart';
import 'package:act_cms/domain/model/enum/up_down.dart';
import 'package:act_cms/presentation/util/color.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_statistics_basic_item.g.dart';

@JsonSerializable()
class DashboardStatisticsBasicItem extends DashboardStatisticsSummary {
  final String title;
  final int value;
  final String percent;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Color color = generateRandomColor();

  DashboardStatisticsBasicItem({
    required this.title,
    required this.value,
    required this.percent,
    required UpDown upDown,
    required String upDownText,
    required String upDownPercent,
  }) : super(
          upDown: upDown,
          upDownText: upDownText,
          upDownPercent: upDownPercent,
        );

  factory DashboardStatisticsBasicItem.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatisticsBasicItemFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatisticsBasicItemToJson(this);
}
