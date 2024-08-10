import 'package:json_annotation/json_annotation.dart';

part 'digital_document_stock.g.dart';

@JsonSerializable()
class DigitalDocumentStock {
  final String code;
  final String name;
  final DateTime? referenceDate;
  final int? referenceDateId;
  final String? standardCode;
  final int? referenceDateStockCount;

  const DigitalDocumentStock({
    required this.code,
    required this.name,
    this.referenceDate,
    this.referenceDateStockCount = 0,
    this.referenceDateId,
    this.standardCode,
  });

  factory DigitalDocumentStock.fromJson(Map<String, dynamic> json) => _$DigitalDocumentStockFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentStockToJson(this);
}

extension DigitalDocumentStockExtension on DigitalDocumentStock {
  int get holdingStockCount => referenceDateStockCount ?? 0;
}
