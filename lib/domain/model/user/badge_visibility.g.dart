// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_visibility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BadgeVisibility _$BadgeVisibilityFromJson(Map<String, dynamic> json) =>
    BadgeVisibility(
      label: json['label'] as String,
      isVisible: json['isVisible'] as bool,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BadgeVisibilityToJson(BadgeVisibility instance) =>
    <String, dynamic>{
      'label': instance.label,
      'isVisible': instance.isVisible,
      'name': instance.name,
    };
