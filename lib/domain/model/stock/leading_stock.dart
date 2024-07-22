import 'package:freezed_annotation/freezed_annotation.dart';

part 'leading_stock.freezed.dart';
part 'leading_stock.g.dart';

@freezed
class LeadingStock with _$LeadingStock {
  const factory LeadingStock({
    required String code,
    required String name,
  }) = _LeadingStock;

  factory LeadingStock.fromJson(Map<String, dynamic> json) => _$LeadingStockFromJson(json);
}
