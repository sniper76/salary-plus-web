import 'package:act_cms/domain/model/dashboard_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dashboard.g.dart';

@JsonSerializable()
class Dashboard {
  final String? descriptionLabel;
  final DashboardItem? items;

  const Dashboard({this.descriptionLabel, this.items});

  factory Dashboard.fromJson(Map<String, dynamic> json) => _$DashboardFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}
