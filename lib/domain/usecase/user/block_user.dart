import 'package:act_web/domain/repository/user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class BlockUser {
  final UserRepository repository;

  const BlockUser({required this.repository});

  Future<Result<void, Exception>> call({required int targetUserId}) {
    return repository.blockUser(targetUserId: targetUserId);
  }
}
