import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/users/corporation_register/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/act_round_box.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

@RoutePage()
class CorporationRegisterScreen extends StatefulWidget {
  final CorporationUser? corporation;

  const CorporationRegisterScreen({super.key, this.corporation});

  @override
  State<CorporationRegisterScreen> createState() => _CorporationRegisterScreenState();
}

class _CorporationRegisterScreenState extends State<CorporationRegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _corporationController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool get isModify => widget.corporation != null;

  String get getCommandTitle => isModify ? '수정' : '등록';

  void _onRegisterCorporation() {
    final bloc = _scaffoldKey.currentContext?.read<CorporationRegisterBloc>();
    if (bloc == null) return;

    if (_formKey.currentState?.validate() == true) {
      bloc.add(CorporationRegisterEvent.onRegisterCorporation(
          corporationName: _corporationController.text, registerNumber: _registrationNumberController.text));
    }
  }

  void _onUpdateCorporationDialog() async {
    final res = await context.showConfirmDialog(title: '법인 수정', message: '정말 수정하시겠습니까?');

    if (res == true) {
      _onUpdateCorporation();
    }
  }

  void _onUpdateCorporation() {
    if (widget.corporation == null) return;

    final bloc = _scaffoldKey.currentContext?.read<CorporationRegisterBloc>();
    if (bloc == null) return;

    if (_formKey.currentState?.validate() == true) {
      bloc.add(CorporationRegisterEvent.onUpdateCorporationUser(
        corporateName: _corporationController.text,
        corporateNo: _registrationNumberController.text,
        corporateId: widget.corporation!.id,
      ));
    }
  }

  onComplete() async {
    final result =
        await context.showAlertDialog(title: "법인 $getCommandTitle", message: "법인 유저 $getCommandTitle이 완료되었습니다.");
    if (result) {
      if (!context.mounted) return;
      context.router.pop(true);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.corporation != null) {
      _corporationController.text = widget.corporation!.corporateName;
      _registrationNumberController.text = widget.corporation!.corporateNo;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _corporationController.dispose();
    _registrationNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CorporationRegisterBloc, CorporationRegisterState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CorporationRegisterBloc(),
      appBar: MainAppBar(mainTitle: '유저(법인) $getCommandTitle', context: context),
      backgroundColor: const Color(0xfff5f5f5),
      listener: (context, state) {
        if (state.isComplete) {
          onComplete();
        }
      },
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return Form(
          key: _formKey,
          child: ActRoundBox(
            child: Column(
              children: [
                ActFieldContainer(
                  title: '법인명',
                  width: 120,
                  children: [_buildTextField(controller: _corporationController)],
                ),
                const SizedBox(height: 20),
                ActFieldContainer(
                  title: '법인등록번호',
                  width: 120,
                  children: [
                    _buildTextField(
                      controller: _registrationNumberController,
                    )
                  ],
                ),
                const Spacer(),
                _buildActionButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton() {
    if (isModify) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) => AppTheme.defaultColorScheme.error)),
            onPressed: () => context.router.pop(),
            child: const Text("취소"),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: _onUpdateCorporationDialog,
            child: const Text("수정"),
          )
        ],
      );
    } else {
      return ElevatedButton(
        onPressed: _onRegisterCorporation,
        child: const Text("등록"),
      );
    }
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      String? hintText,
      List<TextInputFormatter>? formatter,
      String? Function(String value)? validation}) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '필수 정보입니다';
          }
          if (validation != null) {
            return validation(value);
          }

          return null;
        },
        inputFormatters: formatter,
      ),
    );
  }
}
