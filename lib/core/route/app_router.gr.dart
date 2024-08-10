// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    NoticeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NoticeScreen(),
      );
    },
    EventBoardRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<EventBoardRegisterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EventBoardRegisterScreen(
          key: args.key,
          updatePost: args.updatePost,
          boardGroupCategory: args.boardGroupCategory,
        ),
      );
    },
    CampaignRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CampaignScreen(),
      );
    },
    EventRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EventScreen(),
      );
    },
    FullImageRoute.name: (routeData) {
      final args = routeData.argsAs<FullImageRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FullImageScreen(
          key: args.key,
          url: args.url,
        ),
      );
    },
    PopupListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PopupListScreen(),
      );
    },
    PopupDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PopupDetailRouteArgs>(
          orElse: () => PopupDetailRouteArgs(
              updatePopupId: pathParams.optInt('updatePopupId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PopupDetailScreen(
          key: args.key,
          updatePopupId: args.updatePopupId,
        ),
      );
    },
    PopupRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<PopupRegisterRouteArgs>(
          orElse: () => const PopupRegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PopupRegisterScreen(
          key: args.key,
          updatePopup: args.updatePopup,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    PostDuplicateRoute.name: (routeData) {
      final args = routeData.argsAs<PostDuplicateRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PostDuplicateScreen(
          key: args.key,
          boardGroupType: args.boardGroupType,
        ),
      );
    },
    ReplyListRoute.name: (routeData) {
      final args = routeData.argsAs<ReplyListRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReplyListScreen(
          key: args.key,
          stockCode: args.stockCode,
          boardGroup: args.boardGroup,
          postId: args.postId,
          comment: args.comment,
        ),
      );
    },
    PostRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<PostRegisterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PostRegisterScreen(
          key: args.key,
          boardGroupType: args.boardGroupType,
          updatePost: args.updatePost,
          updateStock: args.updateStock,
          updateStockGroup: args.updateStockGroup,
          campaignTitle: args.campaignTitle,
        ),
      );
    },
    PostDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostDetailRouteArgs>(
          orElse: () => PostDetailRouteArgs(
                stockCode: pathParams.getString('stockCode'),
                stockName: pathParams.getString('stockName'),
                boardGroup: pathParams.getString('boardGroup'),
                postId: pathParams.getInt('postId'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PostDetailScreen(
          key: args.key,
          stockCode: args.stockCode,
          stockName: args.stockName,
          boardGroup: args.boardGroup,
          postId: args.postId,
          boardGroupCategory: args.boardGroupCategory,
        ),
      );
    },
    PostNewsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PostNewsScreen(),
      );
    },
    PostStockRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PostStockScreen(),
      );
    },
    AuthPasswordChangeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPasswordChangeScreen(),
      );
    },
    AuthLoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthLoginScreen(),
      );
    },
    WebRoute.name: (routeData) {
      final args = routeData.argsAs<WebRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WebScreen(
          key: args.key,
          url: args.url,
          title: args.title,
          hideAppBar: args.hideAppBar,
        ),
      );
    },
    DebateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DebateScreen(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardScreen(),
      );
    },
    PushGroupListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PushGroupListScreen(),
      );
    },
    PushRegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PushRegisterScreen(),
      );
    },
    PushIndividualListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PushIndividualListScreen(),
      );
    },
    RegisterAcceptUserRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterAcceptUserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterAcceptUserScreen(
          key: args.key,
          stockCode: args.stockCode,
        ),
      );
    },
    AcceptanceListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AcceptanceListScreen(),
      );
    },
    ActionPostRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<ActionPostRegisterRouteArgs>(
          orElse: () => const ActionPostRegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ActionPostRegisterScreen(
          key: args.key,
          postType: args.postType,
        ),
      );
    },
    DigitalDocumentUsersRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<DigitalDocumentUsersRouteArgs>(
          orElse: () => DigitalDocumentUsersRouteArgs(
                id: queryParams.optInt('id'),
                title: queryParams.optString('title'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DigitalDocumentUsersScreen(
          key: args.key,
          id: args.id,
          title: args.title,
        ),
      );
    },
    ActionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActionScreen(),
      );
    },
    UsersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UsersScreen(),
      );
    },
    CorporationUserDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CorporationUserDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CorporationUserDetailScreen(
          key: args.key,
          corporationUser: args.corporationUser,
          userId: args.userId,
        ),
      );
    },
    CorporationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CorporationScreen(),
      );
    },
    CorporationRegisterRoute.name: (routeData) {
      final args = routeData.argsAs<CorporationRegisterRouteArgs>(
          orElse: () => const CorporationRegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CorporationRegisterScreen(
          key: args.key,
          corporation: args.corporation,
        ),
      );
    },
    UserDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserDetailRouteArgs>(
          orElse: () =>
              UserDetailRouteArgs(userId: pathParams.getInt('userId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserDetailScreen(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    CampaignDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CampaignDetailRouteArgs>(
          orElse: () => CampaignDetailRouteArgs(
              campaignId: pathParams.getInt('campaignId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CampaignDetailScreen(
          key: args.key,
          campaignId: args.campaignId,
        ),
      );
    },
    CampaignWithDocsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CampaignWithDocsScreen(),
      );
    },
    ReportCommentRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportCommentScreen(),
      );
    },
    ReportPostRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReportPostScreen(),
      );
    },
    ReportPostDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ReportPostDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ReportPostDetailScreen(
          key: args.key,
          reportType: args.reportType,
          reportId: args.reportId,
        ),
      );
    },
    StopWordsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StopWordsScreen(),
      );
    },
    CmsStockGroupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CmsStockGroupScreen(),
      );
    },
    CmsGroupRegisterRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CmsGroupRegisterRouteArgs>(
          orElse: () =>
              CmsGroupRegisterRouteArgs(code: pathParams.optInt('code')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CmsGroupRegisterScreen(
          key: args.key,
          code: args.code,
        ),
      );
    },
    CmsDummyStockRoute.name: (routeData) {
      final args = routeData.argsAs<CmsDummyStockRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CmsDummyStockScreen(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    CmsStockRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CmsStockScreen(),
      );
    },
    CmsStockStaticsRoute.name: (routeData) {
      final args = routeData.argsAs<CmsStockStaticsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CmsStockStaticsScreen(
          key: args.key,
          param: args.param,
        ),
      );
    },
    CmsStockDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CmsStockDetailRouteArgs>(
          orElse: () => CmsStockDetailRouteArgs(
                code: pathParams.optString('code'),
                name: pathParams.optString('name'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CmsStockDetailScreen(
          key: args.key,
          code: args.code,
          name: args.name,
        ),
      );
    },
    CommunityRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CommunityScreen(),
      );
    },
    CmsAcceptorMainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CmsAcceptorMainScreen(),
      );
    },
    CmsAdminMainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CmsAdminMainScreen(),
      );
    },
  };
}

