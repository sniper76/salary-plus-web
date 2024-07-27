import 'package:salary_plus_web/config/constants.dart';
import 'package:salary_plus_web/core/extension/exception_extension.dart';
import 'package:salary_plus_web/data/response/data_response.dart';
import 'package:salary_plus_web/domain/enum/board_group_type.dart';
import 'package:salary_plus_web/domain/model/post/post.dart';
import 'package:salary_plus_web/domain/usecase/post/get_post_list_previews.dart';
import 'package:salary_plus_web/domain/usecase/auth/login.dart';
import 'package:salary_plus_web/presentation/base/base_state_mixin.dart';
import 'package:salary_plus_web/core/service/user_auth_service.dart';
import 'package:salary_plus_web/domain/model/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetPostListPreviews _getPostListPreviews = GetIt.I<GetPostListPreviews>();
  final Login _login = GetIt.I<Login>();
  final UserAuthService _authService = GetIt.I<UserAuthService>();

  LoginBloc() : super(LoginState.initial()) {
    on<_OnLogin>((event, emit) async {
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
        // await _cmsCommons();
        if (_authService.isAuthenticated()) {

          // emit(state.copyWith(onNavigateRouteName: user?.getRouteAfterLogin));
        }
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

    on<_OnInit>((event, emit) async {
      emit(state.copyWithNull(
        isLoading: true,
      ));

      Result<DataResponse<List<Post>>, Exception> postRes = await _getPostListPreviews(
        stockCode: AppConfig.globalBoardCode,
        boardGroupType: BoardGroupType.globalboard,
      );

      postRes.when(
        (DataResponse<List<Post>> postsData) {
          if (postsData.data?.isEmpty == true) {
            emit(state.copyWithNull(
              isLoading: false,
              errorToastMessage: '글이 없습니다.',
            ));

            return;
          } else {
            emit(state.copyWithNull(
              isLoading: false,
              globalBoardPosts: postsData.data!,
            ));
          }
        },
        (error) {
          emit(state.copyWithNull(
            isLoading: false,
            errorToastMessage: error.message,
          ));

          return;
        },
      );
    });
  }
}
