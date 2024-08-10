import 'package:act_cms/core/extension/exception_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_auth/change_password.dart';
import 'package:act_cms/domain/usecase/admin_cms/get_cms_commons.dart';
import 'package:act_cms/domain/usecase/admin_stock/fetch_user_me.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_password_change_event.dart';
part 'auth_password_change_state.dart';

class AuthPasswordChangeBloc extends Bloc<AuthPasswordChangeEvent, AuthPasswordChangeState> {
  final _changePassword = getIt<ChangePassword>();
  final _fetchUser = getIt<FetchUserMe>();
  final _cmsCommons = getIt<GetCMSCommons>();

  bool isValidPassword(String password) {
    if (password.isEmpty) {
      return false;
    }

    // 길이 체크
    if (password.length < 8 || password.length > 20) {
      return false;
    }

    // 조건별로 변수 설정
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // 3가지 이상의 조건을 충족하는지 확인
    int conditionsMet = 0;
    if (hasUppercase) conditionsMet++;
    if (hasLowercase) conditionsMet++;
    if (hasDigits) conditionsMet++;
    if (hasSpecialCharacters) conditionsMet++;

    return conditionsMet >= 4;
  }

  bool isEnableButton(String? currentPassword, String? newPassword, String? confirmPassword) {
    if (currentPassword != null && newPassword != null && confirmPassword != null) {
      if (isValidPassword(newPassword) && (newPassword == confirmPassword)) {
        return true;
      }
    }
    return false;
  }

  AuthPasswordChangeBloc() : super(AuthPasswordChangeState()) {
    on<AuthPasswordChangeOnSubmit>((event, emit) async {
      if (state.isLoading) return;

      emit(state.copyWith(isLoading: true));

      final result = await _changePassword(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
          confirmPassword: event.confirmPassword);

      final changedPasswordUser = result.tryGetSuccess();

      if (result.isSuccess() && changedPasswordUser != null) {
        await _fetchUser();
        await _cmsCommons();
        emit(state.copyWith(isLoading: false, isPasswrodChangeCompleted: true, user: changedPasswordUser));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: result.tryGetError()?.message,
        ));
      }
    });

    on<AuthPasswordChangeOnEditCurrentPassword>((event, emit) async {
      String? password;
      if (event.password.isEmpty) {
        password = '패스워드를 입력해 주세요';
      } else {
        password = "";
      }
      emit(state.copyWith(
          currentPassword: event.password,
          currentPasswordErrorText: password,
          isButtonEnabled: isEnableButton(event.password, state.newPassword, state.confirmPassword) ? true : false));
    });

    on<AuthPasswordChangeOnEditNewPassword>((event, emit) {
      String? password;
      if (event.password.isEmpty) {
        password = '패스워드를 입력해 주세요';
      } else if (!isValidPassword(event.password)) {
        // isValidPassword 는 직접 구현
        password = '*8~20자리의 영문 대소문자/숫자/특수문자 포함';
      } else {
        password = "";
      }
      emit(state.copyWith(
          newPassword: event.password,
          newPasswordErrorText: password,
          isButtonEnabled:
              isEnableButton(state.currentPassword, event.password, state.confirmPassword) ? true : false));
    });
    on<AuthPasswordChangeOnEditConfirmPassword>((event, emit) {
      String? password;
      if (event.password.isEmpty) {
        password = '패스워드를 입력해 주세요';
      } else if (event.password == state.newPassword) {
        password = "";
      } else {
        password = '패스워드가 일치하지 않습니다.';
      }
      emit(state.copyWith(
          confirmPassword: event.password,
          confirmPasswordErrorText: password,
          isButtonEnabled: isEnableButton(state.currentPassword, state.newPassword, event.password) ? true : false));
    });
  }
}
