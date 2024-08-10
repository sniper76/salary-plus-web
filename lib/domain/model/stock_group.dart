import 'package:act_cms/domain/model/enum/stock_group_status_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock_group.g.dart';

@JsonSerializable()
class StockGroup {
  final int id;
  final String name;
  final String? description;
  final int? stockCount;
  @JsonKey(unknownEnumValue: StockGroupStatusType.unknown)
  final StockGroupStatusType status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const StockGroup(
      {required this.id,
      required this.name,
      this.description,
      this.stockCount,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});

  factory StockGroup.fromJson(Map<String, dynamic> json) => _$StockGroupFromJson(json);

  Map<String, dynamic> toJson() => _$StockGroupToJson(this);
}
