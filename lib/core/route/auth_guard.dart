import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRedirectGuard {
  final _authService = getIt<UserAuthService>();

  AuthGuard() {
    _authService.addListener(() {
      if (!_authService.isAuthenticated() || !_authService.isUserStatusActivated()) {
        reevaluate();
      }
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _authService.isAuthenticated();
    if (isAuthenticated && _authService.isUserStatusActivated()) {
      resolver.next(true);
    } else {
      router.replaceNamed('/splash');
    }
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async {
    return _authService.isAuthenticated() && _authService.isUserStatusActivated();
  }
}
