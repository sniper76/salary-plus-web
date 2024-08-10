// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paging _$PagingFromJson(Map<String, dynamic> json) => Paging(
      total: (json['totalElements'] as num?)?.toInt() ?? 0,
      totalPage: (json['totalPages'] as num?)?.toInt() ?? 1,
      size: (json['size'] as num?)?.toInt() ?? apiLoadSize,
      page: (json['page'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$PagingToJson(Paging instance) => <String, dynamic>{
      'totalElements': instance.total,
      'totalPages': instance.totalPage,
      'size': instance.size,
      'page': instance.page,
    };
