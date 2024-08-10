import 'package:json_annotation/json_annotation.dart';

part 'stock_reference_date.g.dart';

@JsonSerializable()
class StockReferenceDate {
  final int id;
  final String stockCode;
  final DateTime referenceDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StockReferenceDate({
    required this.id,
    required this.stockCode,
    required this.referenceDate,
    this.createdAt,
    this.updatedAt,
  });

  factory StockReferenceDate.fromJson(Map<String, dynamic> json) => _$StockReferenceDateFromJson(json);

  Map<String, dynamic> toJson() => _$StockReferenceDateToJson(this);
}

// extension StockGroupExtention on StockGroup {
//   String get logoUrl =>
//       'https://cdn.deepsearch.com/company/logo/${this.code}.png';
// }
