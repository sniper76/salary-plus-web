// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holder_list_read_and_copy_digital_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolderListReadAndCopyDigitalDocument
    _$HolderListReadAndCopyDigitalDocumentFromJson(Map<String, dynamic> json) =>
        HolderListReadAndCopyDigitalDocument(
          digitalDocumentId: (json['digitalDocumentId'] as num).toInt(),
          fileName: json['fileName'] as String,
          digitalDocumentOwnerId: (json['userId'] as num).toInt(),
        );

Map<String, dynamic> _$HolderListReadAndCopyDigitalDocumentToJson(
        HolderListReadAndCopyDigitalDocument instance) =>
    <String, dynamic>{
      'digitalDocumentId': instance.digitalDocumentId,
      'fileName': instance.fileName,
      'userId': instance.digitalDocumentOwnerId,
    };
