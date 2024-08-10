import 'dart:io';

import 'package:act_cms/data/datasource/remote/api_request_dio_factory.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/data/response/mydata_token_response.dart';
import 'package:act_cms/domain/model/anonymous_write_count.dart';
import 'package:act_cms/domain/model/auth_result.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/campaign.dart';
import 'package:act_cms/domain/model/can_use.dart';
import 'package:act_cms/domain/model/cms_commons.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/dashboard_age_statistics.dart';
import 'package:act_cms/domain/model/dashboard_gender_statistics.dart';
import 'package:act_cms/domain/model/dashboard_statistics.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/domain/model/digital_proxy_url.dart';
import 'package:act_cms/domain/model/group_push.dart';
import 'package:act_cms/domain/model/home.dart';
import 'package:act_cms/domain/model/individual_push.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/profile_default_image.dart';
import 'package:act_cms/domain/model/report_detail.dart';
import 'package:act_cms/domain/model/report_list.dart';
import 'package:act_cms/domain/model/solidarity.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_application.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/domain/model/stock_group_detail.dart';
import 'package:act_cms/domain/model/stock_home.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/model/stock_summary.dart';
import 'package:act_cms/domain/model/stop_word.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/user_profile.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:act_cms/domain/model/verify_auth.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'api_datasource.g.dart';

@RestApi()
abstract class ApiDataSource {
  factory ApiDataSource(ApiRequestDioFactory apiRequestDioFactory) {
    final dio = apiRequestDioFactory.get;

    return _ApiDataSource(dio);
  }

  @POST('/sms/send-auth-request')
  Future<AuthResult> sendAuthRequest(
    @Field() String name,
    @Field() String birthDate,
    @Field() String gender,
    @Field() String provider,
    @Field() String phoneNumber,
  );

  @POST('/sms/resend-auth-request')
  Future<AuthResult> reSendAuthRequest(
    @Field() String txSeqNo,
    @Field() String phoneNumber,
  );

  @POST('/sms/verify-auth-code')
  Future<VerifyAuth> verifyAuthCode(
    @Field() String name,
    @Field() String birthDate,
    @Field() String gender,
    @Field() String provider,
    @Field() String phoneNumber,
    @Field() String code,
    @Field() String? txSeqNo,
  );

  @POST('/auth/register-pin-number')
  Future<User> registerPinNumber(
    @Field() String pinNumber,
  );

  @POST('/auth/verify-pin-number')
  Future<User> verifyPinNumber(
    @Field() String pinNumber,
  );

  @POST('/auth/reset-pin-number')
  Future<void> resetPinNumber();

  @POST('/auth/register-user-info')
  Future<User> registerUserInfo(
    @Field() String email,
    @Field() String nickname,
    @Field() bool isAgreeToReceiveMail,
  );

  @POST('/auth/check-email')
  Future<DataResponse<CanUse>> checkEmail(
    @Field() String email,
  );

  @POST('/auth/check-nickname')
  Future<DataResponse<CanUse>> checkNickname(
    @Field() String nickname,
  );

  @POST('/auth/mydata-token-request')
  Future<MyDataTokenResponse> requestMyDataToken();

  @POST('/auth/logout')
  Future<void> logout();

  @GET('/users/me')
  Future<DataResponse<User>> userMe();

  @PATCH('/users/me')
  Future<DataResponse<User>> updateUserMe(@Body() Map<String, dynamic> data);

  @PATCH('/users/my-address')
  Future<DataResponse<User>> updateUserAddress(@Body() Map<String, dynamic> data);

  @GET('/users/{userId}/profile')
  Future<DataResponse<UserProfile>> profile(
    @Path() int userId,
    @Query('stockCode') String? stockCode,
  );

  @POST('/users/mydata')
  Future<void> uploadMyData(@Body() Map<String, dynamic> data);

  @POST('/users/withdrawal')
  Future<void> withdrawal();

  @PATCH('/users/push-token')
  Future<void> updatePushToken(@Body() Map<String, dynamic> data);

  @PATCH('/users/nickname')
  Future<void> updateNickname(@Body() Map<String, dynamic> data);

