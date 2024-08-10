import 'package:json_annotation/json_annotation.dart';

part 'poll_answer.g.dart';

@JsonSerializable()
class PollAnswer {
  final int id;
  final int pollItemId;

  const PollAnswer({
    required this.id,
    required this.pollItemId,
  });

  factory PollAnswer.fromJson(Map<String, dynamic> json) => _$PollAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$PollAnswerToJson(this);
}
