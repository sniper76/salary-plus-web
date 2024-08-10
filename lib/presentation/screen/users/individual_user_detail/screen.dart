import 'dart:async';
import 'dart:html' as html;
import 'dart:math';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/core/util/format_utils.dart';
import 'package:act_cms/domain/model/badge_visibility.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/users/individual_user_detail/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_admin_badge.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/act_switch.dart';
import 'package:act_cms/presentation/widget/button/act_delete_button.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/solidarity_leader_badge.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:number_paginator/number_paginator.dart';

part 'handler.dart';
part 'widget/sections.dart';
part 'widget/stock_container.dart';
part 'widget/user_info_list_widget.dart';
part 'widget/user_term_list_widget.dart';
part 'widget/user_badge_list_widget.dart';

@RoutePage()
class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({
    super.key,
    @pathParam required this.userId,
  });

  @override
  State<UserDetailScreen> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetailScreen> {
  late NumberPaginatorController _numberPaginatorController;
  StreamSubscription<html.PopStateEvent>? _popStateSubscription;

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton(UserDetailBloc(widget.userId));
    _numberPaginatorController = NumberPaginatorController();
    _registerPopStateListener();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<UserDetailBloc, UserDetailState>(
      listener: (context, state) {
        if (state.confidentialDownloadLink != null && state.confidentialDownloadLink!.isNotEmpty) {
          html.AnchorElement(href: state.confidentialDownloadLink)
            ..setAttribute("download", '비밀유지서약서(${state.userData?.name ?? ''}).pdf')
            ..click();
          html.Url.revokeObjectUrl(state.confidentialDownloadLink!);
        }
      },
      backgroundColor: const Color(0xfff5f5f5),
      create: (context) => GetIt.I<UserDetailBloc>()..add(const UserDetailEvent.init()),
      appBar: MainAppBar(
        titleWidget: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (BuildContext context, UserDetailState state) {
            return Text(
              "유저 (${state.userData?.nickname ?? ""})",
              style: const TextStyle(fontSize: cmsTitleFontSize, fontWeight: FontWeight.w900),
            );
          },
        ),
        context: context,
        isRefresh: true,
      ),
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                _UserProfileSection(bloc: bloc),
                if (state.userData?.isAdmin == true) ...[
                  const SizedBox(height: 30),
                  _DummyStocksSection(bloc: bloc),
                ],
                const SizedBox(height: 30),
                _UserStockSection(bloc: bloc),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _numberPaginatorController.dispose();
    _popStateSubscription?.cancel();
    GetIt.I.unregister<UserDetailBloc>();
    super.dispose();
  }
}