/// generated route for
/// [NoticeScreen]
class NoticeRoute extends PageRouteInfo<void> {
  const NoticeRoute({List<PageRouteInfo>? children})
      : super(
          NoticeRoute.name,
          initialChildren: children,
        );

  static const String name = 'NoticeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EventBoardRegisterScreen]
class EventBoardRegisterRoute
    extends PageRouteInfo<EventBoardRegisterRouteArgs> {
  EventBoardRegisterRoute({
    Key? key,
    Post? updatePost,
    required BoardGroupCategory boardGroupCategory,
    List<PageRouteInfo>? children,
  }) : super(
          EventBoardRegisterRoute.name,
          args: EventBoardRegisterRouteArgs(
            key: key,
            updatePost: updatePost,
            boardGroupCategory: boardGroupCategory,
          ),
          initialChildren: children,
        );

  static const String name = 'EventBoardRegisterRoute';

  static const PageInfo<EventBoardRegisterRouteArgs> page =
      PageInfo<EventBoardRegisterRouteArgs>(name);
}

class EventBoardRegisterRouteArgs {
  const EventBoardRegisterRouteArgs({
    this.key,
    this.updatePost,
    required this.boardGroupCategory,
  });

  final Key? key;

  final Post? updatePost;

  final BoardGroupCategory boardGroupCategory;

  @override
  String toString() {
    return 'EventBoardRegisterRouteArgs{key: $key, updatePost: $updatePost, boardGroupCategory: $boardGroupCategory}';
  }
}

/// generated route for
/// [CampaignScreen]
class CampaignRoute extends PageRouteInfo<void> {
  const CampaignRoute({List<PageRouteInfo>? children})
      : super(
          CampaignRoute.name,
          initialChildren: children,
        );

