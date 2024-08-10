import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/auth/admin_password_change/bloc/auth_password_change_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AuthPasswordChangeScreen extends StatefulWidget {
  const AuthPasswordChangeScreen({super.key});

  @override
  State<AuthPasswordChangeScreen> createState() => _AuthPasswordChangeScreenState();
}

class _AuthPasswordChangeScreenState extends State<AuthPasswordChangeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  _onChangePassword() {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    final bloc = _scaffoldKey.currentContext?.read<AuthPasswordChangeBloc>();
    if (bloc == null) return;

    bloc.add(AuthPasswordChangeEvent.submit(currentPassword, newPassword, confirmPassword));
  }

  _checkCurrentPassword() {
    final bloc = _scaffoldKey.currentContext?.read<AuthPasswordChangeBloc>();
    if (bloc == null) return;

    bloc.add(AuthPasswordChangeEvent.currentPassword(_currentPasswordController.text));
  }

  _checkNewPassword() {
    final bloc = _scaffoldKey.currentContext?.read<AuthPasswordChangeBloc>();
    if (bloc == null) return;

    bloc.add(AuthPasswordChangeEvent.newPassword(_newPasswordController.text));
  }

  _checkConfirmPassword() {
    final bloc = _scaffoldKey.currentContext?.read<AuthPasswordChangeBloc>();
    if (bloc == null) return;

    bloc.add(AuthPasswordChangeEvent.confirmPassword(_confirmPasswordController.text));
  }

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_checkCurrentPassword);
    _newPasswordController.addListener(_checkNewPassword);
    _confirmPasswordController.addListener(_checkConfirmPassword);
  }

  @override
  void dispose() {
    _currentPasswordController.removeListener(_checkCurrentPassword);
    _newPasswordController.removeListener(_checkNewPassword);
    _confirmPasswordController.removeListener(_checkConfirmPassword);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<AuthPasswordChangeBloc, AuthPasswordChangeState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => AuthPasswordChangeBloc(),
      listener: (context, state) {
        if (state.isPasswrodChangeCompleted && state.user != null) {
          context.router.replaceNamed(state.user!.getRouteAfterLogin);
        }
      },
      backgroundColor: Colors.transparent,
      builder: (context, bloc, state) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
          contentPadding: const EdgeInsets.all(30.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('비밀번호 변경'),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.router.pop(),
              )
            ],
          ),
          content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 150, child: Text('기존 비밀번호')),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              obscureText: true,
                              controller: _currentPasswordController,
                              decoration: const InputDecoration(
                                hintText: '비밀번호를 입력하세요.',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Text(state.currentPasswordErrorText ?? "",
                                style: const TextStyle(fontSize: 12, color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 150, child: Text('신규 비밀번호')),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextField(
                              obscureText: true,
                              controller: _newPasswordController,
                              decoration: const InputDecoration(
                                hintText: '비밀번호를 입력하세요.',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Text(state.newPasswordErrorText ?? '',
                                style: const TextStyle(fontSize: 12, color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const SizedBox(width: 150, child: Text('신규 비밀번호 확인')),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                          TextField(
                              obscureText: true,
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(
                                hintText: '비밀번호를 재입력하세요.',
                                border: OutlineInputBorder(),
                              )),
                          Text(state.confirmPasswordErrorText ?? '',
                              style: const TextStyle(fontSize: 12, color: Colors.red)),
                        ]),
                      ),
                    ],
                  ),
                ],
              )),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: state.isButtonEnabled ? const Color(0xFF2A4ABA) : Colors.grey,
                  minimumSize: const Size(double.infinity, 50), // Full width
                  padding: const EdgeInsets.symmetric(horizontal: 20)),
              onPressed: state.isButtonEnabled ? _onChangePassword : null,
              child: const Text('변경'),
            ),
          ],
        );
      },
    );
  }
}
