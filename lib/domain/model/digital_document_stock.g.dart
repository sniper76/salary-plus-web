// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalDocumentStock _$DigitalDocumentStockFromJson(
        Map<String, dynamic> json) =>
    DigitalDocumentStock(
      code: json['code'] as String,
      name: json['name'] as String,
      referenceDate: json['referenceDate'] == null
          ? null
          : DateTime.parse(json['referenceDate'] as String),
      referenceDateStockCount:
          (json['referenceDateStockCount'] as num?)?.toInt() ?? 0,
      referenceDateId: (json['referenceDateId'] as num?)?.toInt(),
      standardCode: json['standardCode'] as String?,
    );

Map<String, dynamic> _$DigitalDocumentStockToJson(
        DigitalDocumentStock instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'referenceDate': instance.referenceDate?.toIso8601String(),
      'referenceDateId': instance.referenceDateId,
      'standardCode': instance.standardCode,
      'referenceDateStockCount': instance.referenceDateStockCount,
    };
