import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_document_stock.freezed.dart';
part 'digital_document_stock.g.dart';

@freezed
class DigitalDocumentStock with _$DigitalDocumentStock {
  const DigitalDocumentStock._();

  const factory DigitalDocumentStock({
    required String code,
    required String standardCode,
    required String name,
    DateTime? referenceDate,
    @Default(0) int? referenceDateStockCount,
  }) = _DigitalDocumentStock;

  factory DigitalDocumentStock.fromJson(Map<String, dynamic> json) => _$DigitalDocumentStockFromJson(json);
}

extension DigitalDocumentStockExtension on DigitalDocumentStock {
  int get holdingStockCount => referenceDateStockCount ?? 0;
}
