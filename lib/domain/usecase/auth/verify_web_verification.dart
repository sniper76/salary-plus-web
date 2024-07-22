import 'package:act_web/domain/model/user/succeeded_web_verification.dart';
import 'package:act_web/domain/repository/auth_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class VerifyWebVerification {
  final AuthRepository repository;
  const VerifyWebVerification({required this.repository});

  Future<Result<SucceededWebVerification, Exception>> call({
    required String authenticationReference,
    required String verificationCode,
  }) {
    return repository.verifyWebVerification(
      authenticationReference: authenticationReference,
      verificationCode: verificationCode,
    );
  }
}
