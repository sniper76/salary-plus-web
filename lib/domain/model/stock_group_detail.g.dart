// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_group_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockGroupDetail _$StockGroupDetailFromJson(Map<String, dynamic> json) =>
    StockGroupDetail(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: $enumDecode(_$StockGroupStatusTypeEnumMap, json['status'],
          unknownValue: StockGroupStatusType.unknown),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      stocks: (json['stocks'] as List<dynamic>)
          .map((e) => SimpleStock.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$StockGroupDetailToJson(StockGroupDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': _$StockGroupStatusTypeEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'stocks': instance.stocks,
    };

const _$StockGroupStatusTypeEnumMap = {
  StockGroupStatusType.active: 'ACTIVE',
  StockGroupStatusType.processing: 'PROCESSING',
  StockGroupStatusType.inactive_by_user: 'INACTIVE_BY_USER',
  StockGroupStatusType.inactive_by_admin: 'INACTIVE_BY_ADMIN',
  StockGroupStatusType.withdawal_by_request: 'WITHDRAWAL_REQUESTED',
  StockGroupStatusType.deleted_by_user: 'DELETED_BY_USER',
  StockGroupStatusType.deleted_by_admin: 'DELETED_BY_ADMIN',
  StockGroupStatusType.unknown: 'UNKNOWN',
};
