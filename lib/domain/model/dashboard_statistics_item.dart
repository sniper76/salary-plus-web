import 'package:json_annotation/json_annotation.dart';

part 'dashboard_statistics_item.g.dart';

@JsonSerializable()
class DashboardStatisticsItem {
  final String key;
  final double value;

  DashboardStatisticsItem({
    required this.key,
    required this.value,
  });

  factory DashboardStatisticsItem.fromJson(Map<String, dynamic> json) => _$DashboardStatisticsItemFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatisticsItemToJson(this);
}
