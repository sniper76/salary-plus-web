import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/users/corporation_user_detail/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_round_box.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/solidarity_leader_badge.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CorporationUserDetailScreen extends StatefulWidget {
  final CorporationUser corporationUser;
  final int userId;

  const CorporationUserDetailScreen({
    super.key,
    required this.corporationUser,
    @PathParam('userId') required this.userId,
  });

  static const defaultStyle = TextStyle(fontSize: 16);

  @override
  State<CorporationUserDetailScreen> createState() => _CorporationUserDetailScreenState();
}

class _CorporationUserDetailScreenState extends State<CorporationUserDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final textStyle = CorporationUserDetailScreen.defaultStyle.copyWith(fontWeight: FontWeight.w500);

  _onModifyCorporationUser(CorporationUser corporation) async {
    final res = await context.router.push(CorporationRegisterRoute(corporation: corporation));
    if (res == true) {
      _onRefresh();
    }
  }

  _onRefresh() {
    final bloc = _scaffoldKey.currentContext?.read<CorporationDetailBloc>();
    if (bloc == null) return;

    bloc.add(const CorporationDetailEvent.init());
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CorporationDetailBloc, CorporationDetailState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CorporationDetailBloc(widget.corporationUser)
        ..add(
          const CorporationDetailEvent.init(),
        ),
      listener: (context, state) {},
      backgroundColor: const Color(0xfff5f5f5),
      appBar: MainAppBar(mainTitle: '유저(법인) 상세', context: context),
      builder: (context, bloc, state) {
        return Padding(
          padding: const EdgeInsets.all(54),
          child: Column(
            children: [
              _buildUserInfo(state.corporationUser),
              const Spacer(),
              _buildActionButton(state.corporationUser),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(CorporationUser corporationUser) {
    return ActRoundBox(
      padding: const EdgeInsets.all(54),
      child: Wrap(
        spacing: 16,
        children: [
          _buildTextField(label: 'UID', valueBuilder: () => Text(corporationUser.userId.toString(), style: textStyle)),
          _buildTextField(
            label: '법인명',
            valueBuilder: () => _buildCorporationName(
              corporationUser.corporateName,
              corporationUser.leadingSolidarityStockCodes.isNotEmpty,
            ),
          ),
          _buildTextField(label: '법인등록번호', valueBuilder: () => Text(corporationUser.corporateNo, style: textStyle)),
        ],
      ),
    );
  }

  Widget _buildCorporationName(String corporateName, [bool isLeader = false]) {
    return Row(
      children: [
        Text(corporateName, style: textStyle),
        const SizedBox(width: 8),
        if (isLeader) const SolidarityLeaderBadge(),
      ],
    );
  }

  Widget _buildTextField({required String label, required Widget Function() valueBuilder}) {
    return Row(
      children: [
        Text("$label :", style: CorporationUserDetailScreen.defaultStyle.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        valueBuilder(),
      ],
    );
  }

  Widget _buildActionButton(CorporationUser corporation) {
    return Center(
        child: ElevatedButton(
      onPressed: () => _onModifyCorporationUser(corporation),
      child: const Text("수정"),
    ));
  }
}
