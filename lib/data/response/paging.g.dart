// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagingImpl _$$PagingImplFromJson(Map<String, dynamic> json) => _$PagingImpl(
      total: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPage: (json['totalPages'] as num?)?.toInt() ?? 1,
      size: (json['size'] as num).toInt(),
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$$PagingImplToJson(_$PagingImpl instance) =>
    <String, dynamic>{
      'totalElements': instance.total,
      'totalPages': instance.totalPage,
      'size': instance.size,
      'page': instance.page,
    };
