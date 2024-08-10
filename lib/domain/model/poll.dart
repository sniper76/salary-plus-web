import 'package:act_cms/core/util/json_utils.dart';
import 'package:act_cms/domain/model/enum/poll_selection_type.dart';
import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/domain/model/poll_answer.dart';
import 'package:act_cms/domain/model/poll_item.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'poll.g.dart';

@JsonSerializable()
class Poll {
  @JsonKey(includeToJson: false)
  final int id;
  @JsonKey(includeToJson: false)
  final int postId;
  final String title;
  @JsonKey(unknownEnumValue: PollVoteType.unknown)
  final PollVoteType voteType;
  @JsonKey(name: 'selectionOption', unknownEnumValue: PollSelectionType.unknown)
  final PollSelectionType selectionType;
  @JsonKey(includeToJson: false)
  final String status;
  @JsonKey(toJson: dateToJson)
  final DateTime? targetStartDate;
  @JsonKey(toJson: dateToJson)
  final DateTime? targetEndDate;
  final List<PollItem> pollItems;
  @JsonKey(includeToJson: false)
  final List<PollAnswer>? answers;
  @JsonKey(includeToJson: false)
  final int? voteTotalCount;
  @JsonKey(includeToJson: false)
  final int? voteTotalStockSum;
  final String? content;

  const Poll({
    required this.id,
    required this.postId,
    required this.title,
    required this.voteType,
    required this.selectionType,
    required this.status,
    this.content,
    this.targetStartDate,
    this.targetEndDate,
    this.pollItems = const [],
    this.answers,
    this.voteTotalCount,
    this.voteTotalStockSum,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);

  Map<String, dynamic> toJson() => _$PollToJson(this);
}

extension PollExtension on Poll {
  bool get isReady => targetStartDate != null && targetStartDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isActive =>
      targetStartDate?.toUtc().isBefore(DateTime.now()) == true &&
      targetEndDate?.toUtc().isAfter(DateTime.now()) == true;

  bool get isEnded => targetEndDate?.toUtc().isBefore(DateTime.now()) == true;

  int get remainingDay {
    return targetEndDate?.toUtc().difference(DateTime.now()).inDays ?? -1;
  }

  String get statusLabel {
    if (isReady) {
      return '대기';
    } else if (isActive) {
      return '진행중';
    } else if (isEnded) {
      return '종료';
    } else {
      return '';
    }
  }

  Color? get statusLabelColor {
    if (isReady) {
      return const Color(0xff0E9F33);
    } else if (isActive) {
      return const Color(0xff355CE9);
    } else if (isEnded) {
      return const Color(0xffFF0000);
    } else {
      return null;
    }
  }
}
