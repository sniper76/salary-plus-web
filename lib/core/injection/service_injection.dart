import 'package:act_web/core/service/user_auth_service.dart';
import 'package:get_it/get_it.dart';

class ServiceInjection {
  static inject() async {
    final UserAuthService userAuthService = UserAuthService();
    await userAuthService.init();

    GetIt.I.registerSingleton<UserAuthService>(userAuthService);
  }
}
