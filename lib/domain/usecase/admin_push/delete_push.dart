import 'package:act_cms/domain/repository/admin_push_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeletePush {
  final AdminPushRepository repository;

  const DeletePush({required this.repository});

  Future<Result<void, Exception>> call({
    required int pushId,
  }) {
    return repository.delete(
      pushId: pushId,
    );
  }
}
