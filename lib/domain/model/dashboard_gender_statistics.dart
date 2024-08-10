import 'package:act_cms/domain/model/dashboard_statistics_basic_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_gender_statistics.g.dart';

@JsonSerializable()
class DashboardGenderStatistics {
  final String type;
  final String title;
  final String periodType;
  final int total;
  final DashboardStatisticsBasicItem male;
  final DashboardStatisticsBasicItem female;

  DashboardGenderStatistics({
    required this.type,
    required this.title,
    required this.periodType,
    required this.total,
    required this.male,
    required this.female,
  });

  factory DashboardGenderStatistics.fromJson(Map<String, dynamic> json) => _$DashboardGenderStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardGenderStatisticsToJson(this);
}
