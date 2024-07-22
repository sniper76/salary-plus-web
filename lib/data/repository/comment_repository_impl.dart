import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/repository/comment_repository.dart';

import 'package:multiple_result/multiple_result.dart';

class CommentRepositoryImpl implements CommentRepository {
  final ApiDataSource dataSource;
  const CommentRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<Comment>>, Exception>> getCommentList({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    int page = 1,
    int size = 10,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<Comment>>>(dataSource.getCommentList(
      stockCode,
      boardGroupType.value,
      postId,
      page,
      size,
      sorts,
    ));
  }

  @override
  Future<Result<Comment, Exception>> createComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required String content,
    bool isAnonymous = false,
  }) async {
    final data = {
      'content': content,
      'isAnonymous': isAnonymous,
    };
    final res = await safeCall<DataResponse<Comment>>(dataSource.createComment(
      stockCode,
      boardGroupType.value,
      postId,
      data,
    ));
    final comment = res.tryGetSuccess()?.data;
    return (res.isSuccess() && comment != null) ? Result.success(comment) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Comment, Exception>> updateComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String content,
    bool isAnonymous = false,
  }) async {
    final data = {
      'content': content,
      'isAnonymous': isAnonymous,
    };
    final res = await safeCall<DataResponse<Comment>>(dataSource.updateComment(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
      data,
    ));
    final comment = res.tryGetSuccess()?.data;
    return (res.isSuccess() && comment != null) ? Result.success(comment) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> likeComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  }) {
    return safeCall<void>(dataSource.likeComment(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
    ));
  }

  @override
  Future<Result<void, Exception>> unlikeComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  }) {
    return safeCall<void>(dataSource.unlikeComment(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
    ));
  }

  @override
  Future<Result<void, Exception>> reportComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String reason,
  }) {
    final data = {
      'reason': reason,
    };
    return safeCall<void>(dataSource.reportComment(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
      data,
    ));
  }

  @override
  Future<Result<void, Exception>> deleteComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  }) {
    return safeCall<void>(dataSource.deleteComment(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
    ));
  }

  @override
  Future<Result<DataResponse<List<Comment>>, Exception>> getReplyList({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    int page = 1,
    int size = 10,
    String? sorts,
  }) {
    return safeCall<DataResponse<List<Comment>>>(dataSource.getReplyList(
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
  Future<Result<Comment, Exception>> createReply({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String content,
    bool isAnonymous = false,
  }) async {
    final data = {
      'content': content,
      'isAnonymous': isAnonymous,
    };
    final res = await safeCall<DataResponse<Comment>>(dataSource.createReply(
      stockCode,
      boardGroupType.value,
      postId,
      commentId,
      data,
    ));
    final comment = res.tryGetSuccess()?.data;
    return (res.isSuccess() && comment != null) ? Result.success(comment) : Result.error(res.tryGetError()!);
  }
}
