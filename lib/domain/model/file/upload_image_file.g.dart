// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadImageFileImpl _$$UploadImageFileImplFromJson(
        Map<String, dynamic> json) =>
    _$UploadImageFileImpl(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      originalFilename: json['originalFilename'] as String,
      fileContentType: json['fileContentType'] as String?,
      fileType: json['fileType'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$UploadImageFileImplToJson(
        _$UploadImageFileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'originalFilename': instance.originalFilename,
      'fileContentType': instance.fileContentType,
      'fileType': instance.fileType,
      'description': instance.description,
    };
