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
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    PostDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostDetailRouteArgs>(
          orElse: () => PostDetailRouteArgs(
                stockCode: pathParams.getString('stockCode'),
                boardGroupName: pathParams.getString('boardGroupName'),
                postId: pathParams.getInt('postId'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PostDetailScreen(
          key: args.key,
          stockCode: args.stockCode,
          boardGroupName: args.boardGroupName,
          postId: args.postId,
        ),
      );
    },
    PostSaveRoute.name: (routeData) {
      final args = routeData.argsAs<PostSaveRouteArgs>(
          orElse: () => const PostSaveRouteArgs());
      return AutoRoutePage<bool>(
        routeData: routeData,
        child: PostSaveScreen(
          key: args.key,
          stockCode: args.stockCode,
          boardGroupType: args.boardGroupType,
          boardGroupCategory: args.boardGroupCategory,
          post: args.post,
        ),
      );
    },
    StockDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StockDetailRouteArgs>(
          orElse: () => StockDetailRouteArgs(
              stockCode: pathParams.getString('stockCode')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StockDetailScreen(
          key: args.key,
          stockCode: args.stockCode,
        ),
      );
    },
    StockHomeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StockHomeRouteArgs>(
          orElse: () =>
              StockHomeRouteArgs(stockCode: pathParams.getString('stockCode')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StockHomeScreen(
          key: args.key,
          stockCode: args.stockCode,
        ),
      );
    },
    StockPostListRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<StockPostListRouteArgs>(
          orElse: () => StockPostListRouteArgs(
                stockCode: pathParams.getString('stockCode'),
                boardGroupTypeName: pathParams.getString('boardGroupTypeName'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: StockPostListScreen(
          key: args.key,
          stockCode: args.stockCode,
          boardGroupTypeName: args.boardGroupTypeName,
        ),
      );
    },
    StockRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StockScreen(),
      );
    },
  };
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PostDetailScreen]
class PostDetailRoute extends PageRouteInfo<PostDetailRouteArgs> {
  PostDetailRoute({
    Key? key,
    required String stockCode,
    required String boardGroupName,
    required int postId,
    List<PageRouteInfo>? children,
  }) : super(
          PostDetailRoute.name,
          args: PostDetailRouteArgs(
            key: key,
            stockCode: stockCode,
            boardGroupName: boardGroupName,
            postId: postId,
          ),
          rawPathParams: {
            'stockCode': stockCode,
            'boardGroupName': boardGroupName,
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
    required this.boardGroupName,
    required this.postId,
  });

  final Key? key;

  final String stockCode;

  final String boardGroupName;

  final int postId;

  @override
  String toString() {
    return 'PostDetailRouteArgs{key: $key, stockCode: $stockCode, boardGroupName: $boardGroupName, postId: $postId}';
  }
}

/// generated route for
/// [PostSaveScreen]
class PostSaveRoute extends PageRouteInfo<PostSaveRouteArgs> {
  PostSaveRoute({
    Key? key,
    String? stockCode,
    BoardGroupType? boardGroupType,
    BoardGroupCategory? boardGroupCategory,
    Post? post,
    List<PageRouteInfo>? children,
  }) : super(
          PostSaveRoute.name,
          args: PostSaveRouteArgs(
            key: key,
            stockCode: stockCode,
            boardGroupType: boardGroupType,
            boardGroupCategory: boardGroupCategory,
            post: post,
          ),
          initialChildren: children,
        );

  static const String name = 'PostSaveRoute';

  static const PageInfo<PostSaveRouteArgs> page =
      PageInfo<PostSaveRouteArgs>(name);
}

class PostSaveRouteArgs {
  const PostSaveRouteArgs({
    this.key,
    this.stockCode,
    this.boardGroupType,
    this.boardGroupCategory,
    this.post,
  });

  final Key? key;

  final String? stockCode;

  final BoardGroupType? boardGroupType;

  final BoardGroupCategory? boardGroupCategory;

  final Post? post;

  @override
  String toString() {
    return 'PostSaveRouteArgs{key: $key, stockCode: $stockCode, boardGroupType: $boardGroupType, boardGroupCategory: $boardGroupCategory, post: $post}';
  }
}

/// generated route for
/// [StockDetailScreen]
class StockDetailRoute extends PageRouteInfo<StockDetailRouteArgs> {
  StockDetailRoute({
    Key? key,
    required String stockCode,
    List<PageRouteInfo>? children,
  }) : super(
          StockDetailRoute.name,
          args: StockDetailRouteArgs(
            key: key,
            stockCode: stockCode,
          ),
          rawPathParams: {'stockCode': stockCode},
          initialChildren: children,
        );

  static const String name = 'StockDetailRoute';

  static const PageInfo<StockDetailRouteArgs> page =
      PageInfo<StockDetailRouteArgs>(name);
}

class StockDetailRouteArgs {
  const StockDetailRouteArgs({
    this.key,
    required this.stockCode,
  });

  final Key? key;

  final String stockCode;

  @override
  String toString() {
    return 'StockDetailRouteArgs{key: $key, stockCode: $stockCode}';
  }
}

/// generated route for
/// [StockHomeScreen]
class StockHomeRoute extends PageRouteInfo<StockHomeRouteArgs> {
  StockHomeRoute({
    Key? key,
    required String stockCode,
    List<PageRouteInfo>? children,
  }) : super(
          StockHomeRoute.name,
          args: StockHomeRouteArgs(
            key: key,
            stockCode: stockCode,
          ),
          rawPathParams: {'stockCode': stockCode},
          initialChildren: children,
        );

  static const String name = 'StockHomeRoute';

  static const PageInfo<StockHomeRouteArgs> page =
      PageInfo<StockHomeRouteArgs>(name);
}

class StockHomeRouteArgs {
  const StockHomeRouteArgs({
    this.key,
    required this.stockCode,
  });

  final Key? key;

  final String stockCode;

  @override
  String toString() {
    return 'StockHomeRouteArgs{key: $key, stockCode: $stockCode}';
  }
}

/// generated route for
/// [StockPostListScreen]
class StockPostListRoute extends PageRouteInfo<StockPostListRouteArgs> {
  StockPostListRoute({
    Key? key,
    required String stockCode,
    required String boardGroupTypeName,
    List<PageRouteInfo>? children,
  }) : super(
          StockPostListRoute.name,
          args: StockPostListRouteArgs(
            key: key,
            stockCode: stockCode,
            boardGroupTypeName: boardGroupTypeName,
          ),
          rawPathParams: {
            'stockCode': stockCode,
            'boardGroupTypeName': boardGroupTypeName,
          },
          initialChildren: children,
        );

  static const String name = 'StockPostListRoute';

  static const PageInfo<StockPostListRouteArgs> page =
      PageInfo<StockPostListRouteArgs>(name);
}

class StockPostListRouteArgs {
  const StockPostListRouteArgs({
    this.key,
    required this.stockCode,
    required this.boardGroupTypeName,
  });

  final Key? key;

  final String stockCode;

  final String boardGroupTypeName;

  @override
  String toString() {
    return 'StockPostListRouteArgs{key: $key, stockCode: $stockCode, boardGroupTypeName: $boardGroupTypeName}';
  }
}

/// generated route for
/// [StockScreen]
class StockRoute extends PageRouteInfo<void> {
  const StockRoute({List<PageRouteInfo>? children})
      : super(
          StockRoute.name,
          initialChildren: children,
        );

  static const String name = 'StockRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
