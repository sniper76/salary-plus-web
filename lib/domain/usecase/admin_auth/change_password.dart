import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class ChangePassword {
  final AdminAuthRepository repository;

  const ChangePassword({required this.repository});

  Future<Result<User, Exception>> call(
      {required String currentPassword, required String newPassword, required String confirmPassword}) {
    return repository.changePassword(
        currentPassword: currentPassword, password: newPassword, confirmPassword: confirmPassword);
  }
}
