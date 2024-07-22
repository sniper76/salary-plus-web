import 'dart:async';

import 'package:act_web/core/extension/exception_extension.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/core/util/dynamic_link_utils.dart';
import 'package:act_web/domain/enum/web_verification_status.dart';
import 'package:act_web/domain/model/user/succeeded_web_verification.dart';
import 'package:act_web/domain/model/user/token.dart';
import 'package:act_web/domain/model/user/web_verification.dart';
import 'package:act_web/domain/usecase/auth/create_web_verification.dart';
import 'package:act_web/domain/usecase/auth/verify_web_verification.dart';
import 'package:act_web/presentation/base/base_state_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';
part 'bloc.freezed.dart';

class ActLoginBloc extends Bloc<ActLoginEvent, ActLoginState> {
  Timer? _timer;

  ActLoginBloc() : super(ActLoginState.initial()) {
    // service
    final UserAuthService authService = GetIt.I<UserAuthService>();
    // usecase
    final CreateWebVerification createWebVerification = GetIt.I<CreateWebVerification>();
    final VerifyWebVerification verifyWebVerification = GetIt.I<VerifyWebVerification>();

    on<_OnInit>((event, emit) async {
      _startTimer(emit);

      emit(state.copyWithNull(
        isLoading: true,
        seconds: 0,
      ));

      final Result<WebVerification, Exception> result = await createWebVerification.call(
        authenticationReference: authService.userUuid,
      );

      result.when(
        (WebVerification receivedWebVerification) async {
          final String path = '/mypage?receivedWebVerificationCode%3D${receivedWebVerification.verificationCode}';

          emit(state.copyWithNull(
            isLoading: false,
            webVerification: receivedWebVerification,
            loginDynamicLink: DynamicLinkUtils.getDynamicLink(path),
          ));
          add(const _OnPollingWebVerification());
        },
        (Exception exception) {
          emit(state.copyWithNull(isLoading: false, errorToastMessage: exception.message));
        },
      );
    });

    on<_OnTick>((event, emit) {
      emit(state.copyWithNull(seconds: state.seconds + 1));
    });

    on<_OnPollingWebVerification>((event, emit) async {
      if (state.isLoading || state.isPolling || state.webVerification?.verificationCode.isEmpty == true) return;

      emit(state.copyWithNull(isPolling: true));
      final Result<SucceededWebVerification, Exception> result = await verifyWebVerification.call(
        authenticationReference: authService.userUuid,
        verificationCode: state.webVerification!.verificationCode,
      );

      result.when(
        (SucceededWebVerification succeededWebVerification) {
          switch (succeededWebVerification.status) {
            case WebVerificationStatus.waiting:
              emit(state.copyWithNull(
                isPolling: false,
              ));
              add(const _OnPollingWebVerification());
              break;
            case WebVerificationStatus.verified:
              _timer?.cancel();
              if (succeededWebVerification.token != null && succeededWebVerification.user != null) {
                authService.login(
                  token: Token(accessToken: succeededWebVerification.token!),
                  user: succeededWebVerification.user!,
                );
              }
              emit(state.copyWithNull(
                isLoginSuccess: true,
                isPolling: false,
              ));
              break;
            case WebVerificationStatus.expired:
              emit(ActLoginState.initial());
              add(const _OnInit());
              break;
            default:
          }
        },
        (Exception exception) {
          if (exception is DioException) {
            switch (exception.type) {
              case DioExceptionType.connectionTimeout:
              case DioExceptionType.sendTimeout:
              case DioExceptionType.receiveTimeout:
                emit(state.copyWithNull(isPolling: false));
                break;
              default:
                emit(state.copyWithNull(isPolling: false, errorToastMessage: exception.message));
            }
          } else {
            emit(state.copyWithNull(isPolling: false, errorToastMessage: exception.message));
          }
        },
      );
    });
  }

  void _startTimer(Emitter<ActLoginState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const _OnTick());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
