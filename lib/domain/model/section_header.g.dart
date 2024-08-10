// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionHeader _$SectionHeaderFromJson(Map<String, dynamic> json) =>
    SectionHeader(
      title: json['title'] as String,
      link: json['link'] as String,
      imageUrl: json['image'] as String?,
    );

Map<String, dynamic> _$SectionHeaderToJson(SectionHeader instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'image': instance.imageUrl,
    };
