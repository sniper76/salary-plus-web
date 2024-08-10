import 'package:act_cms/domain/model/enum/poll_selection_type.dart';
import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/poll_item.dart';

class PollRegisterResult {
  final String title;
  final String? content;
  final List<String> pollItems;
  final DateTime startedAt;
  final DateTime? endedAt;
  final PollSelectionType selectionType;
  final PollVoteType voteType;

  const PollRegisterResult({
    required this.title,
    this.content,
    this.pollItems = const [],
    required this.startedAt,
    this.endedAt,
    this.selectionType = PollSelectionType.single,
    this.voteType = PollVoteType.person,
  });

  PollRegisterResult copyWith({
    DateTime? startedAt,
    DateTime? endedAt,
    String? title,
    String? content,
    List<String>? pollItems,
    PollSelectionType? selectionType,
    PollVoteType? voteType,
  }) {
    return PollRegisterResult(
      title: title ?? this.title,
      content: content ?? this.content,
      pollItems: pollItems ?? this.pollItems,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      selectionType: selectionType ?? this.selectionType,
      voteType: voteType ?? this.voteType,
    );
  }

  Poll toPoll() {
    return Poll(
      id: 0,
      postId: 0,
      title: title,
      content: content,
      voteType: voteType,
      selectionType: selectionType,
      status: '',
      targetStartDate: startedAt,
      targetEndDate: endedAt,
      pollItems: pollItems.map((e) => PollItem(id: 0, text: e)).toList(),
    );
  }

  factory PollRegisterResult.fromModel(Poll poll) => PollRegisterResult(
        title: poll.title,
        content: poll.content,
        pollItems: poll.pollItems.map((e) => e.text).toList(),
        startedAt: poll.targetStartDate ?? DateTime.now(),
        endedAt: poll.targetEndDate ?? DateTime.now(),
        voteType: poll.voteType,
        selectionType: poll.selectionType,
      );
}
