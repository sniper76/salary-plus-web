import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:auto_route/auto_route.dart';

class PinNumberGuard extends AutoRedirectGuard {
  final _authService = getIt<UserAuthService>();

  PinNumberGuard() {
    _authService.addListener(() {
      if (!_authService.isPinNumberRegistered() || !_authService.isPinNumberVerification()) {
        reevaluate();
      }
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isPinNumberRegistered = _authService.isPinNumberRegistered();
    final isPinNumberVerification = _authService.isPinNumberVerification();
    if (isPinNumberRegistered && isPinNumberVerification) {
      resolver.next(true);
    } else {
      final pushPath = !isPinNumberRegistered ? '/auth/pinNumber/register' : '/auth/pinNumber/verify';
      final isResult = (await router.pushNamed<bool>(pushPath)) ?? false;
      resolver.next(isResult);
    }
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async {
    return _authService.isPinNumberRegistered() && _authService.isPinNumberVerification();
  }
}
