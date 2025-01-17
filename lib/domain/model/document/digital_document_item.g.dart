// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'digital_document_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DigitalDocumentItemImpl _$$DigitalDocumentItemImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalDocumentItemImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      leaderDescription: json['leaderDescription'] as String?,
      defaultSelectValue: $enumDecodeNullable(
          _$DigitalDocumentAnswerTypeEnumMap, json['defaultSelectValue']),
      childItems: (json['childItems'] as List<dynamic>?)
          ?.map((e) => DigitalDocumentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DigitalDocumentItemImplToJson(
        _$DigitalDocumentItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'leaderDescription': instance.leaderDescription,
      'defaultSelectValue':
          _$DigitalDocumentAnswerTypeEnumMap[instance.defaultSelectValue],
      'childItems': instance.childItems,
    };

const _$DigitalDocumentAnswerTypeEnumMap = {
  DigitalDocumentAnswerType.approval: 'APPROVAL',
  DigitalDocumentAnswerType.rejection: 'REJECTION',
  DigitalDocumentAnswerType.abstention: 'ABSTENTION',
  DigitalDocumentAnswerType.unknown: 'UNKNOWN',
};
