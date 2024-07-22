import 'package:act_web/domain/enum/poll_selection_type.dart';
import 'package:act_web/domain/enum/poll_vote_type.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/document/poll_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_register_result.freezed.dart';

@freezed
class PollRegisterResult with _$PollRegisterResult {
  const factory PollRegisterResult({
    required String title,
    required List<String> items,
    required DateTime startedAt,
    required DateTime endedAt,
    required PollSelectionType selectionType,
    required PollVoteType voteType,
    String? content,
    int? id,
  }) = _PollRegisterResult;

  const PollRegisterResult._();

  factory PollRegisterResult.fromModel(Poll poll) => PollRegisterResult(
        title: poll.title,
        content: poll.content,
        items: poll.pollItems.map((e) => e.text).toList(),
        startedAt: poll.targetStartDate ?? DateTime.now(),
        endedAt: poll.targetEndDate ?? DateTime.now(),
        voteType: poll.voteType,
        selectionType: poll.selectionType,
        id: poll.id,
      );
}

extension PollRegisterResultExtension on PollRegisterResult {
  Poll toPoll() {
    final pollItems = items.map((e) => PollItem(id: 0, text: e)).toList();
    return Poll(
      id: id ?? 0,
      postId: 0,
      title: title,
      voteType: voteType,
      selectionType: selectionType,
      status: '',
      targetStartDate: startedAt,
      targetEndDate: endedAt,
      content: content,
      pollItems: pollItems,
    );
  }
}
