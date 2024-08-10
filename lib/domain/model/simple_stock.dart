import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'simple_stock.g.dart';

@JsonSerializable()
class SimpleStock extends Equatable {
  final String code;
  final String name;

  const SimpleStock({
    required this.code,
    required this.name,
  });

  factory SimpleStock.fromJson(Map<String, dynamic> json) => _$SimpleStockFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleStockToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        code,
        name,
      ];
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }
