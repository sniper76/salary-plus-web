import 'package:act_cms/domain/model/enum/up_down.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_statistics_summary.g.dart';

@JsonSerializable()
class DashboardStatisticsSummary {
  @JsonKey(unknownEnumValue: UpDown.hyphen)
  final UpDown upDown;
  final String upDownText;
  final String upDownPercent;

  DashboardStatisticsSummary({
    required this.upDown,
    required this.upDownText,
    required this.upDownPercent,
  });

  factory DashboardStatisticsSummary.fromJson(Map<String, dynamic> json) => _$DashboardStatisticsSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatisticsSummaryToJson(this);
}