  static const String name = 'CampaignRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EventScreen]
class EventRoute extends PageRouteInfo<void> {
  const EventRoute({List<PageRouteInfo>? children})
      : super(
          EventRoute.name,
          initialChildren: children,
        );

  static const String name = 'EventRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FullImageScreen]
class FullImageRoute extends PageRouteInfo<FullImageRouteArgs> {
  FullImageRoute({
    Key? key,
    required String url,
    List<PageRouteInfo>? children,
  }) : super(
          FullImageRoute.name,
          args: FullImageRouteArgs(
            key: key,
            url: url,
          ),
          initialChildren: children,
        );

  static const String name = 'FullImageRoute';

  static const PageInfo<FullImageRouteArgs> page =
      PageInfo<FullImageRouteArgs>(name);
}

class FullImageRouteArgs {
  const FullImageRouteArgs({
    this.key,
    required this.url,
  });

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'FullImageRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [PopupListScreen]
class PopupListRoute extends PageRouteInfo<void> {
  const PopupListRoute({List<PageRouteInfo>? children})
      : super(
          PopupListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PopupListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PopupDetailScreen]
class PopupDetailRoute extends PageRouteInfo<PopupDetailRouteArgs> {
  PopupDetailRoute({
    Key? key,
    int? updatePopupId,
    List<PageRouteInfo>? children,
  }) : super(
          PopupDetailRoute.name,
          args: PopupDetailRouteArgs(
            key: key,
            updatePopupId: updatePopupId,
          ),
          rawPathParams: {'updatePopupId': updatePopupId},
          initialChildren: children,
        );

  static const String name = 'PopupDetailRoute';

  static const PageInfo<PopupDetailRouteArgs> page =
      PageInfo<PopupDetailRouteArgs>(name);
}

class PopupDetailRouteArgs {
  const PopupDetailRouteArgs({
    this.key,
    this.updatePopupId,
  });

  final Key? key;

  final int? updatePopupId;

  @override
  String toString() {
    return 'PopupDetailRouteArgs{key: $key, updatePopupId: $updatePopupId}';
  }
}

/// generated route for
/// [PopupRegisterScreen]
class PopupRegisterRoute extends PageRouteInfo<PopupRegisterRouteArgs> {
  PopupRegisterRoute({
    Key? key,
    Popup? updatePopup,
    List<PageRouteInfo>? children,
  }) : super(
          PopupRegisterRoute.name,
          args: PopupRegisterRouteArgs(
            key: key,
            updatePopup: updatePopup,
          ),
          initialChildren: children,
        );

  static const String name = 'PopupRegisterRoute';

  static const PageInfo<PopupRegisterRouteArgs> page =
      PageInfo<PopupRegisterRouteArgs>(name);
}

class PopupRegisterRouteArgs {
  const PopupRegisterRouteArgs({
    this.key,
    this.updatePopup,
  });

  final Key? key;

  final Popup? updatePopup;

