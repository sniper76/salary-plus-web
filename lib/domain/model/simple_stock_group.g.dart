// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_stock_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleStockGroup _$SimpleStockGroupFromJson(Map<String, dynamic> json) =>
    SimpleStockGroup(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$SimpleStockGroupToJson(SimpleStockGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
