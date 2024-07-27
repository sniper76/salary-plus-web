import 'package:salary_plus_web/domain/model/user/succeeded_web_verification.dart';
import 'package:salary_plus_web/domain/model/user/user.dart';
import 'package:salary_plus_web/domain/model/user/web_verification.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:salary_plus_web/domain/model/verify_auth.dart';

abstract class AuthRepository {
  Future<Result<VerifyAuth, Exception>> login({
    required String email, required String password
  });

  Future<Result<WebVerification, Exception>> createWebVerification({
    required String authenticationReference,
  });

  Future<Result<SucceededWebVerification, Exception>> verifyWebVerification({
    required String authenticationReference,
    required String verificationCode,
  });

  Future<Result<User, Exception>> fetchUserMe();
}
