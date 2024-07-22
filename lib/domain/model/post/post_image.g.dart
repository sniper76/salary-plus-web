// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImageImpl _$$PostImageImplFromJson(Map<String, dynamic> json) =>
    _$PostImageImpl(
      imageId: (json['imageId'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$PostImageImplToJson(_$PostImageImpl instance) =>
    <String, dynamic>{
      'imageId': instance.imageId,
      'imageUrl': instance.imageUrl,
    };
