import 'package:json_annotation/json_annotation.dart';

part 'simple_stock_group.g.dart';

@JsonSerializable()
class SimpleStockGroup {
  final int id;
  final String name;

  const SimpleStockGroup({
    required this.id,
    required this.name,
  });

  factory SimpleStockGroup.fromJson(Map<String, dynamic> json) => _$SimpleStockGroupFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleStockGroupToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }
