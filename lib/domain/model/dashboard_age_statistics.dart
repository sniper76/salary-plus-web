import 'package:act_cms/domain/model/dashboard_statistics_basic_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_age_statistics.g.dart';

@JsonSerializable()
class DashboardAgeStatistics {
  final String type;
  final String title;
  final String periodType;
  final int total;
  final DashboardStatisticsBasicItem age10;
  final DashboardStatisticsBasicItem age20;
  final DashboardStatisticsBasicItem age30;
  final DashboardStatisticsBasicItem age40;
  final DashboardStatisticsBasicItem age50;
  final DashboardStatisticsBasicItem age60;
  final DashboardStatisticsBasicItem age70;

  DashboardAgeStatistics({
    required this.type,
    required this.title,
    required this.periodType,
    required this.total,
    required this.age10,
    required this.age20,
    required this.age30,
    required this.age40,
    required this.age50,
    required this.age60,
    required this.age70,
  });

  factory DashboardAgeStatistics.fromJson(Map<String, dynamic> json) => _$DashboardAgeStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardAgeStatisticsToJson(this);
}
