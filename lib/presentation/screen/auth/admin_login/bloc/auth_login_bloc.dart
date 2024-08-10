import 'package:act_cms/core/extension/exception_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/user_auth_service.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_auth/change_password.dart';
import 'package:act_cms/domain/usecase/admin_auth/login.dart';
import 'package:act_cms/domain/usecase/admin_cms/get_cms_commons.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_login_event.dart';
part 'auth_login_state.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final _login = getIt<Login>();
  final _changePassword = getIt<ChangePassword>();
  final _authService = getIt<UserAuthService>();
  final _cmsCommons = getIt<GetCMSCommons>();

  AuthLoginBloc() : super(const AuthLoginState()) {
    on<AuthLoginEventOnLogin>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final result = await _login(email: event.email, password: event.password);

      if (result.isSuccess()) {
        final res = result.tryGetSuccess();
        final token = res?.token;
        final user = res?.user;

        if (token == null || token.accessToken.isEmpty == true || user == null) {
          emit(state.copyWith(
            isLoading: false,
            errorToastMessage: '인증이 실패 하였습니다',
          ));
          return;
        }

        final isLoggedIn = await _authService.login(
          token: token,
          user: user,
        );
        // await _fetchUser();
        await _cmsCommons();
        emit(state.copyWith(
          isLoading: false,
          isLoggedIn: isLoggedIn,
          isNewUser: user.isChangePasswordRequired ?? true,
          user: user,
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: result.tryGetError()?.message, isNewUser: false));
      }
    });

    on<AuthLoginEventOnConfirm>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final result = await _changePassword(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword);

      if (result.isSuccess() && result.tryGetSuccess() != null) {
        _authService.updateUser(result.tryGetSuccess()!);
        emit(state.copyWith(isLoading: false, isLoggedIn: false));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: result.tryGetError()?.message,
        ));
      }
    });
  }
}
