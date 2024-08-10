import 'package:act_cms/domain/model/stock.dart';
import 'package:json_annotation/json_annotation.dart';

part 'holding_stock.g.dart';

@JsonSerializable()
class HoldingStock {
  final String stockCode;
  final int displayOrder;
  final Stock stock;

  const HoldingStock({
    required this.stockCode,
    required this.displayOrder,
    required this.stock,
  });

  factory HoldingStock.fromJson(Map<String, dynamic> json) => _$HoldingStockFromJson(json);

  Map<String, dynamic> toJson() => _$HoldingStockToJson(this);
}
