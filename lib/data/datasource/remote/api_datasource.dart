import 'dart:io';

import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/model/ranking/ranking_stock.dart';
import 'package:act_web/domain/model/ranking/search_ranking.dart';
import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/domain/model/stock_home/stock_home.dart';
import 'package:act_web/domain/model/user/anonymous_write_count.dart';
import 'package:act_web/domain/model/user/succeeded_web_verification.dart';
import 'package:act_web/domain/model/user/user.dart';
import 'package:act_web/domain/model/user/web_verification.dart';
import 'package:http_parser/http_parser.dart';
import 'package:act_web/data/datasource/remote/api_request_dio_factory.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/document/digital_proxy_url.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_datasource.g.dart';

@RestApi()
abstract class ApiDataSource {
  factory ApiDataSource(ApiRequestDioFactory apiRequestDioFactory, Dio dio) {
    return _ApiDataSource(dio);
  }

  //commonStocks
  @GET('/commons/stocks')
  Future<DataResponse<List<BaseStock>>> getCommonStocks();

  @POST('/stock-search-trends')
  Future<void> postStockSearchTrend(
    @Field() String stockCode,
  );

  @POST('/images')
  Future<DataResponse<UploadImageFile>> uploadImage(
    @Header('Content-Type') String contentType,
    @Body() FormData file,
  );

  // Auth
  @POST('/auth/web/generate-verification-code')
  Future<WebVerification> createWebVerification(
    @Body() Map<String, dynamic> data,
  );

  @POST('/auth/web/verify-verification-code')
  Future<SucceededWebVerification> verifyWebVerification(
    @Body() Map<String, dynamic> data,
  );

  @GET('/users/me')
  Future<DataResponse<User>> fetchUserMe();

  // User
  @GET('/users/anonymousCount')
  Future<DataResponse<AnonymousWriteCount>> getAnonymousWriteCount();

  @POST('/users/me/blocked-users')
  Future<void> blockUser(@Body() Map<String, dynamic> data);

  // Post
  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts')
  Future<DataResponse<List<Post>>> getPostList(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Query('boardCategory') String? boardCategory,
    @Query('boardCategories') String? boardCategories,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
    @Query('isExclusiveToHolders') bool? isExclusiveToHolders,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/previews')
  Future<DataResponse<List<Post>>> getPostListPreviews(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Query('boardCategory') String? boardCategory,
    @Query('boardCategories') String? boardCategories,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}')
  Future<DataResponse<Post>> getPostDetail(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts')
  Future<DataResponse<Post>> createPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Body() Map<String, dynamic> data,
  );

  @PATCH('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}')
  Future<DataResponse<Post>> updatePost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}')
  Future<void> deletePost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/reports')
  Future<void> reportPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/likes')
  Future<DataResponse<Post>> likePost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/likes')
  Future<DataResponse<Post>> unlikePost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/polls/{pollId}/answers')
  Future<void> createAnswerOnPostPoll(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int pollId,
    @Body() Map<String, dynamic> data,
  );

  @PUT('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/polls/{pollId}/answers')
  Future<void> updateAnswerOnPostPoll(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int pollId,
    @Body() Map<String, dynamic> data,
  );

  // Comment
  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments')
  Future<DataResponse<List<Comment>>> getCommentList(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments')
  Future<DataResponse<Comment>> createComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @PUT('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}')
  Future<DataResponse<Comment>> updateComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}')
  Future<void> deleteComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/likes')
  Future<void> likeComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/reports')
  Future<void> reportComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/likes')
  Future<void> unlikeComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/replies')
  Future<DataResponse<List<Comment>>> getReplyList(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/replies')
  Future<DataResponse<Comment>> createReply(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Body() Map<String, dynamic> data,
  );

  //Digital-proxy
  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/digital-proxy')
  Future<DigitalProxyUrl> getPostDigitalProxyEmbeddedUrl(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroupName}/posts/holder-list-read-and-copy')
  @MultiPart()
  Future<DataResponse<Post>> saveHolderListReadAndCopyPost(
    @Path() String stockCode,
    @Path() String boardGroupName,
    @Part(name: 'createPostRequest') String? createPostRequest,
    @Part(name: 'signImage', fileName: 'user_sign.jpg', contentType: 'image/jpeg') File signImage,
    @Part(name: 'idCardImage', fileName: 'user_id_card.jpg', contentType: 'image/jpeg') List<File>? idCardImage,
    @Part(name: 'bankAccountImages', contentType: 'image/jpeg') List<File>? bankAccountImages,
    @Part(name: 'hectoEncryptedBankAccountPdf', contentType: 'text/plain') List<File>? hectoEncryptedBankAccountPdf,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/categories')
  Future<DataResponse<List<BoardGroupCategory>>> getBoardGroupCategories(
    @Path() String stockCode,
    @Path() String boardGroup,
  );
  // Ranking
  @GET('/stock-rankings')
  Future<DataResponse<List<RankingStock>>> getRankingStockList(
    @Query('sorts') String sorts,
    @Query('size') int size,
  );

  // Stock
  @GET('/stocks/search-recommendations')
  Future<DataResponse<List<SearchRanking>>> getSearchRankingList();

  @GET('/stocks/{stockCode}/home')
  Future<StockHome> getStockHome(
    @Path() String stockCode,
  );

  @PATCH('/stocks/{stockCode}/solidarity/{solidarityId}/leader/message')
  Future<void> updateSolidarityLeaderMessage(
    @Path('stockCode') String stockCode,
    @Path('solidarityId') int solidarityId,
    @Body() Map<String, dynamic> data,
  );

  // Home
  @GET('/home/my-solidarity')
  Future<DataResponse<List<Solidarity>>> getPagedMySolidarityList(
    @Query('page') int page,
    @Query('size') int size,
  );

  @GET('/home/my-solidarity')
  Future<DataResponse<List<Solidarity>>> getWholeMySolidarityList(
    @Query('page') int page,
  );

  @PATCH('/home/my-solidarity')
  Future<DataResponse<List<Solidarity>>> updateMySolidarityDisplayOrder(
    @Body() Map<String, dynamic> data,
  );
}
