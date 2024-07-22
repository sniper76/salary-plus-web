import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AnswerOnPostPoll {
  final PostRepository repository;
  const AnswerOnPostPoll({required this.repository});

  Future<Result<void, Exception>> call({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int pollId,
    required List<int> pollAnswerIds,
    bool isUpdate = false,
  }) {
    return repository.answerOnPostPoll(
      stockCode: stockCode,
      boardGroupType: boardGroupType,
      postId: postId,
      pollId: pollId,
      pollItemIds: pollAnswerIds,
      isUpdate: isUpdate,
    );
  }
}