  @PATCH('/users/my-profile-image')
  Future<void> updateProfileImage(@Body() Map<String, dynamic> data);

  @GET('/users/anonymousCount')
  Future<DataResponse<AnonymousWriteCount>> anonymousWriteCount();

  @GET('/users/digital-document/{digitalDocumentId}/download-document')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadDigitalDocumentPdf(
    @Path() int digitalDocumentId,
  );

  @PATCH('/users/digital-document/{digitalDocumentId}')
  Future<void> completeDigitalDocument(
    @Path() int digitalDocumentId,
  );

  @POST('/users/digital-document/{digitalDocumentId}')
  @MultiPart()
  Future<void> saveDigitalDocument(
    @Path() int digitalDocumentId,
    @Part(name: 'signImage', fileName: 'user_sign.jpg', contentType: 'image/jpeg') File signImage,
    @Part(name: 'idCardImage', fileName: 'user_id_card.jpg', contentType: 'image/jpeg') File idCardImage,
    @Part(name: 'bankAccountImages', contentType: 'image/jpeg') List<File>? bankAccountImages,
    @Part(name: 'answerData') String answerData,
  );

  @POST('/users/digital-document/{digitalDocumentId}')
  @MultiPart()
  Future<void> saveDigitalDocumentEtc(
    @Path() int digitalDocumentId,
    @Part(name: 'signImage', fileName: 'user_sign.jpg', contentType: 'image/jpeg') File signImage,
  );

  @DELETE('/users/digital-document/{digitalDocumentId}')
  Future<void> deleteDigitalDocument(
    @Path() int digitalDocumentId,
  );

  @GET('/admin/users/{userId}/download-document/solidarity-leader-confidential-agreement')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadConfidential(
    @Path('userId') int userId,
  );

  @GET('/home')
  Future<Home> home();

  @GET('/home/my-solidarity')
  Future<DataResponse<List<Solidarity>>> mySolidarity();

  @PATCH('/home/my-solidarity')
  Future<DataResponse<List<Solidarity>>> updateSolidarity(
    @Body() Map<String, dynamic> data,
  );

  @GET('/stocks/{stockCode}/home')
  Future<StockHome> stockHome(
    @Path() String stockCode,
  );

  @GET('/stocks/{stockCode}/solidarity')
  Future<DataResponse<Solidarity>> getSolidarity(
    @Path() String stockCode,
  );

  @POST('/stocks/{stockCode}/solidarity/apply-leader')
  Future<void> enrollStockLeader(
    @Path() String stockCode,
  );

