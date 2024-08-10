import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/verify_auth.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminAuthRepository {
  Future<Result<VerifyAuth, Exception>> login({required String email, required String password});

  Future<Result<User, Exception>> changePassword(
      {required String currentPassword, required String password, required String confirmPassword});
}
