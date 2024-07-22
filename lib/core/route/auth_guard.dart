import 'package:act_web/config/constants.dart';
import 'package:act_web/core/route/app_router.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

class AuthGuard extends AutoRouteGuard {
  final UserAuthService _authService = GetIt.I<UserAuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final bool allowedUserCondition = _authService.hasAccessToken();
    final bool extraAllowedCondition = resolver.route.pathParams.rawMap['stockCode'] == AppConfig.globalBoardCode;

    if (allowedUserCondition || extraAllowedCondition) {
      resolver.next(true);
    } else {
      if (router.current.name != HomeRoute.name) resolver.redirect(const HomeRoute());
      if (_authService.needLoginPopup != true) _authService.setNeedLoginFlag(true);
    }
  }
}
