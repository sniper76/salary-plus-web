// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_group_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardGroupCategoryImpl _$$BoardGroupCategoryImplFromJson(
        Map<String, dynamic> json) =>
    _$BoardGroupCategoryImpl(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      isGroup: json['isGroup'] as bool? ?? false,
      isExclusiveToHolders: json['isExclusiveToHolders'] as bool? ?? false,
      badgeColor: json['badgeColor'] as String?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => BoardGroupCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BoardGroupCategoryImplToJson(
        _$BoardGroupCategoryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'isGroup': instance.isGroup,
      'isExclusiveToHolders': instance.isExclusiveToHolders,
      'badgeColor': instance.badgeColor,
      'subCategories': instance.subCategories,
    };
