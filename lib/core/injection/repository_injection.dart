import 'package:act_web/data/repository/auth_repository_impl.dart';
import 'package:act_web/data/repository/comment_repository_impl.dart';
import 'package:act_web/data/repository/common_repository_impl.dart';
import 'package:act_web/data/repository/home_repository_impl.dart';
import 'package:act_web/data/repository/post_repository_impl.dart';
import 'package:act_web/data/repository/ranking_repository_impl.dart';
import 'package:act_web/data/repository/stock_repository_impl.dart';
import 'package:act_web/data/repository/user_repository_impl.dart';
import 'package:act_web/data/repository/web_repository_impl.dart';
import 'package:act_web/domain/repository/auth_repository.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:act_web/domain/repository/common_repository.dart';
import 'package:act_web/domain/repository/home_repository.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:act_web/domain/repository/ranking_repository.dart';
import 'package:act_web/domain/repository/stock_repository.dart';
import 'package:act_web/domain/repository/user_repository.dart';
import 'package:act_web/domain/repository/web_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryInjection {
  static inject() {
    GetIt.I.registerSingleton<PostRepository>(PostRepositoryImpl(dataSource: GetIt.I()));

    GetIt.I.registerSingleton<UserRepository>(UserRepositoryImpl(dataSource: GetIt.I()));

    GetIt.I.registerSingleton<CommentRepository>(CommentRepositoryImpl(dataSource: GetIt.I()));

    GetIt.I.registerSingleton<RankingRepository>(RankingRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ));

    GetIt.I.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        remoteDataSource: GetIt.I(),
        remoteDataSourceForPolling: GetIt.I(
          instanceName: 'polling_api_datasource',
        ),
      ),
    );

    GetIt.I.registerSingleton<StockRepository>(StockRepositoryImpl(dataSource: GetIt.I()));

    GetIt.I.registerSingleton<HomeRepository>(HomeRepositoryImpl(dataSource: GetIt.I()));

    GetIt.I.registerSingleton<WebRepository>(WebRepositoryImpl(dataSource: GetIt.I()));

    GetIt.I.registerSingleton<CommonRepository>(CommonRepositoryImpl(dataSource: GetIt.I(), authService: GetIt.I()));
  }
}
