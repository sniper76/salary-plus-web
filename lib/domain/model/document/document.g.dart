// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentImpl _$$DocumentImplFromJson(Map<String, dynamic> json) =>
    _$DocumentImpl(
      targetStartDate: json['targetStartDate'] == null
          ? null
          : DateTime.parse(json['targetStartDate'] as String),
      targetEndDate: json['targetEndDate'] == null
          ? null
          : DateTime.parse(json['targetEndDate'] as String),
      answerStatus: $enumDecodeNullable(
          _$DigitalDocumentAnswerStatusTypeEnumMap, json['answerStatus']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DocumentImplToJson(_$DocumentImpl instance) =>
    <String, dynamic>{
      'targetStartDate': instance.targetStartDate?.toIso8601String(),
      'targetEndDate': instance.targetEndDate?.toIso8601String(),
      'answerStatus':
          _$DigitalDocumentAnswerStatusTypeEnumMap[instance.answerStatus],
      'runtimeType': instance.$type,
    };

const _$DigitalDocumentAnswerStatusTypeEnumMap = {
  DigitalDocumentAnswerStatusType.save: 'SAVE',
  DigitalDocumentAnswerStatusType.complete: 'COMPLETE',
  DigitalDocumentAnswerStatusType.unknown: 'UNKNOWN',
};

_$PollImpl _$$PollImplFromJson(Map<String, dynamic> json) => _$PollImpl(
      id: (json['id'] as num).toInt(),
      postId: (json['postId'] as num).toInt(),
      title: json['title'] as String,
      voteType: $enumDecode(_$PollVoteTypeEnumMap, json['voteType']),
      selectionType:
          $enumDecode(_$PollSelectionTypeEnumMap, json['selectionOption']),
      status: json['status'] as String,
      pollItems: (json['pollItems'] as List<dynamic>?)
              ?.map((e) => PollItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      viewType: $enumDecodeNullable(_$PollViewTypeEnumMap, json['viewType']) ??
          PollViewType.vote,
      content: json['content'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => PollAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      targetStartDate: json['targetStartDate'] == null
          ? null
          : DateTime.parse(json['targetStartDate'] as String),
      targetEndDate: json['targetEndDate'] == null
          ? null
          : DateTime.parse(json['targetEndDate'] as String),
      answerStatus: $enumDecodeNullable(
          _$DigitalDocumentAnswerStatusTypeEnumMap, json['answerStatus']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PollImplToJson(_$PollImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'title': instance.title,
      'voteType': _$PollVoteTypeEnumMap[instance.voteType]!,
      'selectionOption': _$PollSelectionTypeEnumMap[instance.selectionType]!,
      'status': instance.status,
      'pollItems': instance.pollItems,
      'viewType': _$PollViewTypeEnumMap[instance.viewType]!,
      'content': instance.content,
      'answers': instance.answers,
      'targetStartDate': _convertDateToString(instance.targetStartDate),
      'targetEndDate': _convertDateToString(instance.targetEndDate),
      'answerStatus':
          _$DigitalDocumentAnswerStatusTypeEnumMap[instance.answerStatus],
      'runtimeType': instance.$type,
    };

const _$PollVoteTypeEnumMap = {
  PollVoteType.person: 'PERSON_BASED',
  PollVoteType.shareholder: 'SHAREHOLDER_BASED',
  PollVoteType.unknown: 'UNKNOWN',
};

const _$PollSelectionTypeEnumMap = {
  PollSelectionType.single: 'SINGLE_ITEM',
  PollSelectionType.multiple: 'MULTIPLE_ITEMS',
  PollSelectionType.unknown: 'UNKNOWN',
};

const _$PollViewTypeEnumMap = {
  PollViewType.vote: 'vote',
  PollViewType.result: 'result',
};

_$DigitalProxyImpl _$$DigitalProxyImplFromJson(Map<String, dynamic> json) =>
    _$DigitalProxyImpl(
      templateId: (json['templateId'] as num).toInt(),
      templateName: json['templateName'] as String,
      templateRole: json['templateRole'] as String,
      targetStartDate: json['targetStartDate'] == null
          ? null
          : DateTime.parse(json['targetStartDate'] as String),
      targetEndDate: json['targetEndDate'] == null
          ? null
          : DateTime.parse(json['targetEndDate'] as String),
      answerStatus: $enumDecodeNullable(
          _$DigitalDocumentAnswerStatusTypeEnumMap, json['answerStatus']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DigitalProxyImplToJson(_$DigitalProxyImpl instance) =>
    <String, dynamic>{
      'templateId': instance.templateId,
      'templateName': instance.templateName,
      'templateRole': instance.templateRole,
      'targetStartDate': instance.targetStartDate?.toIso8601String(),
      'targetEndDate': instance.targetEndDate?.toIso8601String(),
      'answerStatus':
          _$DigitalDocumentAnswerStatusTypeEnumMap[instance.answerStatus],
      'runtimeType': instance.$type,
    };

_$DigitalDocumentImpl _$$DigitalDocumentImplFromJson(
        Map<String, dynamic> json) =>
    _$DigitalDocumentImpl(
      id: (json['id'] as num).toInt(),
      documentType: $enumDecode(
          _$DigitalDocumentTypeEnumMap, json['digitalDocumentType'],
          unknownValue: DigitalDocumentType.unknown),
      attachOptions: DigitalDocumentAttachOptions.fromJson(
          json['attachOptions'] as Map<String, dynamic>),
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
      targetStartDate: json['targetStartDate'] == null
          ? null
          : DateTime.parse(json['targetStartDate'] as String),
      targetEndDate: json['targetEndDate'] == null
          ? null
          : DateTime.parse(json['targetEndDate'] as String),
      answerStatus: $enumDecodeNullable(
          _$DigitalDocumentAnswerStatusTypeEnumMap, json['answerStatus']),
      joinUserCount: (json['joinUserCount'] as num?)?.toInt(),
      shareholdingRatio: (json['shareholdingRatio'] as num?)?.toDouble(),
      title: json['title'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DigitalDocumentImplToJson(
        _$DigitalDocumentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'digitalDocumentType':
          _$DigitalDocumentTypeEnumMap[instance.documentType]!,
      'attachOptions': instance.attachOptions,
      'stock': instance.stock,
      'user': instance.user,
      'acceptUser': instance.acceptUser,
      'items': instance.itemGroups,
      'targetStartDate': instance.targetStartDate?.toIso8601String(),
      'targetEndDate': instance.targetEndDate?.toIso8601String(),
      'answerStatus':
          _$DigitalDocumentAnswerStatusTypeEnumMap[instance.answerStatus],
      'joinUserCount': instance.joinUserCount,
      'shareholdingRatio': instance.shareholdingRatio,
      'title': instance.title,
      'runtimeType': instance.$type,
    };

const _$DigitalDocumentTypeEnumMap = {
  DigitalDocumentType.digitalProxy: 'DIGITAL_PROXY',
  DigitalDocumentType.jointOwnership: 'JOINT_OWNERSHIP_DOCUMENT',
  DigitalDocumentType.etc: 'ETC_DOCUMENT',
  DigitalDocumentType.unknown: 'UNKNOWN',
};
