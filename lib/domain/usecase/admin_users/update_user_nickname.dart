import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateUserNickName {
  final AdminUserRepository repository;

  const UpdateUserNickName({required this.repository});

  Future<Result<User, Exception>> call({required int userId, required String nickname}) {
    {
      return repository.updateUserNickname(userId: userId, nickname: nickname);
    }
  }
}
