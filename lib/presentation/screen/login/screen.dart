import 'package:salary_plus_web/config/constants.dart';
import 'package:salary_plus_web/config/theme.dart';
import 'package:salary_plus_web/domain/enum/board_group_type.dart';
import 'package:salary_plus_web/presentation/base/base_bloc_layout.dart';
import 'package:salary_plus_web/presentation/screen/login/bloc/bloc.dart';
import 'package:salary_plus_web/presentation/widget/act_download_widget/widget.dart';
import 'package:salary_plus_web/presentation/widget/act_footer_widget.dart';
import 'package:salary_plus_web/presentation/widget/act_ranking_widget/widget.dart';
import 'package:salary_plus_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:salary_plus_web/presentation/widget/simple_post_list_widget.dart';
import 'package:salary_plus_web/presentation/widget/act_round_box.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  _onLogin() {
    context.router.replaceNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<LoginBloc, LoginState>(
      backgroundColor: Colors.white,
      create: (_) => LoginBloc()..add(const LoginEvent.init()),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
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
                        _buildTextField(
                          label: AppLocalizations.of(context)!.form_id,
                          hintText: AppLocalizations.of(context)!.form_id_hintText,
                          controller: _emailController,
                          autofillHints: const [AutofillHints.email, AutofillHints.username, AutofillHints.newUsername],
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                        _buildTextField(
                          label: AppLocalizations.of(context)!.form_pwd,
                          hintText: AppLocalizations.of(context)!.form_pwd_hintText,
                          controller: _passwordController,
                          autofillHints: const [AutofillHints.password],
                          obscureText: true,
                          onSubmitted: (value) {
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            bloc.add(LoginEvent.login(email, password));
                            _onLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor[600],
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(AppLocalizations.of(context)!.login),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginBloc bloc, LoginState state) {
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
              _buildPasswordTextField(context, bloc, state),
              const SizedBox(height: 30),
              _buildLogInButton(context, bloc, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context, LoginBloc bloc, LoginState state) {
    return _buildTextField(
      label: AppLocalizations.of(context)!.form_pwd,
      hintText: AppLocalizations.of(context)!.form_pwd_hintText,
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
      label: AppLocalizations.of(context)!.form_id,
      hintText: AppLocalizations.of(context)!.form_id_hintText,
      controller: _emailController,
      autofillHints: const [AutofillHints.email, AutofillHints.username, AutofillHints.newUsername],
      obscureText: false,
    );
  }

  Widget _buildLogInButton(BuildContext context, LoginBloc bloc, LoginState state) {
    return ElevatedButton(
      onPressed: _onLogin(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor[600],
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(AppLocalizations.of(context)!.login),
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
