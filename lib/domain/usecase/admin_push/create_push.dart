import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/domain/repository/admin_push_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreatePush {
  final AdminPushRepository repository;

  const CreatePush({required this.repository});

  Future<Result<GroupPush, Exception>> call(
      {required String content,
      required String title,
      String? stockCode,
      int? stockGroupId,
      required String stockTargetType,
      required String sendType,
      String? postId,
      required String linkType,
      DateTime? targetDatetime}) {
    return repository.create(
      title: title,
      content: content,
      stockCode: stockCode,
      stockGroupId: stockGroupId,
      stockTargetType: stockTargetType,
      sendType: sendType,
      postId: postId,
      linkType: linkType,
      targetDatetime: targetDatetime,
    );
  }
}
