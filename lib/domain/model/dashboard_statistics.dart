import 'package:act_cms/domain/model/dashboard_statistics_item.dart';
import 'package:act_cms/domain/model/dashboard_statistics_summary.dart';
import 'package:act_cms/domain/model/enum/period_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_statistics.g.dart';

@JsonSerializable()
class DashboardStatistics {
  final String type;
  final String title;
  final double value;
  @JsonKey(unknownEnumValue: PeriodType.daily)
  final PeriodType periodType;
  final DashboardStatisticsSummary? summary;
  final List<DashboardStatisticsItem> items;

  DashboardStatistics({
    required this.type,
    required this.title,
    required this.value,
    required this.periodType,
    this.summary,
    required this.items,
  });

  factory DashboardStatistics.fromJson(Map<String, dynamic> json) => _$DashboardStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatisticsToJson(this);

  @override
  String toString() {
    return 'DashboardStatistics(type: $type, title: $title, value: $value, periodType: $periodType, summary: $summary, items: $items)';
  }
}
