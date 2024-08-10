// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poll _$PollFromJson(Map<String, dynamic> json) => Poll(
      id: (json['id'] as num).toInt(),
      postId: (json['postId'] as num).toInt(),
      title: json['title'] as String,
      voteType: $enumDecode(_$PollVoteTypeEnumMap, json['voteType'],
          unknownValue: PollVoteType.unknown),
      selectionType: $enumDecode(
          _$PollSelectionTypeEnumMap, json['selectionOption'],
          unknownValue: PollSelectionType.unknown),
      status: json['status'] as String,
      content: json['content'] as String?,
      targetStartDate: json['targetStartDate'] == null
          ? null
          : DateTime.parse(json['targetStartDate'] as String),
      targetEndDate: json['targetEndDate'] == null
          ? null
          : DateTime.parse(json['targetEndDate'] as String),
      pollItems: (json['pollItems'] as List<dynamic>?)
              ?.map((e) => PollItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => PollAnswer.fromJson(e as Map<String, dynamic>))
          .toList(),
      voteTotalCount: (json['voteTotalCount'] as num?)?.toInt(),
      voteTotalStockSum: (json['voteTotalStockSum'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PollToJson(Poll instance) => <String, dynamic>{
      'title': instance.title,
      'voteType': _$PollVoteTypeEnumMap[instance.voteType]!,
      'selectionOption': _$PollSelectionTypeEnumMap[instance.selectionType]!,
      'targetStartDate': dateToJson(instance.targetStartDate),
      'targetEndDate': dateToJson(instance.targetEndDate),
      'pollItems': instance.pollItems,
      'content': instance.content,
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
