// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockImpl _$$StockImplFromJson(Map<String, dynamic> json) => _$StockImpl(
      name: json['name'] as String,
      code: json['code'] as String,
      quantity: (json['quantity'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt(),
      solidarity: json['solidarity'] == null
          ? null
          : Solidarity.fromJson(json['solidarity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StockImplToJson(_$StockImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'quantity': instance.quantity,
      'displayOrder': instance.displayOrder,
      'solidarity': instance.solidarity,
    };
