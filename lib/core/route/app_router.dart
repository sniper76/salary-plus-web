import 'package:act_web/core/route/auth_guard.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/presentation/screen/home/screen.dart';
import 'package:act_web/presentation/screen/post/detail/screen.dart';
import 'package:act_web/presentation/screen/post/save/screen.dart';
import 'package:act_web/presentation/screen/stock/screen.dart';
import 'package:act_web/presentation/screen/stock_detail/home/screen.dart';
import 'package:act_web/presentation/screen/stock_detail/post_list/screen.dart';
import 'package:act_web/presentation/screen/stock_detail/screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          initial: true,
          path: '/',
          page: HomeRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),

        CustomRoute(
          path: '/stock',
          page: StockRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          guards: [AuthGuard()],
        ),

        // 종목 상세 화면들
        CustomRoute(
          path: '/stock/:stockCode',
          page: StockDetailRoute.page,
          children: [
            AutoRoute(
              path: 'home',
              page: StockHomeRoute.page,
              initial: true,
            ),
            AutoRoute(
              path: ':boardGroupTypeName',
              page: StockPostListRoute.page,
            ),
          ],
          guards: [AuthGuard()],
        ),

        // 글 관련 화면들
        CustomRoute(
          path: '/stock/:stockCode/board/:boardGroupName/post/:postId',
          page: PostDetailRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          guards: [AuthGuard()],
        ),

        CustomRoute(
          path: '/post/save',
          page: PostSaveRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
          guards: [AuthGuard()],
        )
      ];
}
