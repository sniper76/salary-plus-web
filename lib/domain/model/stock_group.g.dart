// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockGroup _$StockGroupFromJson(Map<String, dynamic> json) => StockGroup(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      stockCount: (json['stockCount'] as num?)?.toInt(),
      status: $enumDecode(_$StockGroupStatusTypeEnumMap, json['status'],
          unknownValue: StockGroupStatusType.unknown),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );

Map<String, dynamic> _$StockGroupToJson(StockGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'stockCount': instance.stockCount,
      'status': _$StockGroupStatusTypeEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
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
