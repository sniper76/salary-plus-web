import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/model/user/user.dart';
import 'package:act_web/domain/repository/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class FetchUserMe {
  final UserAuthService authService;
  final AuthRepository repository;
  const FetchUserMe({required this.authService, required this.repository});

  Future<Result<User, Exception>> call() async {
    if (authService.hasAccessToken()) {
      final result = await repository.fetchUserMe();
      if (result.isSuccess() && result.tryGetSuccess() != null) {
        authService.updateUser(result.tryGetSuccess()!);
      }
      return result;
    } else {
      return Result.error(Exception('not authenticated'));
    }
  }
}
