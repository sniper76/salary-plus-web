// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_carousel_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionCarouselItemImpl _$$SectionCarouselItemImplFromJson(
        Map<String, dynamic> json) =>
    _$SectionCarouselItemImpl(
      header: SectionHeader.fromJson(json['header'] as Map<String, dynamic>),
      listItems: (json['listItems'] as List<dynamic>)
          .map((e) => SectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SectionCarouselItemImplToJson(
        _$SectionCarouselItemImpl instance) =>
    <String, dynamic>{
      'header': instance.header,
      'listItems': instance.listItems,
    };
