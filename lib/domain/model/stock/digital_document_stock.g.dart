// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DigitalDocumentStockImpl _$$DigitalDocumentStockImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalDocumentStockImpl(
      code: json['code'] as String,
      standardCode: json['standardCode'] as String,
      name: json['name'] as String,
      referenceDate: json['referenceDate'] == null
          ? null
          : DateTime.parse(json['referenceDate'] as String),
      referenceDateStockCount:
          (json['referenceDateStockCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$DigitalDocumentStockImplToJson(
        _$DigitalDocumentStockImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'standardCode': instance.standardCode,
      'name': instance.name,
      'referenceDate': instance.referenceDate?.toIso8601String(),
      'referenceDateStockCount': instance.referenceDateStockCount,
    };
