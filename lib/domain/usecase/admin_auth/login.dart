import 'package:act_cms/domain/model/verify_auth.dart';
import 'package:act_cms/domain/repository/admin_auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class Login {
  final AdminAuthRepository repository;

  const Login({required this.repository});

  Future<Result<VerifyAuth, Exception>> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
