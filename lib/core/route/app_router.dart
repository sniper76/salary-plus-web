import 'package:act_cms/core/route/auth_guard.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/presentation/screen/acception/list/acceptance_list_screen.dart';
import 'package:act_cms/presentation/screen/acception/register/register_accept_user_screen.dart';
import 'package:act_cms/presentation/screen/action/screen.dart';
import 'package:act_cms/presentation/screen/action/digitalDocument/digital_document_users_screen.dart';
import 'package:act_cms/presentation/screen/action/register/post_register_screen.dart';
import 'package:act_cms/presentation/screen/auth/admin_login/auth_login_screen.dart';
import 'package:act_cms/presentation/screen/auth/admin_password_change/auth_password_change_screen.dart';
import 'package:act_cms/presentation/screen/campaign/detail/camapign_detail_screen.dart';
import 'package:act_cms/presentation/screen/campaign/list/screen.dart';
import 'package:act_cms/presentation/screen/cms_main/cms_acceptor_main_screen.dart';
import 'package:act_cms/presentation/screen/community/community_screen.dart';
import 'package:act_cms/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:act_cms/presentation/screen/debate/debate_screen.dart';
import 'package:act_cms/presentation/screen/event_board/campaign/screen.dart';
import 'package:act_cms/presentation/screen/event_board/event/screen.dart';
import 'package:act_cms/presentation/screen/event_board/notice/screen.dart';
import 'package:act_cms/presentation/screen/event_board/register/screen.dart';

