import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/icons/menu_icons.dart';
import 'package:act_cms/presentation/screen/cms_main/widget/main_screen.dart';
import 'package:act_cms/presentation/widget/act_side_menu_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import '../../widget/act_top_menu_bar.dart';

@RoutePage()
class CmsAcceptorMainScreen extends StatefulWidget {
  const CmsAcceptorMainScreen({super.key});

  @override
  State<CmsAcceptorMainScreen> createState() => _CmsAcceptorMainScreenState();
}

class _CmsAcceptorMainScreenState extends State<CmsAcceptorMainScreen> with SingleTickerProviderStateMixin {
  SideMenuController sideMenu = SideMenuController();

  final List<SideMenuRoute> route = [
    SideMenuRoute(
      title: '의결권 수임',
      icon: CustomMenuIcons.action,
      path: 'acceptorMain',
      route: const AcceptanceListRoute(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(route: route);
  }
}