  @DELETE('/stocks/{stockCode}/solidarity/apply-leader')
  Future<void> cancelEnrollStockLeader(
    @Path() String stockCode,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/categories')
  Future<DataResponse<List<BoardGroupCategory>>> stockBoardGroupCategories(
    @Path() String stockCode,
    @Path() String boardGroup,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts')
  Future<DataResponse<List<Post>>> stockBoardPosts(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Query('boardCategory') String? boardCategory,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}')
  Future<DataResponse<Post>> stockBoardPostDetail(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts')
  Future<DataResponse<Post>> createBoardPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Body() Map<String, dynamic> data,
  );

  @PATCH('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}')
  Future<DataResponse<Post>> updateBoardPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}')
  Future<void> deleteBoardPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/reports')
  Future<void> reportBoardPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/likes')
  Future<void> likeBoardPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/likes')
  Future<void> unlikeBoardPost(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments')
  Future<DataResponse<List<Comment>>> stockBoardPostComments(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments')
  Future<DataResponse<Comment>> createStockBoardPostComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @PUT('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}')
  Future<DataResponse<Comment>> updateStockBoardPostComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}')
  Future<void> deleteStockBoardPostComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/likes')
  Future<void> likeStockBoardPostComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/reports')
  Future<void> reportStockBoardPostComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/likes')
  Future<void> unlikeStockBoardPostComment(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
  );

  @GET('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/replies')
  Future<DataResponse<List<Comment>>> stockBoardPostCommentReplies(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/replies')
  Future<DataResponse<Comment>> createStockBoardPostCommentReply(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/polls/{pollId}/answers')
  Future<void> answerStockBoardPostPoll(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int pollId,
    @Body() Map<String, dynamic> data,
  );

  @PUT('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/polls/{pollId}/answers')
  Future<void> answerUpdateStockBoardPostPoll(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int pollId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/digital-proxy')
  Future<DigitalProxyUrl> getStockBoarDigitalProxyEmbeddedUrl(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
  );

  @GET(
      '/admin/stocks/{stockCode}/solidarity-leader-elections/{solidarityLeaderElectionId}/solidarity-leader-applicants/{solidarityLeaderApplicantId}')
  Future<SolidarityLeaderElectionApplication> getSolidarityLeaderElectionApplcation(
    @Path() String stockCode,
    @Path() int solidarityLeaderElectionId,
    @Path() int solidarityLeaderApplicantId,
  );

  // 기타
  @POST('/images')
  @MultiPart()
  Future<DataResponse<UploadImageFile>> uploadImage(
    @Part(name: 'file', fileName: 'user_profile.jpg', contentType: 'image/jpeg') File file,
  );

  @GET('/images/default-profile-images')
  Future<DataResponse<List<ProfileDefaultImage>>> defaultProfileImages();

  @GET('/health')
  Future<void> health();

  @PATCH('/admin/solidarity-leaders/{solidarityId}/message')
  Future<void> updateAdminSolidarityLeaderComment(
      @Path('solidarityId') int solidarityId, @Body() Map<String, dynamic> data);

  @POST('/admin/solidarity-leaders/{solidarityId}')
  Future<void> setAdminSolidarityLeader(
    @Path('solidarityId') int solidarityId,
    @Body() Map<String, dynamic> data,
  );

  @POST('/admin/solidarity-leaders/{solidarityId}/corporate-user')
  Future<void> setAdminSolidarityCorporationLeader(
    @Path('solidarityId') int solidarityId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/admin/corporate-users/{corporationId}')
  Future<void> deleteCorporation(
    @Path() int corporationId,
  );

  @POST('/admin/stocks/{stockCode}/solidarity-leader-applicants/{solidarityLeaderApplicantId}/withdraw')
  Future<void> withdrawSolidarityLeaderApplicant(
    @Path('stockCode') String stockCode,
    @Path('solidarityLeaderApplicantId') int solidarityLeaderApplicantId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/admin/solidarity-leaders/{solidarityId}')
  Future<void> unsetAdminSolidarityLeader(
    @Path('solidarityId') int solidarityId,
    @Body() Map<String, dynamic> data,
  );

  @PATCH('/admin/solidarity/{solidarityId}/active')
  Future<DataResponse<Solidarity>> setAdminSolidarityActive(
    @Path('solidarityId') int solidarityId,
  );

  @GET('/admin/stock-groups')
  Future<DataResponse<List<StockGroup>>> getAdminStockGroups(@Query('stockGroupId') int? stockGroupId,
      @Query('page') int? page, @Query('size') int? size, @Query('sorts') String? sorts);

  @POST('/admin/stock-groups')
  Future<DataResponse<StockGroup>> createAdminStockGroup(@Body() Map<String, dynamic> data);

  @POST('/admin/corporate-users')
  Future<DataResponse<CorporationUser>> createCorporation(@Body() Map<String, dynamic> data);

  @PATCH('/admin/corporate-users/{corporateId}')
  Future<DataResponse<CorporationUser>> updateCorporation(
      @Body() Map<String, dynamic> data, @Path('corporateId') int corporateId);

  @GET('/admin/users')
  Future<DataResponse<List<User>>> getAdminUsers(
    @Query('searchType') String? searchType,
    @Query('searchKeyword') String? searchKeyword,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sorts') String? sorts,
    @Query('filterType') String? filterType,
  );

  @GET('/admin/corporate-users')
  Future<DataResponse<List<CorporationUser>>> getAdminCorporation(
    @Query('searchType') String? searchType,
    @Query('searchKeyword') String? searchKeyword,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sorts') String? sorts,
  );

  @GET('/admin/users/{userId}')
  Future<DataResponse<User>> getAdminDetail(@Path('userId') int userId);

  @PATCH('/admin/users/{userId}/add-role')
  Future<DataResponse<User>> addAdminUserRole(@Path('userId') int userId, @Body() Map<String, dynamic> data);

  @PATCH('/admin/users/{userId}/nickname')
  Future<DataResponse<User>> updateAdminUserNickname(@Path('userId') int userId, @Body() Map<String, dynamic> data);

  @POST('/admin/users/{userId}/assign-admin')
  Future<DataResponse<User>> assignAdminUserAdmin(
    @Path('userId') int userId,
  );

  @POST('/admin/users/{userId}/revoke-admin')
  Future<DataResponse<User>> assignAdminRevokeAdminUser(
    @Path('userId') int userId,
  );

  @GET('/admin/users/{userId}/stocks')
  Future<DataResponse<List<UserStockData>>> getAdminUserStocks(
      @Path('userId') int userId, @Query('page') int? page, @Query('size') int? size, @Query('sorts') String? sorts);

  @GET('/admin/users/{userId}/dummy-stock')
  Future<DataResponse<List<UserStockData>>> getAdminUserDummyStocks(
      @Path('userId') int userId, @Query('page') int? page, @Query('size') int? size, @Query('sorts') String? sorts);

  @GET('/admin/stock-groups/auto-complete')
  Future<DataResponse<List<StockGroup>>> getAdminStockGroupsAutoCompete(@Query('searchKeyword') String? searchKeyword);

  @GET("/admin/stock-groups/{stockGroupId}")
  Future<DataResponse<StockGroupDetail>> getAdminStockGroupDetail(@Path('stockGroupId') int stockGroupId);

  @PUT("/admin/stock-groups/{stockGroupId}")
  Future<DataResponse<StockGroup>> updateAdminStockGroupDetail(
    @Path('stockGroupId') int stockGroupId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE("/admin/stock-groups/{stockGroupId}")
  Future<DataResponse<StockGroup>> deleteAdminStockGroup(
    @Path('stockGroupId') int stockGroupId,
  );

  @GET("/admin/stocks")
  Future<DataResponse<List<Stock>>> getAdminStock(
    @Query('code') String? code,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sorts') String? sorts,
  );

  @GET("/admin/stocks/{code}")
  Future<DataResponse<StockDetail>> getAdminStockDetail(@Path('code') String code);

  @GET("/admin/stocks/{code}/statistics/{type}/{periodType}")
  Future<DataResponse<List<StockSummary>>> getAdminStockStatistics(@Path('code') String code, @Path('type') String type,
      @Path('periodType') String periodType, @Query('period') String period);

  @GET("/admin/stocks/auto-complete")
  Future<DataResponse<List<Stock>>> getAdminStockAutoComplete(@Query('searchKeyword') String? searchKeyword);

  @POST("/admin/stocks/{stockCode}/reference-dates")
  Future<DataResponse<StockReferenceDate>> createAdminStockReferenceDates(
      @Path() String stockCode, @Body() Map<String, dynamic> data);

  @GET("/admin/stocks/{stockCode}/reference-dates")
  Future<DataResponse<List<StockReferenceDate>>> getAdminStockReferenceDates(@Path() String stockCode);

  @PATCH("/admin/stocks/{stockCode}/reference-dates/{referenceDateId}")
  Future<DataResponse<StockReferenceDate>> updateAdminStockReferenceDates(@Path("stockCode") String stockCode,
      @Path("referenceDateId") int referenceDateId, @Body() Map<String, String?> data);

  @DELETE("/admin/stocks/{stockCode}/reference-dates/{referenceDateId}")
  Future<DataResponse<StockReferenceDate>> deleteAdminStockReferenceDates(
      @Path("stockCode") String stockCode, @Path("referenceDateId") int referenceDateId);

  @POST('/admin/stocks/{stockCode}/users/csv-download')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadAdminStockCsv(@Path("stockCode") String stockCode);

  @POST('/admin/users/{userId}/dummy-stock')
  Future<void> addDummyStock(@Path("userId") int userId, @Body() Map<String, dynamic> data);

  @DELETE('/admin/users/{userId}/dummy-stock')
  Future<void> deleteDummyStock(@Path("userId") int userId, @Body() Map<String, dynamic> data);

  @GET('/admin/digital-document/{digitalDocumentId}/users')
  Future<DataResponse<List<DigitalDocumentUser>>> getAdminDigitalDocumentUsers(
      @Path("digitalDocumentId") int digitalDocumentId,
      @Query("searchType") String? searchType,
      @Query("searchKeyword") String? searchKeyword,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sorts") String? sorts);

  @GET('/admin/users/{userId}/digital-document/{digitalDocumentId}/download-document')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadAdminUserDigitalDocumentPdf(
    @Path() int userId,
    @Path() int digitalDocumentId,
  );

  @POST('/admin/digital-document/preview')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getAdminDocumentPreview(
    @Body() Map<String, dynamic> data,
  );

  @DELETE("/admin/digital-document/{digitalDocumentId}")
  Future<void> deleteAdminDigitalDocument(@Path("digitalDocumentId") digitalDocumentId);

  @POST("/admin/digital-document/{digitalDocumentId}/zip-file-request")
  Future<void> createAdminDigitalDocumentZipFile(
    @Path("digitalDocumentId") int digitalDocumentId,
    @Query("isSecured") bool isSecured,
  );

  @POST("/admin/digital-document/{digitalDocumentId}/csv-download")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadAdminDigitalDocumentCsv(@Path("digitalDocumentId") int digitalDocumentId);

  @DELETE("/admin/users/mydata/withdraw/{finpongAccessToken}")
  Future<void> withdrawAdminUserService(@Path("finpongAccessToken") String finpongAccessToken);

  @POST("/admin/auth/login")
  Future<VerifyAuth> loginAdmin(@Body() Map<String, dynamic> data);

  @POST("/admin/auth/change-password")
  Future<DataResponse<User>> changeAdminPassword(@Body() Map<String, dynamic> data);

  @GET("/admin/board-groups/{boardGroup}/posts")
  Future<DataResponse<List<Post>>> getAdminPosts(
    @Path("boardGroup") String boardGroup,
    @Query("boardCategory") String? boardCategory,
    @Query("searchType") String? searchType,
    @Query("searchKeyword") String? searchKeyword,
    @Query("status") String? status,
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("sorts") String? sorts,
    @Query("searchStartDate") String? searchStartDate,
    @Query("searchEndDate") String? searchEndDate,
  );

  @POST('/admin/stocks/{stockCode}/board-groups/{boardGroupName}/posts')
  Future<DataResponse<Post>> createAdminBoardPost(
    @Path() String stockCode,
    @Path() String boardGroupName,
    @Body() Map<String, dynamic> data,
  );

  @GET("/admin/stocks/{stockCode}/board-groups/{boardGroupName}/posts/{postId}")
  Future<DataResponse<Post>> getAdminPostDetail(
    @Path("stockCode") String stockCode,
    @Path("boardGroupName") String? boardGroupName,
    @Path("postId") int? postId,
  );

  @DELETE('/admin/stocks/{stockCode}/board-groups/{boardGroupName}/posts/{postId}')
  Future<void> deleteAdminBoardPost(
    @Path() String stockCode,
    @Path() String boardGroupName,
    @Path() int postId,
  );

  @PATCH('/admin/stocks/{stockCode}/board-groups/{boardGroupName}/posts/{postId}')
  Future<DataResponse<Post>> updateAdminBoardPost(
    @Path() String stockCode,
    @Path() String boardGroupName,
    @Path() int postId,
    @Body() Map<String, dynamic> data,
  );

  @POST("/admin/posts/{postId}/stock-groups/{stockGroupId}/duplicate")
  Future<void> duplicateAdminPosts(@Path("postId") postId, @Path("stockGroupId") int stockGroupId);

  @POST("/admin/posts/{postId}/duplicate")
  Future<DataResponse<Post>> duplicateAdimnStockGroup(
    @Path("postId") postId,
    @Body() Map<String, dynamic> data,
  );

  @GET("/admin/{reportType}/reports")
  Future<DataResponse<List<ReportList>>> getAdminReports(
      @Path("reportType") String reportType,
      @Query("reportStatus") String? reportStatus,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sorts") String? sorts);

  @GET("/admin/{reportType}/reports/{reportId}")
  Future<ReportDetail> getAdminReportDetail(@Path("reportType") String reportType, @Path("reportId") int reportId);

  @PATCH("/admin/{reportType}/reports/{reportId}")
  Future<ReportDetail> updateAdminReportStatus(
      @Path("reportType") String reportType, @Path("reportId") int reportId, @Body() Map<String, dynamic> data);

  @GET("/admin/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments")
  Future<DataResponse<List<Comment>>> stockBoardAdminPostComments(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @POST("/admin/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments")
  Future<DataResponse<Comment>> createAdminPostComment(
    @Path("stockCode") String stockCode,
    @Path("boardGroup") String boardGroup,
    @Path("postId") int postId,
    @Body() Map<String, dynamic> data,
  );

  @PATCH("/admin/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}")
  Future<DataResponse<Comment>> editAdminPostComment(
    @Path("stockCode") String stockCode,
    @Path("boardGroup") String boardGroup,
    @Path("postId") int postId,
    @Path("commentId") int commentId,
    @Body() Map<String, dynamic> data,
  );

  @GET("/admin/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/replies")
  Future<DataResponse<List<Comment>>> getAdminPostCommentReplies(
    @Path() String stockCode,
    @Path() String boardGroup,
    @Path() int postId,
    @Path() int commentId,
    @Query('page') int page,
    @Query('size') int size,
    @Query('sorts') String? sorts,
  );

  @POST("/admin/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/replies")
  Future<DataResponse<Comment>> createAdminPostCommentReplies(
    @Path("stockCode") String stockCode,
    @Path("boardGroup") String boardGroup,
    @Path("postId") int postId,
    @Path("commentId") int commentId,
    @Body() Map<String, dynamic> data,
  );

  @PATCH("/admin/stocks/{stockCode}/board-groups/{boardGroup}/posts/{postId}/comments/{commentId}/status")
  Future<DataResponse<Comment>> updateAdminCommentStatus(
      @Path("stockCode") String stockCode,
      @Path("boardGroup") String boardGroup,
      @Path("postId") int postId,
      @Path("commentId") int commentId,
      @Body() Map<String, dynamic> data);

  @GET("/admin/cms-commons")
  Future<DataResponse<CMSCommons>> getAdminCMSCommons();

  @GET("/admin/pushes")
  Future<DataResponse<List<GroupPush>>> getAdminPushes(
      @Query("searchType") String? searchType,
      @Query("searchKeyword") String? searchKeyword,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sorts") String? sorts);

  @GET("/admin/automated-pushes")
  Future<DataResponse<List<IndividualPush>>> getAdminIndividualPushes(
    @Query("searchType") String? searchType,
    @Query("searchKeyword") String? searchKeyword,
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("sorts") String? sorts,
  );

  @POST("/admin/pushes")
  Future<DataResponse<GroupPush>> createAdminPush(@Body() Map<String, dynamic> data);

  @DELETE("/admin/pushes/{pushId}")
  Future<void> deleteAdminPush(@Path("pushId") int pushId);

  @GET("/admin/popups")
  Future<DataResponse<List<Popup>>> getAdminPopups(
      @Query("searchType") String? searchType,
      @Query("searchKeyword") String? searchKeyword,
      @Query('popupStatus') String? popupStatus,
      @Query("page") int? page,
      @Query("size") int? size,
      @Query("sorts") String? sorts);

  @GET("/admin/popups/{popupId}")
  Future<DataResponse<Popup>> getAdminPopup(
    @Path("popupId") int popupId,
  );

  @POST("/admin/popups")
  Future<DataResponse<Popup>> createAdminPopup(@Body() Map<String, dynamic> data);

  @PATCH("/admin/popups/{popupId}")
  Future<DataResponse<Popup>> updateAdminPopup(
    @Path("popupId") int popupId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE("/admin/popups/{popupId}")
  Future<void> deleteAdminPopup(
    @Path("popupId") int popupId,
  );

  // 기타
  @POST('/admin/images/{fileContentType}')
  @MultiPart()
  Future<DataResponse<UploadImageFile>> uploadAdminImages(
    @Path("fileContentType") String fileContentType,
    @Part(name: 'file', fileName: 'user_profile.jpg', contentType: 'image/jpeg') List<int> file,
    @Part(name: 'description') String? description,
  );

  @GET("/admin/dashboard/statistics")
  Future<DataResponse<List<DashboardStatistics>>> getAdminStatistics(
    @Query("type") String? type,
    @Query("stockCode") String? stockCode,
    @Query("periodType") String? periodType,
    @Query("searchFrom") String? searchFrom,
    @Query("searchTo") String? searchTo,
  );

  @GET("/admin/dashboard/statistics/gender")
  Future<DataResponse<DashboardGenderStatistics>> getAdminGenderStatistics(
    @Query("periodType") String? periodType,
    @Query("searchFrom") String? searchFrom,
    @Query("searchTo") String? searchTo,
  );

  @GET("/admin/dashboard/statistics/age")
  Future<DataResponse<DashboardAgeStatistics>> getAdminAgeStatistics(
    @Query("periodType") String? periodType,
    @Query("searchFrom") String? searchFrom,
    @Query("searchTo") String? searchTo,
  );

  @PATCH("/admin/digital-document/{digitalDocumentId}/reference-dates/{referenceDateId}")
  Future<DataResponse<StockReferenceDate>> updateAdminDigitalDocumentReferenceDate(
      @Path("digitalDocumentId") int? digitalDocumentId,
      @Path("referenceDateId") int? referenceDateId,
      @Body() Map<String, dynamic> data);

  @GET('/admin/campaigns')
  Future<DataResponse<List<Campaign>>> getCampaigns(
    @Query('searchKeyword') String? searchKeyword,
    @Query('searchType') String? searchType,
    @Query('boardCategory') String? boardCategory,
    @Query('page') int? page,
    @Query('size') int? size,
    @Query('sorts') String? sorts,
  );

  @GET('/admin/campaigns/{campaignId}')
  Future<DataResponse<Campaign>> getCampaignDetail(@Path('campaignId') int campaignId);

  @POST('/admin/campaigns')
  Future<void> postCampaign(
    @Body() Map<String, dynamic> data,
  );

  @PATCH('/admin/campaigns/{campaignId}')
  Future<DataResponse<Campaign>> updateCampaign(
    @Path() int campaignId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/admin/campaigns/{campaignId}')
  Future<void> deleteCampaign(@Path() int campaignId);

  @POST('/admin/campaigns/{campaignId}/zip-file-request')
  Future<void> requestZipFile(
    @Path() int campaignId,
    @Query("isSecured") bool isSecured,
  );

  @POST('/admin/campaigns/{campaignId}/csv-download')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadDigitalDocs(@Path() int campaignId);

  @GET('/admin/acceptors/digital-document/{digitalDocumentType}')
  Future<DataResponse<List<Post>>> getAcceptorDigitalDocsList(
    @Path("digitalDocumentType") String digitalDocumentType,
    @Query("searchType") String? searchType,
    @Query("searchKeyword") String? searchKeyword,
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("sorts") String? sorts,
  );

  @POST('/admin/stocks/{code}/acceptor-users')
  Future<void> assignAcceptUser(
    @Path("code") String code,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/admin/stocks/{code}/acceptor-users')
  Future<void> fireAcceptUser(
    @Path("code") String code,
    @Body() Map<String, dynamic> data,
  );

  @GET('/admin/stop-words')
  Future<DataResponse<List<StopWord>>> getStopWords(
    @Query("page") int? page,
    @Query("size") int? size,
    @Query("sorts") String? sorts,
    @Query("filterType") String? filterType,
    @Query("searchKeyword") String? searchKeyword,
  );

  @POST('/admin/stop-words')
  Future<void> createStopWords(
    @Body() Map<String, dynamic> data,
  );

  @POST('/admin/stop-words/{stopWordId}')
  Future<void> changeStopWordStatus(
    @Path("stopWordId") int stopWordId,
    @Body() Map<String, dynamic> data,
  );

  @DELETE('/admin/stop-words/{stopWordId}')
  Future<void> deleteStopWords(
    @Path("stopWordId") int stopWordId,
  );
}
