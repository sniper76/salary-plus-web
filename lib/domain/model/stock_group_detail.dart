import 'package:act_cms/domain/model/enum/stock_group_status_type.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_group_detail.g.dart';

@JsonSerializable()
class StockGroupDetail {
  final int id;
  final String name;
  final String? description;
  @JsonKey(unknownEnumValue: StockGroupStatusType.unknown)
  final StockGroupStatusType status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<SimpleStock> stocks;

  const StockGroupDetail({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.stocks,
    this.description,
    this.deletedAt,
  });

  factory StockGroupDetail.fromJson(Map<String, dynamic> json) => _$StockGroupDetailFromJson(json);

  Map<String, dynamic> toJson() => _$StockGroupDetailToJson(this);
}
