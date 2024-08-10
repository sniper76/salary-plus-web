// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poll_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PollAnswer _$PollAnswerFromJson(Map<String, dynamic> json) => PollAnswer(
      id: (json['id'] as num).toInt(),
      pollItemId: (json['pollItemId'] as num).toInt(),
    );

Map<String, dynamic> _$PollAnswerToJson(PollAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pollItemId': instance.pollItemId,
    };
