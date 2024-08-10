import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminCommentRepository {
  Future<Result<DataResponse<List<Comment>>, Exception>> list({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    int page = 1,
    int size = 20,
    String? sorts,
  });

  Future<Result<DataResponse<List<Comment>>, Exception>> replies({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int commentId,
    int page = 1,
    int size = 20,
    String? sorts,
  });

  Future<Result<Comment, Exception>> updateStatus(
      {required String stockCode,
      required String boardGroup,
      required int postId,
      required int commentId,
      required String status});

  Future<Result<Comment, Exception>> create(
      {required String stockCode,
      required String boardGroup,
      required int postId,
      required String content,
      required bool isAnonymous});

  Future<Result<Comment, Exception>> edit(
      {required String stockCode,
      required String boardGroup,
      required int postId,
      required int commentId,
      required String content});

  Future<Result<Comment, Exception>> createReplies(
      {required String stockCode,
      required String boardGroup,
      required int postId,
      required int commentId,
      required String content,
      required bool isAnonymous});
// Future<Result<User, Exception>> login({required String email, required String password});

// Future<Result<User, Exception>> changePassword({required String currentPassword, required String password, required String confirmPassword});
}
