import 'package:act_web/domain/model/user/web_verification.dart';
import 'package:act_web/domain/repository/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateWebVerification {
  final AuthRepository repository;
  const CreateWebVerification({required this.repository});

  Future<Result<WebVerification, Exception>> call({required String authenticationReference}) {
    return repository.createWebVerification(authenticationReference: authenticationReference);
  }
}
