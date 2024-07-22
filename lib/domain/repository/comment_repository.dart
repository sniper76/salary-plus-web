import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class CommentRepository {
  Future<Result<DataResponse<List<Comment>>, Exception>> getCommentList({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    int page = 1,
    int size = 10,
    String? sorts,
  });

  Future<Result<Comment, Exception>> createComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required String content,
    bool isAnonymous,
  });

  Future<Result<Comment, Exception>> updateComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String content,
    bool isAnonymous,
  });

  Future<Result<void, Exception>> likeComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  });

  Future<Result<void, Exception>> unlikeComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  });

  Future<Result<void, Exception>> reportComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String reason,
  });

  Future<Result<void, Exception>> deleteComment({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
  });

  Future<Result<DataResponse<List<Comment>>, Exception>> getReplyList({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    int page = 1,
    int size = 10,
    String? sorts,
  });

  Future<Result<Comment, Exception>> createReply({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    required String content,
    bool isAnonymous,
  });
}
