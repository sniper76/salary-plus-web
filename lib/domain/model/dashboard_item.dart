import 'package:act_cms/domain/model/variation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard_item.g.dart';

@JsonSerializable()
class DashboardItem {
  final String title;
  final String value;
  final Variation? variation;

  const DashboardItem({
    required this.title,
    required this.value,
    this.variation,
  });

  factory DashboardItem.fromJson(Map<String, dynamic> json) => _$DashboardItemFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardItemToJson(this);
}
