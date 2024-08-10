import 'dart:html';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/icons/menu_icons.dart';
import 'package:act_cms/presentation/screen/cms_main/widget/main_screen.dart';
import 'package:act_cms/presentation/widget/act_side_menu_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

import 'package:act_cms/presentation/widget/act_top_menu_bar.dart';

@RoutePage()
class CmsAdminMainScreen extends StatefulWidget {
  const CmsAdminMainScreen({super.key});

  @override
  State<CmsAdminMainScreen> createState() => _CmsAdminMainScreenState();
}

class _CmsAdminMainScreenState extends State<CmsAdminMainScreen> with SingleTickerProviderStateMixin {
  SideMenuController sideMenu = SideMenuController();

  final List<SideMenuRoute> adminRoute = [
    SideMenuRoute(
      title: '대쉬보드',
      icon: CustomMenuIcons.dashboard,
      path: 'main',
      route: const DashboardRoute(),
    ),
    SideMenuRoute(
      title: '유저',
      icon: CustomMenuIcons.user,
      subItems: [
        SideMenuRoute(title: '개인', path: 'userList', route: const UsersRoute()),
        SideMenuRoute(title: '법인', path: 'corporationList', route: const CorporationRoute()),
      ],
    ),
    SideMenuRoute(
      title: '종목',
      icon: CustomMenuIcons.barchart,
      subItems: [
        SideMenuRoute(title: '개별', path: 'stock', route: const CmsStockRoute()),
        SideMenuRoute(title: '그룹', path: 'stockGroup', route: const CmsStockGroupRoute()),
      ],
    ),
    SideMenuRoute(
      title: '게시판',
      icon: CustomMenuIcons.notice,
      subItems: [
        SideMenuRoute(title: '뉴스', path: 'postNews', route: const PostNewsRoute()),
        SideMenuRoute(title: '종목', path: 'postStock', route: const PostStockRoute()),
      ],
    ),
    SideMenuRoute(
      title: '액션',
      icon: CustomMenuIcons.action,
      path: 'action',
      route: const ActionRoute(),
    ),
    SideMenuRoute(
      title: '공지사항',
      path: 'notice',
      icon: CustomMenuIcons.announcement,
      route: const NoticeRoute(),
    ),
    SideMenuRoute(
      title: '캠페인 with Docs',
      path: 'campaignWithDocs',
      icon: CustomMenuIcons.campaign,
      route: const CampaignWithDocsRoute(),
    ),
    SideMenuRoute(
      title: '이벤트/캠페인',
      icon: CustomMenuIcons.event,
      subItems: [
        SideMenuRoute(title: '이벤트', path: 'event', route: const EventRoute()),
        SideMenuRoute(title: '캠페인', path: 'campaign', route: const CampaignRoute()),
      ],
    ),
    SideMenuRoute(
      title: '팝업',
      icon: CustomMenuIcons.popup,
      subItems: [
        SideMenuRoute(title: '메인팝업', path: 'popup', route: const PopupListRoute()),
        SideMenuRoute(title: '종목팝업'),
        SideMenuRoute(title: '뉴스팝업'),
      ],
      route: const PopupListRoute(),
    ),
    SideMenuRoute(
      title: '토론방',
      icon: CustomMenuIcons.talk,
      subItems: [
        SideMenuRoute(
          title: '토론방',
          icon: CustomMenuIcons.talk,
          path: 'debate',
          route: const DebateRoute(),
        ),
        SideMenuRoute(
          title: '커뮤니티',
          path: 'community',
          route: const CommunityRoute(),
        ),
      ],
    ),
    SideMenuRoute(
      title: '신고',
      icon: CustomMenuIcons.warning,
      subItems: [
        SideMenuRoute(title: '게시글', path: 'reportPost', route: const ReportPostRoute()),
        SideMenuRoute(title: '댓글/답글', path: 'reportComment', route: const ReportCommentRoute()),
      ],
    ),
    SideMenuRoute(
      title: '푸시',
      icon: CustomMenuIcons.push,
      subItems: [
        SideMenuRoute(title: '그룹', path: 'groupPush', route: const PushGroupListRoute()),
        SideMenuRoute(title: '개인', path: 'individualPush', route: const PushIndividualListRoute()),
      ],
    ),
    SideMenuRoute(
      title: AppConfig.stopWordText,
      icon: CustomMenuIcons.stopWords,
      path: 'stopWords',
      route: const StopWordsRoute(),
    ),
  ];

  final List<TopMenuRoute> salaryPlusRoute = [
    TopMenuRoute(
      title: '대쉬보드',
      icon: CustomMenuIcons.dashboard,
      path: 'main',
      route: const DashboardRoute(),
    ),
    TopMenuRoute(
      title: '유저',
      icon: CustomMenuIcons.user,
      subItems: [
        TopMenuRoute(title: '개인', path: 'userList', route: const UsersRoute()),
        TopMenuRoute(
            title: '법인',
            path: 'corporationList',
            route: const CorporationRoute()),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(route: adminRoute);
  }
}
