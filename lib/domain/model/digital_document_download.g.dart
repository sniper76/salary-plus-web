// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalDocumentDownload _$DigitalDocumentDownloadFromJson(
        Map<String, dynamic> json) =>
    DigitalDocumentDownload(
      id: (json['id'] as num?)?.toInt(),
      requestUserId: (json['requestUserId'] as num?)?.toInt(),
      zipFileStatus: $enumDecodeNullable(
          _$FileDownloadStatusTypeEnumMap, json['zipFileStatus']),
      downloadCount: (json['downloadCount'] as num?)?.toInt(),
      zipFilePath: json['zipFilePath'] as String?,
      zipFileKey: json['zipFileKey'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DigitalDocumentDownloadToJson(
        DigitalDocumentDownload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestUserId': instance.requestUserId,
      'zipFileStatus': _$FileDownloadStatusTypeEnumMap[instance.zipFileStatus],
      'downloadCount': instance.downloadCount,
      'zipFilePath': instance.zipFilePath,
      'zipFileKey': instance.zipFileKey,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$FileDownloadStatusTypeEnumMap = {
  FileDownloadStatusType.request: 'REQUEST',
  FileDownloadStatusType.processing: 'IN_PROGRESS',
  FileDownloadStatusType.complete: 'COMPLETE',
  FileDownloadStatusType.unknown: 'UNKNOWN',
};
