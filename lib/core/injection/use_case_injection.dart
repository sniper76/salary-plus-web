import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/repository/auth_repository.dart';
import 'package:act_web/domain/repository/comment_repository.dart';
import 'package:act_web/domain/repository/common_repository.dart';
import 'package:act_web/domain/repository/home_repository.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:act_web/domain/repository/ranking_repository.dart';
import 'package:act_web/domain/repository/stock_repository.dart';
import 'package:act_web/domain/repository/web_repository.dart';
import 'package:act_web/domain/usecase/comment/create_comment.dart';
import 'package:act_web/domain/usecase/comment/create_reply.dart';
import 'package:act_web/domain/usecase/comment/delete_comment.dart';
import 'package:act_web/domain/usecase/comment/get_comment_list.dart';
import 'package:act_web/domain/usecase/comment/get_reply_list.dart';
import 'package:act_web/domain/usecase/comment/like_comment.dart';
import 'package:act_web/domain/usecase/comment/report_comment.dart';
import 'package:act_web/domain/usecase/comment/unlike_comment.dart';
import 'package:act_web/domain/usecase/comment/update_comment.dart';
import 'package:act_web/domain/usecase/common/get_common_stocks.dart';
import 'package:act_web/domain/usecase/common/post_stock_search_trends.dart';
import 'package:act_web/domain/usecase/home/get_my_solidarity_list.dart';
import 'package:act_web/domain/usecase/home/update_my_solidarity_display_order.dart';
import 'package:act_web/domain/usecase/post/answer_on_post_poll.dart';
import 'package:act_web/domain/usecase/post/create_post.dart';
import 'package:act_web/domain/usecase/post/delete_post.dart';
import 'package:act_web/domain/usecase/post/get_board_group_categories.dart';
import 'package:act_web/domain/usecase/post/get_post_detail.dart';
import 'package:act_web/domain/usecase/post/get_post_list.dart';
import 'package:act_web/domain/usecase/post/get_post_list_previews.dart';
import 'package:act_web/domain/usecase/post/like_post.dart';
import 'package:act_web/domain/usecase/post/report_post.dart';
import 'package:act_web/domain/usecase/post/unlike_post.dart';
import 'package:act_web/domain/usecase/post/update_post.dart';
import 'package:act_web/domain/usecase/ranking/get_ranking_stock_list.dart';
import 'package:act_web/domain/usecase/stock/get_search_ranking_list.dart';
import 'package:act_web/domain/usecase/stock/get_stock_home.dart';
import 'package:act_web/domain/usecase/stock/update_solidarity_leader_message.dart';
import 'package:act_web/domain/usecase/auth/create_web_verification.dart';
import 'package:act_web/domain/usecase/auth/fetch_user_me.dart';
import 'package:act_web/domain/usecase/auth/verify_web_verification.dart';
import 'package:act_web/domain/usecase/user/block_user.dart';
import 'package:act_web/domain/usecase/user/get_anonymous_write_count.dart';
import 'package:act_web/domain/usecase/web/upload_image.dart';
import 'package:get_it/get_it.dart';

class UseCaseInjection {
  static inject() {
    // common
    GetIt.I.registerSingleton<GetCommonStocks>(GetCommonStocks(repository: GetIt.I<CommonRepository>()));
    GetIt.I.registerSingleton<PostStockSearchTrends>(PostStockSearchTrends(repository: GetIt.I<CommonRepository>()));

    // auth
    GetIt.I.registerSingleton<CreateWebVerification>(CreateWebVerification(repository: GetIt.I<AuthRepository>()));
    GetIt.I.registerSingleton<VerifyWebVerification>(VerifyWebVerification(repository: GetIt.I<AuthRepository>()));
    GetIt.I.registerSingleton<FetchUserMe>(
        FetchUserMe(repository: GetIt.I<AuthRepository>(), authService: GetIt.I<UserAuthService>()));

    // User
    GetIt.I.registerSingleton<GetAnonymousWriteCount>(GetAnonymousWriteCount(repository: GetIt.I()));
    GetIt.I.registerSingleton<BlockUser>(BlockUser(repository: GetIt.I()));

    // Post
    GetIt.I.registerSingleton<GetPostList>(GetPostList(repository: GetIt.I<PostRepository>()));
    GetIt.I.registerSingleton<GetPostListPreviews>(GetPostListPreviews(repository: GetIt.I<PostRepository>()));
    GetIt.I.registerSingleton<GetPostDetail>(GetPostDetail(repository: GetIt.I<PostRepository>()));
    GetIt.I.registerSingleton<CreatePost>(CreatePost(repository: GetIt.I()));
    GetIt.I.registerSingleton<UpdatePost>(UpdatePost(repository: GetIt.I()));
    GetIt.I.registerSingleton<DeletePost>(DeletePost(repository: GetIt.I()));
    GetIt.I.registerSingleton<ReportPost>(ReportPost(repository: GetIt.I()));
    GetIt.I.registerSingleton<LikePost>(LikePost(repository: GetIt.I()));
    GetIt.I.registerSingleton<UnlikePost>(UnlikePost(repository: GetIt.I()));
    GetIt.I.registerSingleton<AnswerOnPostPoll>(AnswerOnPostPoll(repository: GetIt.I()));
    GetIt.I.registerSingleton<GetBoardGroupCategories>(GetBoardGroupCategories(repository: GetIt.I()));

    // Comment
    GetIt.I.registerSingleton<GetCommentList>(GetCommentList(repository: GetIt.I<CommentRepository>()));
    GetIt.I.registerSingleton<GetReplyList>(GetReplyList(repository: GetIt.I<CommentRepository>()));
    GetIt.I.registerSingleton<CreateReply>(CreateReply(repository: GetIt.I<CommentRepository>()));
    GetIt.I.registerSingleton<CreateComment>(CreateComment(repository: GetIt.I()));
    GetIt.I.registerSingleton<UpdateComment>(UpdateComment(repository: GetIt.I()));
    GetIt.I.registerSingleton<LikeComment>(LikeComment(repository: GetIt.I()));
    GetIt.I.registerSingleton<UnlikeComment>(UnlikeComment(repository: GetIt.I()));
    GetIt.I.registerSingleton<ReportComment>(ReportComment(repository: GetIt.I()));
    GetIt.I.registerSingleton<DeleteComment>(DeleteComment(repository: GetIt.I()));

    // Ranking
    GetIt.I.registerSingleton<GetRankingStockList>(GetRankingStockList(repository: GetIt.I<RankingRepository>()));

    // stock
    GetIt.I.registerSingleton<GetSearchRankingList>(GetSearchRankingList(repository: GetIt.I<StockRepository>()));
    GetIt.I.registerSingleton<GetStockHome>(GetStockHome(repository: GetIt.I<StockRepository>()));
    GetIt.I.registerSingleton<UpdateSolidarityLeaderMessage>(
        UpdateSolidarityLeaderMessage(repository: GetIt.I<StockRepository>()));

    // Home
    GetIt.I.registerSingleton<GetMySolidarityList>(GetMySolidarityList(repository: GetIt.I<HomeRepository>()));
    GetIt.I.registerSingleton<UpdateMySolidarityDisplayOrder>(
        UpdateMySolidarityDisplayOrder(repository: GetIt.I<HomeRepository>()));

    // web
    GetIt.I.registerSingleton<UploadImage>(UploadImage(repository: GetIt.I<WebRepository>()));
  }
}
