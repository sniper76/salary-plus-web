// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_carousel_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionCarouselItem _$SectionCarouselItemFromJson(Map<String, dynamic> json) =>
    SectionCarouselItem(
      header: SectionHeader.fromJson(json['header'] as Map<String, dynamic>),
      listItems: (json['listItems'] as List<dynamic>)
          .map((e) => SectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SectionCarouselItemToJson(
        SectionCarouselItem instance) =>
    <String, dynamic>{
      'header': instance.header,
      'listItems': instance.listItems,
    };
