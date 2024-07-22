import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_answer.freezed.dart';
part 'poll_answer.g.dart';

@freezed
class PollAnswer with _$PollAnswer {
  const factory PollAnswer({
    required int id,
    required int pollItemId,
  }) = _PollAnswer;

  factory PollAnswer.fromJson(Map<String, dynamic> json) => _$PollAnswerFromJson(json);
}
