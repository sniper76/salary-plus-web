import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class WithdrawService {
  final AdminUserRepository repository;

  const WithdrawService({required this.repository});

  Future<Result<void, Exception>> call({
    required String finpongAccessToken,
  }) {
    return repository.withdraw(
      finpongAccessToken: finpongAccessToken,
    );
  }
}
