// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionImpl _$$SectionImplFromJson(Map<String, dynamic> json) =>
    _$SectionImpl(
      type: $enumDecode(_$SectionTypeEnumMap, json['type']),
      header: json['header'] == null
          ? null
          : SectionHeader.fromJson(json['header'] as Map<String, dynamic>),
      carouselItems: (json['carouselItems'] as List<dynamic>?)
          ?.map((e) => SectionCarouselItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      listItems: (json['listItems'] as List<dynamic>?)
          ?.map((e) => SectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SectionImplToJson(_$SectionImpl instance) =>
    <String, dynamic>{
      'type': _$SectionTypeEnumMap[instance.type]!,
      'header': instance.header,
      'carouselItems': instance.carouselItems,
      'listItems': instance.listItems,
    };

const _$SectionTypeEnumMap = {
  SectionType.carousel: 'carousel',
  SectionType.list: 'list',
  SectionType.unknown: 'UNKNOWN',
};
