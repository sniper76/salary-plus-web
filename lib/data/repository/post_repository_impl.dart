import 'dart:io';

import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/document/digital_proxy_result.dart';
import 'package:act_web/domain/model/document/digital_proxy_url.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/repository/post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiDataSource dataSource;

  const PostRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<Post>>, Exception>> getPostList({
    required String stockCode,
    required BoardGroupType boardGroupType,
    String? boardGroupCategoryName,
    String? groupedBoardGroupCategoryName,
    int page = 1,
    int size = 10,
    String? sorts,
    bool? isExclusiveToHolders,
  }) {
    return safeCall<DataResponse<List<Post>>>(dataSource.getPostList(
      stockCode,
      boardGroupType.value,
      boardGroupCategoryName,
      groupedBoardGroupCategoryName,
      page,
      size,
      sorts,
      isExclusiveToHolders,
    ));
  }

  @override
  Future<Result<DataResponse<List<Post>>, Exception>> getPostListPreviews({
    required String stockCode,
    required BoardGroupType boardGroupType,
    String? boardGroupCategoryName,
    String? groupedBoardGroupCategoryName,
  }) {
    return safeCall<DataResponse<List<Post>>>(dataSource.getPostListPreviews(
      stockCode,
      boardGroupType.value,
      boardGroupCategoryName,
      groupedBoardGroupCategoryName,
    ));
  }

  @override
  Future<Result<Post, Exception>> getPostDetail({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) async {
    final res = await safeCall<DataResponse<Post>>(dataSource.getPostDetail(
      stockCode,
      boardGroupType.value,
      postId,
    ));
    final data = res.tryGetSuccess()?.data;
    return (res.isSuccess() && data != null) ? Result.success(data) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Post, Exception>> createPost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
  }) async {
    final data = {
      'boardCategory': boardGroupCategory.name,
      'title': title,
      'content': content,
      'isAnonymous': isAnonymous,
      'imageIds': uploadImages.map((e) => e.id).toList(),
      'polls': polls?.map((poll) => poll.toJson()).toList(),
      'digitalProxy': digitalProxy?.toCreateJson(),
      'isExclusiveToHolders': isExclusiveToHolders,
    };
    final res = await safeCall<DataResponse<Post>>(dataSource.createPost(
      stockCode,
      boardGroupType.value,
      data,
    ));
    final post = res.tryGetSuccess()?.data;
    return (res.isSuccess() && post != null) ? Result.success(post) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Post, Exception>> updatePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required int postId,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
    DateTime? digitalProxyTargetEndDate,
  }) async {
    final data = {
      'boardCategory': boardGroupCategory.name,
      'title': title,
      'content': content,
      'isAnonymous': isAnonymous,
      'isExclusiveToHolders': isExclusiveToHolders,
      'imageIds': uploadImages.map((e) => e.id).toList(),
    };
    if (polls != null) {
      data['polls'] = polls
          .map((poll) => {'id': poll.id, 'targetEndDate': polls.first.targetEndDate?.toUtc().toIso8601String()})
          .toList();
    }

    if (digitalProxyTargetEndDate != null) {
      data['updateTargetDate'] = {'targetEndDate': digitalProxyTargetEndDate.toUtc().toIso8601String()};
    }

    final res = await safeCall<DataResponse<Post>>(dataSource.updatePost(
      stockCode,
      boardGroupType.value,
      postId,
      data,
    ));
    final post = res.tryGetSuccess()?.data;

    return (res.isSuccess() && post != null) ? Result.success(post) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> reportPost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required String reason,
  }) {
    final data = {
      'reason': reason,
    };
    return safeCall<void>(dataSource.reportPost(stockCode, boardGroupType.value, postId, data));
  }

  @override
  Future<Result<void, Exception>> deletePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return safeCall<void>(dataSource.deletePost(
      stockCode,
      boardGroupType.value,
      postId,
    ));
  }

  @override
  Future<Result<Post, Exception>> likePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) async {
    final res = await safeCall<DataResponse<Post>>(dataSource.likePost(
      stockCode,
      boardGroupType.value,
      postId,
    ));
    final post = res.tryGetSuccess()?.data;
    return (res.isSuccess() && post != null) ? Result.success(post) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Post, Exception>> unlikePost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) async {
    final res = await safeCall<DataResponse<Post>>(dataSource.unlikePost(
      stockCode,
      boardGroupType.value,
      postId,
    ));
    final post = res.tryGetSuccess()?.data;
    return (res.isSuccess() && post != null) ? Result.success(post) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> answerOnPostPoll({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
    required int pollId,
    required List<int> pollItemIds,
    bool isUpdate = false,
  }) {
    final data = {
      'pollAnswer': pollItemIds.map((int pollItemId) => {'pollItemId': pollItemId}).toList(),
    };

    if (isUpdate) {
      return safeCall<void>(dataSource.updateAnswerOnPostPoll(
        stockCode,
        boardGroupType.value,
        postId,
        pollId,
        data,
      ));
    }

    return safeCall<void>(dataSource.createAnswerOnPostPoll(
      stockCode,
      boardGroupType.value,
      postId,
      pollId,
      data,
    ));
  }

  @override
  Future<Result<DigitalProxyUrl, Exception>> getPostDigitalProxyEmbeddedUrl({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return safeCall<DigitalProxyUrl>(dataSource.getPostDigitalProxyEmbeddedUrl(
      stockCode,
      boardGroupType.value,
      postId,
    ));
  }

  @override
  Future<Result<DataResponse<Post>, Exception>> saveHolderListReadAndCopyPost({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required File signImage,
    File? idCardImage,
    required String createPostRequest,
    File? hectoEncryptedBankAccountPdf,
    List<File>? bankAccountImages,
  }) {
    return safeCall<DataResponse<Post>>(dataSource.saveHolderListReadAndCopyPost(
      stockCode,
      boardGroupType.value,
      createPostRequest,
      signImage,
      idCardImage != null ? [idCardImage] : [],
      bankAccountImages,
      hectoEncryptedBankAccountPdf != null ? [hectoEncryptedBankAccountPdf] : [],
    ));
  }

  @override
  Future<Result<List<BoardGroupCategory>, Exception>> getBoardGroupCategories({
    required String stockCode,
    required BoardGroupType boardGroupType,
  }) async {
    final res = await safeCall<DataResponse<List<BoardGroupCategory>>>(dataSource.getBoardGroupCategories(
      stockCode,
      boardGroupType.value,
    ));
    final items = res.tryGetSuccess()?.data ?? [];
    return res.isSuccess() ? Result.success(items) : Result.error(res.tryGetError()!);
  }
}
