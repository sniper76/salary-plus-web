// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockSummary _$StockSummaryFromJson(Map<String, dynamic> json) => StockSummary(
      key: json['key'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$StockSummaryToJson(StockSummary instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
