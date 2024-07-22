import 'dart:io';

import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/document/digital_proxy_result.dart';
import 'package:act_web/domain/model/document/digital_proxy_url.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class PostRepository {
  Future<Result<DataResponse<List<Post>>, Exception>> getPostList({
    required String stockCode,
    required BoardGroupType boardGroupType,
    String? boardGroupCategoryName,
    String? groupedBoardGroupCategoryName,
    int page,
    int size,
    String? sorts,
    bool? isExclusiveToHolders,
  });

  Future<Result<DataResponse<List<Post>>, Exception>> getPostListPreviews({
    required String stockCode,
    required BoardGroupType boardGroupType,
    String? boardGroupCategoryName,
    String? groupedBoardGroupCategoryName,
  });

  Future<Result<DataResponse<Post>, Exception>> saveHolderListReadAndCopyPost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required File signImage,
    required String createPostRequest,
    File? idCardImage,
    File? hectoEncryptedBankAccountPdf,
    List<File>? bankAccountImages,
  });

  Future<Result<Post, Exception>> getPostDetail({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<Post, Exception>> createPost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    bool isAnonymous,
    bool isExclusiveToHolders,
    List<UploadImageFile> uploadImages,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
  });

  Future<Result<Post, Exception>> updatePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required int postId,
    required String title,
    required String content,
    bool isAnonymous,
    bool isExclusiveToHolders,
    List<UploadImageFile> uploadImages,
    List<Poll>? polls,
    DateTime? digitalProxyTargetEndDate,
  });

  Future<Result<void, Exception>> reportPost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required String reason,
  });

  Future<Result<void, Exception>> deletePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<Post, Exception>> likePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<Post, Exception>> unlikePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<void, Exception>> answerOnPostPoll({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int pollId,
    required List<int> pollItemIds,
    bool isUpdate,
  });

  Future<Result<DigitalProxyUrl, Exception>> getPostDigitalProxyEmbeddedUrl({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<List<BoardGroupCategory>, Exception>> getBoardGroupCategories({
    required String stockCode,
    required BoardGroupType boardGroupType,
  });
}
