import 'package:salary_plus_web/domain/model/verify_auth.dart';
import 'package:salary_plus_web/domain/repository/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class Login {
  final AuthRepository repository;

  const Login({required this.repository});

  Future<Result<VerifyAuth, Exception>> call({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}
