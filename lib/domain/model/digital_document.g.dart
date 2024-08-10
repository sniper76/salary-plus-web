// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DigitalDocument _$DigitalDocumentFromJson(Map<String, dynamic> json) =>
    DigitalDocument(
      id: (json['id'] as num).toInt(),
      documentType: $enumDecodeNullable(
          _$DigitalDocumentTypeEnumMap, json['digitalDocumentType'],
          unknownValue: DigitalDocumentType.unknown),
      stock: json['stock'] == null
          ? null
          : DigitalDocumentStock.fromJson(
              json['stock'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : DigitalDocumentUser.fromJson(json['user'] as Map<String, dynamic>),
      acceptUser: json['acceptUser'] == null
          ? null
          : DigitalDocumentAcceptUser.fromJson(
              json['acceptUser'] as Map<String, dynamic>),
      itemGroups: (json['items'] as List<dynamic>?)
          ?.map((e) => DigitalDocumentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      answerStatus: $enumDecodeNullable(
          _$DigitalDocumentAnswerStatusTypeEnumMap, json['answerStatus']),
      targetStartDate: json['targetStartDate'] == null
          ? null
          : DateTime.parse(json['targetStartDate'] as String),
      targetEndDate: json['targetEndDate'] == null
          ? null
          : DateTime.parse(json['targetEndDate'] as String),
      joinStockSum: (json['joinStockSum'] as num?)?.toInt(),
      joinUserCount: (json['joinUserCount'] as num?)?.toInt(),
      shareholdingRatio: (json['shareholdingRatio'] as num?)?.toDouble(),
      title: json['title'] as String?,
      digitalDocumentDownload: json['digitalDocumentDownload'] == null
          ? null
          : DigitalDocumentDownload.fromJson(
              json['digitalDocumentDownload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DigitalDocumentToJson(DigitalDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'digitalDocumentType':
          _$DigitalDocumentTypeEnumMap[instance.documentType],
      'stock': instance.stock,
      'user': instance.user,
      'acceptUser': instance.acceptUser,
      'items': instance.itemGroups,
      'answerStatus':
          _$DigitalDocumentAnswerStatusTypeEnumMap[instance.answerStatus],
      'targetStartDate': instance.targetStartDate?.toIso8601String(),
      'targetEndDate': instance.targetEndDate?.toIso8601String(),
      'joinUserCount': instance.joinUserCount,
      'joinStockSum': instance.joinStockSum,
      'shareholdingRatio': instance.shareholdingRatio,
      'title': instance.title,
      'digitalDocumentDownload': instance.digitalDocumentDownload,
    };

const _$DigitalDocumentTypeEnumMap = {
  DigitalDocumentType.digitalProxy: 'DIGITAL_PROXY',
  DigitalDocumentType.newDigitalProxy: 'DIGITAL_PROXY_2',
  DigitalDocumentType.jointOwnership: 'JOINT_OWNERSHIP_DOCUMENT',
  DigitalDocumentType.etc: 'ETC_DOCUMENT',
  DigitalDocumentType.unknown: 'UNKNOWN',
};

const _$DigitalDocumentAnswerStatusTypeEnumMap = {
  DigitalDocumentAnswerStatusType.save: 'SAVE',
  DigitalDocumentAnswerStatusType.complete: 'COMPLETE',
  DigitalDocumentAnswerStatusType.unknown: 'UNKNOWN',
};
