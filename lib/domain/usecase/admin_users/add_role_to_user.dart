import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AddRoleToUser {
  final AdminUserRepository repository;

  const AddRoleToUser({required this.repository});

  Future<Result<User, Exception>> call({required int userId, required String roleType}) {
    {
      return repository.addRole(
        userId: userId,
        roleType: roleType,
      );
    }
  }
}
