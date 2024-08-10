import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/usecase/admin_cms/get_cms_commons.dart';
import 'package:act_cms/domain/usecase/admin_stock/fetch_user_me.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final _authService = getIt<UserAuthService>();
  final _fetchUser = getIt<FetchUserMe>();
  final _cmsCommons = getIt<GetCMSCommons>();

  SplashBloc() : super(const SplashState()) {
    on<SplashOnInitial>((event, emit) async {
      // 사용자 정보 갱신
      await _authService.init();
      await _fetchUser();
      emit(state.copyWith(isCompleted: true));

      if (_authService.isAuthenticated()) {
        final user = _authService.userMe;
        await _cmsCommons();
        emit(state.copyWith(onNavigateRouteName: user?.getRouteAfterLogin));
      } else {
        emit(state.copyWith(onNavigateRouteName: '/login'));
      }
    });
  }
}
