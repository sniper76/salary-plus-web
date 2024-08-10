import 'package:act_cms/domain/model/dashboard_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'today_delta.g.dart';

@JsonSerializable()
class TodayDelta {
  final String descriptionLabel;
  final List<DashboardItem>? items;

  const TodayDelta({
    required this.descriptionLabel,
    this.items,
  });

  factory TodayDelta.fromJson(Map<String, dynamic> json) => _$TodayDeltaFromJson(json);

  Map<String, dynamic> toJson() => _$TodayDeltaToJson(this);
}