  @override
  String toString() {
    return 'PopupRegisterRouteArgs{key: $key, updatePopup: $updatePopup}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PostDuplicateScreen]
class PostDuplicateRoute extends PageRouteInfo<PostDuplicateRouteArgs> {
  PostDuplicateRoute({
    Key? key,
    required BoardGroupType boardGroupType,
    List<PageRouteInfo>? children,
  }) : super(
          PostDuplicateRoute.name,
          args: PostDuplicateRouteArgs(
            key: key,
            boardGroupType: boardGroupType,
          ),
          initialChildren: children,
        );

  static const String name = 'PostDuplicateRoute';

  static const PageInfo<PostDuplicateRouteArgs> page =
      PageInfo<PostDuplicateRouteArgs>(name);
}

class PostDuplicateRouteArgs {
  const PostDuplicateRouteArgs({
    this.key,
    required this.boardGroupType,
  });

  final Key? key;

  final BoardGroupType boardGroupType;

  @override
  String toString() {
    return 'PostDuplicateRouteArgs{key: $key, boardGroupType: $boardGroupType}';
  }
}

/// generated route for
/// [ReplyListScreen]
class ReplyListRoute extends PageRouteInfo<ReplyListRouteArgs> {
  ReplyListRoute({
    Key? key,
    required String stockCode,
    required String boardGroup,
    required int postId,
    required Comment comment,
    List<PageRouteInfo>? children,
  }) : super(
          ReplyListRoute.name,
          args: ReplyListRouteArgs(
            key: key,
            stockCode: stockCode,
            boardGroup: boardGroup,
            postId: postId,
            comment: comment,
          ),
          initialChildren: children,
        );

  static const String name = 'ReplyListRoute';

  static const PageInfo<ReplyListRouteArgs> page =
      PageInfo<ReplyListRouteArgs>(name);
}

class ReplyListRouteArgs {
  const ReplyListRouteArgs({
    this.key,
    required this.stockCode,
    required this.boardGroup,
    required this.postId,
    required this.comment,
  });

  final Key? key;

  final String stockCode;

  final String boardGroup;

  final int postId;

  final Comment comment;

  @override
  String toString() {
    return 'ReplyListRouteArgs{key: $key, stockCode: $stockCode, boardGroup: $boardGroup, postId: $postId, comment: $comment}';
  }
}

/// generated route for
/// [PostRegisterScreen]
class PostRegisterRoute extends PageRouteInfo<PostRegisterRouteArgs> {
  PostRegisterRoute({
    Key? key,
    required BoardGroupType boardGroupType,
    Post? updatePost,
    Stock? updateStock,
    SimpleStockGroup? updateStockGroup,
    String? campaignTitle,
    List<PageRouteInfo>? children,
  }) : super(
          PostRegisterRoute.name,
          args: PostRegisterRouteArgs(
            key: key,
            boardGroupType: boardGroupType,
            updatePost: updatePost,
            updateStock: updateStock,
            updateStockGroup: updateStockGroup,
            campaignTitle: campaignTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'PostRegisterRoute';

  static const PageInfo<PostRegisterRouteArgs> page =
      PageInfo<PostRegisterRouteArgs>(name);
}

class PostRegisterRouteArgs {
  const PostRegisterRouteArgs({
    this.key,
    required this.boardGroupType,
    this.updatePost,
    this.updateStock,
    this.updateStockGroup,
    this.campaignTitle,
  });

  final Key? key;

  final BoardGroupType boardGroupType;

  final Post? updatePost;

  final Stock? updateStock;

  final SimpleStockGroup? updateStockGroup;

  final String? campaignTitle;

  @override
  String toString() {
    return 'PostRegisterRouteArgs{key: $key, boardGroupType: $boardGroupType, updatePost: $updatePost, updateStock: $updateStock, updateStockGroup: $updateStockGroup, campaignTitle: $campaignTitle}';
  }
}

/// generated route for
/// [PostDetailScreen]
class PostDetailRoute extends PageRouteInfo<PostDetailRouteArgs> {
  PostDetailRoute({
    Key? key,
    required String stockCode,
    required String stockName,
    required String boardGroup,
    required int postId,
    BoardGroupCategory? boardGroupCategory,
    List<PageRouteInfo>? children,
  }) : super(
          PostDetailRoute.name,
          args: PostDetailRouteArgs(
            key: key,
            stockCode: stockCode,
            stockName: stockName,
            boardGroup: boardGroup,
            postId: postId,
            boardGroupCategory: boardGroupCategory,
          ),
          rawPathParams: {
            'stockCode': stockCode,
            'stockName': stockName,
            'boardGroup': boardGroup,
            'postId': postId,
          },
          initialChildren: children,
        );

  static const String name = 'PostDetailRoute';

  static const PageInfo<PostDetailRouteArgs> page =
      PageInfo<PostDetailRouteArgs>(name);
}

class PostDetailRouteArgs {
  const PostDetailRouteArgs({
    this.key,
    required this.stockCode,
    required this.stockName,
    required this.boardGroup,
    required this.postId,
    this.boardGroupCategory,
  });

  final Key? key;

  final String stockCode;

  final String stockName;

  final String boardGroup;

  final int postId;

  final BoardGroupCategory? boardGroupCategory;

  @override
  String toString() {
    return 'PostDetailRouteArgs{key: $key, stockCode: $stockCode, stockName: $stockName, boardGroup: $boardGroup, postId: $postId, boardGroupCategory: $boardGroupCategory}';
  }
}

/// generated route for
/// [PostNewsScreen]
class PostNewsRoute extends PageRouteInfo<void> {
  const PostNewsRoute({List<PageRouteInfo>? children})
      : super(
          PostNewsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostNewsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PostStockScreen]
class PostStockRoute extends PageRouteInfo<void> {
  const PostStockRoute({List<PageRouteInfo>? children})
      : super(
          PostStockRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostStockRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthPasswordChangeScreen]
class AuthPasswordChangeRoute extends PageRouteInfo<void> {
  const AuthPasswordChangeRoute({List<PageRouteInfo>? children})
      : super(
          AuthPasswordChangeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthPasswordChangeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthLoginScreen]
class AuthLoginRoute extends PageRouteInfo<void> {
  const AuthLoginRoute({List<PageRouteInfo>? children})
      : super(
          AuthLoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthLoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WebScreen]
class WebRoute extends PageRouteInfo<WebRouteArgs> {
  WebRoute({
    Key? key,
    required String url,
    String title = '',
    bool hideAppBar = false,
    List<PageRouteInfo>? children,
  }) : super(
          WebRoute.name,
          args: WebRouteArgs(
            key: key,
            url: url,
            title: title,
            hideAppBar: hideAppBar,
          ),
          initialChildren: children,
        );

  static const String name = 'WebRoute';

  static const PageInfo<WebRouteArgs> page = PageInfo<WebRouteArgs>(name);
}

class WebRouteArgs {
  const WebRouteArgs({
    this.key,
    required this.url,
    this.title = '',
    this.hideAppBar = false,
  });

  final Key? key;

  final String url;

  final String title;

  final bool hideAppBar;

  @override
  String toString() {
    return 'WebRouteArgs{key: $key, url: $url, title: $title, hideAppBar: $hideAppBar}';
  }
}

/// generated route for
/// [DebateScreen]
class DebateRoute extends PageRouteInfo<void> {
  const DebateRoute({List<PageRouteInfo>? children})
      : super(
          DebateRoute.name,
          initialChildren: children,
        );

  static const String name = 'DebateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PushGroupListScreen]
class PushGroupListRoute extends PageRouteInfo<void> {
  const PushGroupListRoute({List<PageRouteInfo>? children})
      : super(
          PushGroupListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PushGroupListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PushRegisterScreen]
class PushRegisterRoute extends PageRouteInfo<void> {
  const PushRegisterRoute({List<PageRouteInfo>? children})
      : super(
          PushRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'PushRegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PushIndividualListScreen]
class PushIndividualListRoute extends PageRouteInfo<void> {
  const PushIndividualListRoute({List<PageRouteInfo>? children})
      : super(
          PushIndividualListRoute.name,
          initialChildren: children,
        );

  static const String name = 'PushIndividualListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterAcceptUserScreen]
class RegisterAcceptUserRoute
    extends PageRouteInfo<RegisterAcceptUserRouteArgs> {
  RegisterAcceptUserRoute({
    Key? key,
    required String stockCode,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterAcceptUserRoute.name,
          args: RegisterAcceptUserRouteArgs(
            key: key,
            stockCode: stockCode,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterAcceptUserRoute';

  static const PageInfo<RegisterAcceptUserRouteArgs> page =
      PageInfo<RegisterAcceptUserRouteArgs>(name);
}

class RegisterAcceptUserRouteArgs {
  const RegisterAcceptUserRouteArgs({
    this.key,
    required this.stockCode,
  });

  final Key? key;

  final String stockCode;

  @override
  String toString() {
    return 'RegisterAcceptUserRouteArgs{key: $key, stockCode: $stockCode}';
  }
}

/// generated route for
/// [AcceptanceListScreen]
class AcceptanceListRoute extends PageRouteInfo<void> {
  const AcceptanceListRoute({List<PageRouteInfo>? children})
      : super(
          AcceptanceListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AcceptanceListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ActionPostRegisterScreen]
class ActionPostRegisterRoute
    extends PageRouteInfo<ActionPostRegisterRouteArgs> {
  ActionPostRegisterRoute({
    Key? key,
    ActionPostType postType = ActionPostType.action,
    List<PageRouteInfo>? children,
  }) : super(
          ActionPostRegisterRoute.name,
          args: ActionPostRegisterRouteArgs(
            key: key,
            postType: postType,
          ),
          initialChildren: children,
        );

  static const String name = 'ActionPostRegisterRoute';

  static const PageInfo<ActionPostRegisterRouteArgs> page =
      PageInfo<ActionPostRegisterRouteArgs>(name);
}

class ActionPostRegisterRouteArgs {
  const ActionPostRegisterRouteArgs({
    this.key,
    this.postType = ActionPostType.action,
  });

  final Key? key;

  final ActionPostType postType;

  @override
  String toString() {
    return 'ActionPostRegisterRouteArgs{key: $key, postType: $postType}';
  }
}

/// generated route for
/// [DigitalDocumentUsersScreen]
class DigitalDocumentUsersRoute
    extends PageRouteInfo<DigitalDocumentUsersRouteArgs> {
  DigitalDocumentUsersRoute({
    Key? key,
    int? id,
    String? title,
    List<PageRouteInfo>? children,
  }) : super(
          DigitalDocumentUsersRoute.name,
          args: DigitalDocumentUsersRouteArgs(
            key: key,
            id: id,
            title: title,
          ),
          rawQueryParams: {
            'id': id,
            'title': title,
          },
          initialChildren: children,
        );

  static const String name = 'DigitalDocumentUsersRoute';

  static const PageInfo<DigitalDocumentUsersRouteArgs> page =
      PageInfo<DigitalDocumentUsersRouteArgs>(name);
}

class DigitalDocumentUsersRouteArgs {
  const DigitalDocumentUsersRouteArgs({
    this.key,
    this.id,
    this.title,
  });

  final Key? key;

  final int? id;

  final String? title;

  @override
  String toString() {
    return 'DigitalDocumentUsersRouteArgs{key: $key, id: $id, title: $title}';
  }
}

/// generated route for
/// [ActionScreen]
class ActionRoute extends PageRouteInfo<void> {
  const ActionRoute({List<PageRouteInfo>? children})
      : super(
          ActionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UsersScreen]
class UsersRoute extends PageRouteInfo<void> {
  const UsersRoute({List<PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CorporationUserDetailScreen]
class CorporationUserDetailRoute
    extends PageRouteInfo<CorporationUserDetailRouteArgs> {
  CorporationUserDetailRoute({
    Key? key,
    required CorporationUser corporationUser,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          CorporationUserDetailRoute.name,
          args: CorporationUserDetailRouteArgs(
            key: key,
            corporationUser: corporationUser,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
          initialChildren: children,
        );

  static const String name = 'CorporationUserDetailRoute';

  static const PageInfo<CorporationUserDetailRouteArgs> page =
      PageInfo<CorporationUserDetailRouteArgs>(name);
}

class CorporationUserDetailRouteArgs {
  const CorporationUserDetailRouteArgs({
    this.key,
    required this.corporationUser,
    required this.userId,
  });

  final Key? key;

  final CorporationUser corporationUser;

  final int userId;

  @override
  String toString() {
    return 'CorporationUserDetailRouteArgs{key: $key, corporationUser: $corporationUser, userId: $userId}';
  }
}

/// generated route for
/// [CorporationScreen]
class CorporationRoute extends PageRouteInfo<void> {
  const CorporationRoute({List<PageRouteInfo>? children})
      : super(
          CorporationRoute.name,
          initialChildren: children,
        );

  static const String name = 'CorporationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CorporationRegisterScreen]
class CorporationRegisterRoute
    extends PageRouteInfo<CorporationRegisterRouteArgs> {
  CorporationRegisterRoute({
    Key? key,
    CorporationUser? corporation,
    List<PageRouteInfo>? children,
  }) : super(
          CorporationRegisterRoute.name,
          args: CorporationRegisterRouteArgs(
            key: key,
            corporation: corporation,
          ),
          initialChildren: children,
        );

  static const String name = 'CorporationRegisterRoute';

  static const PageInfo<CorporationRegisterRouteArgs> page =
      PageInfo<CorporationRegisterRouteArgs>(name);
}

class CorporationRegisterRouteArgs {
  const CorporationRegisterRouteArgs({
    this.key,
    this.corporation,
  });

  final Key? key;

  final CorporationUser? corporation;

  @override
  String toString() {
    return 'CorporationRegisterRouteArgs{key: $key, corporation: $corporation}';
  }
}

/// generated route for
/// [UserDetailScreen]
class UserDetailRoute extends PageRouteInfo<UserDetailRouteArgs> {
  UserDetailRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          UserDetailRoute.name,
          args: UserDetailRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'userId': userId},
          initialChildren: children,
        );

  static const String name = 'UserDetailRoute';

  static const PageInfo<UserDetailRouteArgs> page =
      PageInfo<UserDetailRouteArgs>(name);
}

class UserDetailRouteArgs {
  const UserDetailRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserDetailRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [CampaignDetailScreen]
class CampaignDetailRoute extends PageRouteInfo<CampaignDetailRouteArgs> {
  CampaignDetailRoute({
    Key? key,
    required int campaignId,
    List<PageRouteInfo>? children,
  }) : super(
          CampaignDetailRoute.name,
          args: CampaignDetailRouteArgs(
            key: key,
            campaignId: campaignId,
          ),
          rawPathParams: {'campaignId': campaignId},
          initialChildren: children,
        );

  static const String name = 'CampaignDetailRoute';

  static const PageInfo<CampaignDetailRouteArgs> page =
      PageInfo<CampaignDetailRouteArgs>(name);
}

class CampaignDetailRouteArgs {
  const CampaignDetailRouteArgs({
    this.key,
    required this.campaignId,
  });

  final Key? key;

  final int campaignId;

  @override
  String toString() {
    return 'CampaignDetailRouteArgs{key: $key, campaignId: $campaignId}';
  }
}

/// generated route for
/// [CampaignWithDocsScreen]
class CampaignWithDocsRoute extends PageRouteInfo<void> {
  const CampaignWithDocsRoute({List<PageRouteInfo>? children})
      : super(
          CampaignWithDocsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CampaignWithDocsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportCommentScreen]
class ReportCommentRoute extends PageRouteInfo<void> {
  const ReportCommentRoute({List<PageRouteInfo>? children})
      : super(
          ReportCommentRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportCommentRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportPostScreen]
class ReportPostRoute extends PageRouteInfo<void> {
  const ReportPostRoute({List<PageRouteInfo>? children})
      : super(
          ReportPostRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReportPostRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ReportPostDetailScreen]
class ReportPostDetailRoute extends PageRouteInfo<ReportPostDetailRouteArgs> {
  ReportPostDetailRoute({
    Key? key,
    required String reportType,
    required int reportId,
    List<PageRouteInfo>? children,
  }) : super(
          ReportPostDetailRoute.name,
          args: ReportPostDetailRouteArgs(
            key: key,
            reportType: reportType,
            reportId: reportId,
          ),
          initialChildren: children,
        );

  static const String name = 'ReportPostDetailRoute';

  static const PageInfo<ReportPostDetailRouteArgs> page =
      PageInfo<ReportPostDetailRouteArgs>(name);
}

class ReportPostDetailRouteArgs {
  const ReportPostDetailRouteArgs({
    this.key,
    required this.reportType,
    required this.reportId,
  });

  final Key? key;

  final String reportType;

  final int reportId;

  @override
  String toString() {
    return 'ReportPostDetailRouteArgs{key: $key, reportType: $reportType, reportId: $reportId}';
  }
}

/// generated route for
/// [StopWordsScreen]
class StopWordsRoute extends PageRouteInfo<void> {
  const StopWordsRoute({List<PageRouteInfo>? children})
      : super(
          StopWordsRoute.name,
          initialChildren: children,
        );

  static const String name = 'StopWordsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CmsStockGroupScreen]
class CmsStockGroupRoute extends PageRouteInfo<void> {
  const CmsStockGroupRoute({List<PageRouteInfo>? children})
      : super(
          CmsStockGroupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CmsStockGroupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CmsGroupRegisterScreen]
class CmsGroupRegisterRoute extends PageRouteInfo<CmsGroupRegisterRouteArgs> {
  CmsGroupRegisterRoute({
    Key? key,
    int? code,
    List<PageRouteInfo>? children,
  }) : super(
          CmsGroupRegisterRoute.name,
          args: CmsGroupRegisterRouteArgs(
            key: key,
            code: code,
          ),
          rawPathParams: {'code': code},
          initialChildren: children,
        );

  static const String name = 'CmsGroupRegisterRoute';

  static const PageInfo<CmsGroupRegisterRouteArgs> page =
      PageInfo<CmsGroupRegisterRouteArgs>(name);
}

class CmsGroupRegisterRouteArgs {
  const CmsGroupRegisterRouteArgs({
    this.key,
    this.code,
  });

  final Key? key;

  final int? code;

  @override
  String toString() {
    return 'CmsGroupRegisterRouteArgs{key: $key, code: $code}';
  }
}

/// generated route for
/// [CmsDummyStockScreen]
class CmsDummyStockRoute extends PageRouteInfo<CmsDummyStockRouteArgs> {
  CmsDummyStockRoute({
    Key? key,
    required int userId,
    List<PageRouteInfo>? children,
  }) : super(
          CmsDummyStockRoute.name,
          args: CmsDummyStockRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'CmsDummyStockRoute';

  static const PageInfo<CmsDummyStockRouteArgs> page =
      PageInfo<CmsDummyStockRouteArgs>(name);
}

class CmsDummyStockRouteArgs {
  const CmsDummyStockRouteArgs({
    this.key,
    required this.userId,
  });

  final Key? key;

  final int userId;

  @override
  String toString() {
    return 'CmsDummyStockRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [CmsStockScreen]
class CmsStockRoute extends PageRouteInfo<void> {
  const CmsStockRoute({List<PageRouteInfo>? children})
      : super(
          CmsStockRoute.name,
          initialChildren: children,
        );

  static const String name = 'CmsStockRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CmsStockStaticsScreen]
class CmsStockStaticsRoute extends PageRouteInfo<CmsStockStaticsRouteArgs> {
  CmsStockStaticsRoute({
    Key? key,
    required StockDetail param,
    List<PageRouteInfo>? children,
  }) : super(
          CmsStockStaticsRoute.name,
          args: CmsStockStaticsRouteArgs(
            key: key,
            param: param,
          ),
          initialChildren: children,
        );

  static const String name = 'CmsStockStaticsRoute';

  static const PageInfo<CmsStockStaticsRouteArgs> page =
      PageInfo<CmsStockStaticsRouteArgs>(name);
}

class CmsStockStaticsRouteArgs {
  const CmsStockStaticsRouteArgs({
    this.key,
    required this.param,
  });

  final Key? key;

  final StockDetail param;

  @override
  String toString() {
    return 'CmsStockStaticsRouteArgs{key: $key, param: $param}';
  }
}

/// generated route for
/// [CmsStockDetailScreen]
class CmsStockDetailRoute extends PageRouteInfo<CmsStockDetailRouteArgs> {
  CmsStockDetailRoute({
    Key? key,
    String? code,
    String? name,
    List<PageRouteInfo>? children,
  }) : super(
          CmsStockDetailRoute.name,
          args: CmsStockDetailRouteArgs(
            key: key,
            code: code,
            name: name,
          ),
          rawPathParams: {
            'code': code,
            'name': name,
          },
          initialChildren: children,
        );

  static const String name = 'CmsStockDetailRoute';

  static const PageInfo<CmsStockDetailRouteArgs> page =
      PageInfo<CmsStockDetailRouteArgs>(name);
}

class CmsStockDetailRouteArgs {
  const CmsStockDetailRouteArgs({
    this.key,
    this.code,
    this.name,
  });

  final Key? key;

  final String? code;

  final String? name;

  @override
  String toString() {
    return 'CmsStockDetailRouteArgs{key: $key, code: $code, name: $name}';
  }
}

/// generated route for
/// [CommunityScreen]
class CommunityRoute extends PageRouteInfo<void> {
  const CommunityRoute({List<PageRouteInfo>? children})
      : super(
          CommunityRoute.name,
          initialChildren: children,
        );

  static const String name = 'CommunityRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CmsAcceptorMainScreen]
class CmsAcceptorMainRoute extends PageRouteInfo<void> {
  const CmsAcceptorMainRoute({List<PageRouteInfo>? children})
      : super(
          CmsAcceptorMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'CmsAcceptorMainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CmsAdminMainScreen]
class CmsAdminMainRoute extends PageRouteInfo<void> {
  const CmsAdminMainRoute({List<PageRouteInfo>? children})
      : super(
          CmsAdminMainRoute.name,
          initialChildren: children,
        );

  static const String name = 'CmsAdminMainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
