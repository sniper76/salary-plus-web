import 'package:act_web/domain/model/user/succeeded_web_verification.dart';
import 'package:act_web/domain/model/user/user.dart';
import 'package:act_web/domain/model/user/web_verification.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AuthRepository {
  Future<Result<WebVerification, Exception>> createWebVerification({
    required String authenticationReference,
  });

  Future<Result<SucceededWebVerification, Exception>> verifyWebVerification({
    required String authenticationReference,
    required String verificationCode,
  });

  Future<Result<User, Exception>> fetchUserMe();
}
