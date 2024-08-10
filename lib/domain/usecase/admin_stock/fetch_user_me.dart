import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FetchUserMe {
  final UserAuthService authService;
  final AdminUserRepository repository;

  const FetchUserMe({required this.authService, required this.repository});

  Future<Result<User, Exception>> call() async {
    if (authService.hasAccessToken()) {
      final result = await repository.userMe();
      if (result.isSuccess() && result.tryGetSuccess() != null) {
        authService.updateUser(result.tryGetSuccess()!);
      }
      return result;
    } else {
      return Result.error(Exception('not authenticated'));
    }
  }
}
