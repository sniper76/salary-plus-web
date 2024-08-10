import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class RevokeAdminUser {
  final AdminUserRepository repository;

  const RevokeAdminUser({required this.repository});

  Future<Result<User, Exception>> call({required int userId}) {
    {
      return repository.assignRevokeAdminUser(userId: userId);
    }
  }
}
