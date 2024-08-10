import 'package:act_cms/domain/model/dashboard.dart';
import 'package:act_cms/domain/model/leader.dart';
import 'package:act_cms/domain/model/section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_home.g.dart';

@JsonSerializable()
class StockHome {
  final Dashboard? dashboard;
  final Leader? leader;
  final List<Section> sections;

  const StockHome({
    this.dashboard,
    this.leader,
    required this.sections,
  });

  factory StockHome.fromJson(Map<String, dynamic> json) => _$StockHomeFromJson(json);

  Map<String, dynamic> toJson() => _$StockHomeToJson(this);
}
