import 'package:json_annotation/json_annotation.dart';

part 'stock_summary.g.dart';

@JsonSerializable()
class StockSummary {
  final String key;
  final double value;

  const StockSummary({
    required this.key,
    required this.value,
  });

  factory StockSummary.fromJson(Map<String, dynamic> json) => _$StockSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$StockSummaryToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }
