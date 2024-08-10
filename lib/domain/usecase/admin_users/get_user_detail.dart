import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetUserDetail {
  final AdminUserRepository repository;

  const GetUserDetail({required this.repository});

  Future<Result<User, Exception>> call({required int userId}) {
    {
      return repository.getDetail(userId);
    }
  }
}
