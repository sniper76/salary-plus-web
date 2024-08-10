// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_board_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleBoardGroup _$SimpleBoardGroupFromJson(Map<String, dynamic> json) =>
    SimpleBoardGroup(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => BoardGroupCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimpleBoardGroupToJson(SimpleBoardGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'categories': instance.categories,
    };
