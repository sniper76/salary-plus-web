import 'package:act_cms/config/theme.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/auth/admin_login/bloc/auth_login_bloc.dart';
import 'package:act_cms/presentation/screen/auth/admin_password_change/auth_password_change_screen.dart';
import 'package:act_cms/presentation/widget/act_round_box.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

@RoutePage()
class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isDialogShowing = false;

  _onLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    final bloc = _scaffoldKey.currentContext?.read<AuthLoginBloc>();
    if (bloc == null) return;

    bloc.add(AuthLoginEvent.login(email, password));
  }

  _onChangePassword() {
    if (isDialogShowing) return;

    isDialogShowing = true;
    showDialog(
      context: context,
      builder: (context) {
        return const AuthPasswordChangeScreen();
      },
    ).then((_) => isDialogShowing = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<AuthLoginBloc, AuthLoginState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => AuthLoginBloc(),
      listener: (context, state) {
        if (state.isNewUser) {
          _onChangePassword();
        } else if (state.isLoggedIn && state.user != null) {
          context.router.replaceNamed(state.user!.getRouteAfterLogin);
        }
      },
      builder: (context, bloc, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppTheme.primaryColor[600],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogo(),
              _buildLoginForm(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: ActRoundBox(
        width: 400,
        margin: const EdgeInsets.all(40),
        padding: const EdgeInsets.all(40),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildIdTextField(),
              const SizedBox(height: 16),
              _buildPasswordTextField(),
              const SizedBox(height: 30),
              _buildLogInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return _buildTextField(
      label: '비밀번호',
      hintText: '비밀번호를 입력하세요',
      controller: _passwordController,
      autofillHints: const [AutofillHints.password],
      obscureText: true,
      onSubmitted: (value) {
        _onLogin();
      },
    );
  }

  Widget _buildIdTextField() {
    return _buildTextField(
      label: '아이디',
      hintText: '아이디를 입력하세요',
      controller: _emailController,
      autofillHints: const [AutofillHints.email, AutofillHints.username, AutofillHints.newUsername],
      obscureText: false,
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset('assets/images/img_cms_logo.png'),
    );
  }

  Widget _buildLogInButton() {
    return ElevatedButton(
      onPressed: _onLogin,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor[600],
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('로그인'),
    );
  }

  Widget _buildTextField({
    required String label,
    required List<String> autofillHints,
    required bool obscureText,
    String? hintText,
    TextEditingController? controller,
    Function(dynamic value)? onSubmitted,
  }) {
    return Row(
      children: [
        SizedBox(width: 70, child: Text(label)),
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            autofillHints: autofillHints,
            onSubmitted: (value) => onSubmitted?.call(value),
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText ?? "",
            ),
          ),
        ),
      ],
    );
  }
}
