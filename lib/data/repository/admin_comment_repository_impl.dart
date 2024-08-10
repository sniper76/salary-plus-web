import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/repository/admin_comment_repository.dart';
import 'package:multiple_result/src/result.dart';

class AdminCommentRepositoryImpl implements AdminCommentRepository {
  final ApiDataSource dataSource;

  const AdminCommentRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<Comment>>, Exception>> list({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    int page = 1,
    int size = 20,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<Comment>>>(dataSource.stockBoardAdminPostComments(
      stockCode,
      boardGroupType.value,
      postId,
      page,
      size,
      sorts,
    ));
  }

  @override
  Future<Result<DataResponse<List<Comment>>, Exception>> replies({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    int page = 1,
    int size = 20,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<Comment>>>(dataSource.getAdminPostCommentReplies(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
      page,
      size,
      sorts,
    ));
  }

  @override
  Future<Result<Comment, Exception>> updateStatus({
    required String stockCode,
    required String boardGroup,
    required int postId,
    required int commentId,
    required String status,
  }) async {
    final data = {
      'status': status,
    };
    final res = await safeCall<DataResponse<Comment>>(
        dataSource.updateAdminCommentStatus(stockCode, boardGroup, postId, commentId, data));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Comment, Exception>> create({
    required String stockCode,
    required String boardGroup,
    required int postId,
    required String content,
    required bool isAnonymous,
  }) async {
    final data = {
      'content': content,
      'isAnonymous': isAnonymous,
    };
    final res =
        await safeCall<DataResponse<Comment>>(dataSource.createAdminPostComment(stockCode, boardGroup, postId, data));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Comment, Exception>> edit({
    required String stockCode,
    required String boardGroup,
    required int postId,
    required int commentId,
    required String content,
  }) async {
    final data = {
      'content': content,
    };
    final res = await safeCall<DataResponse<Comment>>(
        dataSource.editAdminPostComment(stockCode, boardGroup, postId, commentId, data));
    final Comment? updatedComment = res.tryGetSuccess()?.data;
    return (res.isSuccess() && updatedComment != null)
        ? Result.success(updatedComment)
        : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Comment, Exception>> createReplies({
    required String stockCode,
    required String boardGroup,
    required int postId,
    required int commentId,
    required String content,
    required bool isAnonymous,
  }) async {
    final data = {
      'content': content,
      'isAnonymous': isAnonymous,
    };
    final res = await safeCall<DataResponse<Comment>>(
        dataSource.createAdminPostCommentReplies(stockCode, boardGroup, postId, commentId, data));
    final user = res.tryGetSuccess()?.data;
    return (res.isSuccess() && user != null) ? Result.success(user) : Result.error(res.tryGetError()!);
  }
}
