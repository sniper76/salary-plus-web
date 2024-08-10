import 'package:act_cms/domain/model/solidarity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stock.g.dart';

@JsonSerializable()
class Stock {
  final String code;
  final String name;
  final int? quantity;
  final int? displayOrder;
  final Solidarity? solidarity;
  final int? memberCount;
  final double? stake;
  final int? totalIssuedQuantity;

  const Stock({
    required this.code,
    required this.name,
    this.quantity,
    this.displayOrder,
    this.solidarity,
    this.memberCount,
    this.stake,
    this.totalIssuedQuantity,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  Map<String, dynamic> toJson() => _$StockToJson(this);
}

extension StockExtention on Stock {
  String get logoUrl => 'https://cdn.deepsearch.com/company/logo/$code.png';
}