import 'package:act_cms/presentation/screen/fullimage/full_image_screen.dart';
import 'package:act_cms/presentation/screen/popup/list/popup_list_screen.dart';
import 'package:act_cms/presentation/screen/popup/popup_detail/popup_detail_screen.dart';
import 'package:act_cms/presentation/screen/popup/popup_register/popup_register_screen.dart';
import 'package:act_cms/presentation/screen/post/detail/post_detail_screen.dart';
import 'package:act_cms/presentation/screen/post/duplicate/post_duplicate_screen.dart';
import 'package:act_cms/presentation/screen/post/news/post_news_screen.dart';
import 'package:act_cms/presentation/screen/post/register/post_register_screen.dart';
import 'package:act_cms/presentation/screen/post/reply/reply_list_screen.dart';
import 'package:act_cms/presentation/screen/post/stock/post_stock_screen.dart';
import 'package:act_cms/presentation/screen/push/group/push_group_list_screen.dart';
import 'package:act_cms/presentation/screen/push/individual/push_individual_list_screen.dart';
import 'package:act_cms/presentation/screen/push/push_register/push_register_screen.dart';
import 'package:act_cms/presentation/screen/report/report_comment/report_comment_screen.dart';
import 'package:act_cms/presentation/screen/report/report_post/report_post_screen.dart';
import 'package:act_cms/presentation/screen/report/report_post_detail/report_port_detail_screen.dart';
import 'package:act_cms/presentation/screen/splash/splash_screen.dart';
import 'package:act_cms/presentation/screen/stock/cmsDummyStock/cms_dummy_stock_screen.dart';
import 'package:act_cms/presentation/screen/stock/cmsGroup/cms_group_register_screen.dart';
import 'package:act_cms/presentation/screen/stock/cmsGroup/cms_group_screen.dart';
import 'package:act_cms/presentation/screen/stock/cmsStock/cms_stock_screen.dart';
import 'package:act_cms/presentation/screen/stock/cmsStock/detail/cms_stock_detail_screen.dart';
import 'package:act_cms/presentation/screen/stock/cmsStock/statics/cms_stock_statics_screen.dart';
import 'package:act_cms/presentation/screen/stop_words/screen.dart';
import 'package:act_cms/presentation/screen/users/corporation_register/corporation_register_screen.dart';
import 'package:act_cms/presentation/screen/users/corporation_user/corporation_screen.dart';
import 'package:act_cms/presentation/screen/users/corporation_user_detail/corporation_user_detail_screen.dart';
import 'package:act_cms/presentation/screen/users/individual_user/screen.dart';
import 'package:act_cms/presentation/screen/users/individual_user_detail/screen.dart';
import 'package:act_cms/presentation/screen/web/web_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../presentation/screen/cms_main/cms_admin_main_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final _authGuard = AuthGuard();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/splash', page: SplashRoute.page, initial: true),

        AutoRoute(path: '/login', page: AuthLoginRoute.page),
        AutoRoute(path: '/change_password', page: AuthPasswordChangeRoute.page),

        // 메인 화면들
        AutoRoute(
          path: '/acceptorMain',
          page: CmsAcceptorMainRoute.page,
          guards: [_authGuard],
          children: [
            AutoRoute(path: '', page: AcceptanceListRoute.page),
            AutoRoute(
              path: 'postDetail/:stockCode/:stockName/:boardGroup/:postId',
              page: PostDetailRoute.page,
            ),
            AutoRoute(
              path: 'digitalDocument/:id/:title',
              page: DigitalDocumentUsersRoute.page,
            ),
          ],
        ),

        AutoRoute(path: '/main', page: CmsAdminMainRoute.page, guards: [
          _authGuard
        ], children: [
          AutoRoute(
            path: '',
            page: DashboardRoute.page,
          ),
          AutoRoute(
            path: 'userList',
            page: UsersRoute.page,
          ),
          AutoRoute(
            path: 'corporationList',
            page: CorporationRoute.page,
          ),
          AutoRoute(
            path: 'userList/:userId',
            page: UserDetailRoute.page,
          ),
          AutoRoute(
            path: 'corporationRegister',
            page: CorporationRegisterRoute.page,
          ),
          AutoRoute(
            path: 'corporation/:userId',
            page: CorporationUserDetailRoute.page,
          ),
          AutoRoute(
            path: 'stock',
            page: CmsStockRoute.page,
          ),
          AutoRoute(
            path: 'stockStatics',
            page: CmsStockStaticsRoute.page,
          ),
          AutoRoute(
            path: 'stock/:code/:name',
            page: CmsStockDetailRoute.page,
          ),
          AutoRoute(
            path: 'stock/dummyStock',
            page: CmsDummyStockRoute.page,
          ),
          AutoRoute(
            path: 'stockGroup',
            page: CmsStockGroupRoute.page,
          ),
          AutoRoute(
            path: 'stockGroupRegister/:code',
            page: CmsGroupRegisterRoute.page,
          ),
          AutoRoute(
            path: 'postNews',
            page: PostNewsRoute.page,
          ),
          AutoRoute(
            path: 'postDetail/:stockCode/:stockName/:boardGroup/:postId',
            page: PostDetailRoute.page,
          ),
          AutoRoute(
            path: 'postRegister',
            page: PostRegisterRoute.page,
          ),
          AutoRoute(
            path: 'postDuplicate/:boardGroupType',
            page: PostDuplicateRoute.page,
          ),
          AutoRoute(
            path: 'actionPostRegister',
            page: ActionPostRegisterRoute.page,
          ),
          AutoRoute(
            path: 'digitalDocument/:id/:title',
            page: DigitalDocumentUsersRoute.page,
          ),
          AutoRoute(
            path: 'postStock',
            page: PostStockRoute.page,
          ),
          AutoRoute(
            path: 'action',
            page: ActionRoute.page,
          ),
          AutoRoute(
            path: 'debate',
            page: DebateRoute.page,
          ),
          AutoRoute(
            path: 'community',
            page: CommunityRoute.page,
          ),
          AutoRoute(
            path: 'reportPost',
            page: ReportPostRoute.page,
          ),
          AutoRoute(
            path: 'reportPostDetail',
            page: ReportPostDetailRoute.page,
          ),
          AutoRoute(
            path: 'reportComment',
            page: ReportCommentRoute.page,
          ),
          AutoRoute(
            path: 'groupPush',
            page: PushGroupListRoute.page,
          ),
          AutoRoute(
            path: 'individualPush',
            page: PushIndividualListRoute.page,
          ),
          AutoRoute(
            path: 'pushRegister',
            page: PushRegisterRoute.page,
          ),
          AutoRoute(
            path: 'popup',
            page: PopupListRoute.page,
          ),
          AutoRoute(
            path: 'popup/:updatePopupId',
            page: PopupDetailRoute.page,
          ),
          AutoRoute(
            path: 'popupRegister',
            page: PopupRegisterRoute.page,
          ),
          AutoRoute(
            path: 'replyList',
            page: ReplyListRoute.page,
          ),
          AutoRoute(
            path: 'campaignWithDocs',
            page: CampaignWithDocsRoute.page,
          ),
          AutoRoute(
            path: 'campaign',
            page: CampaignRoute.page,
          ),
          AutoRoute(
            path: 'campaign/:campaignId',
            page: CampaignDetailRoute.page,
          ),
          AutoRoute(
            path: 'registerAcceptUser',
            page: RegisterAcceptUserRoute.page,
          ),
          AutoRoute(
            path: 'stopWords',
            page: StopWordsRoute.page,
          ),
          AutoRoute(
            path: 'notice',
            page: NoticeRoute.page,
          ),
          AutoRoute(
            path: 'event',
            page: EventRoute.page,
          ),
          AutoRoute(
            path: 'registerEventBoard',
            page: EventBoardRegisterRoute.page,
          ),
        ]),
      ];
}
