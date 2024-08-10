import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/push_request.dart';
import 'package:act_cms/domain/model/report_detail.dart';
import 'package:act_cms/domain/model/report_list.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_post_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminPostRepositoryImpl implements AdminPostRepository {
  final ApiDataSource dataSource;

  const AdminPostRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<Post>>, Exception>> get({
    required BoardGroupType boardGroup,
    BoardGroupCategory? boardCategory,
    BoardSearchType? searchType,
    String? searchKeyword,
    PostStatusType? status,
    int? page,
    int? size,
    String? sorts,
    String? searchStartDateString,
    String? searchEndDateString,
  }) {
    return safeCall<DataResponse<List<Post>>>(dataSource.getAdminPosts(
      boardGroup.value,
      boardCategory?.name,
      searchType?.value,
      searchKeyword,
      status?.value,
      page,
      size,
      sorts,
      searchStartDateString,
      searchEndDateString,
    ));
  }

  @override
  Future<Result<DataResponse<Post>, Exception>> getDetail(
      {required String stockCode, required BoardGroupType boardGroupType, required int postId}) async {
    return safeCall<DataResponse<Post>>(dataSource.getAdminPostDetail(stockCode, boardGroupType.value, postId));
  }

  @override
  Future<Result<void, Exception>> duplicate({required int postId, required int stockGroupId}) async {
    return safeCall<void>(dataSource.duplicateAdminPosts(postId, stockGroupId));
  }

  @override
  Future<Result<DataResponse<List<ReportList>>, Exception>> getReports(
      {required String reportType, String? reportStatus, int? page, int? size, String? sorts}) {
    return safeCall<DataResponse<List<ReportList>>>(
        dataSource.getAdminReports(reportType, reportStatus, page, size, sorts));
  }

  @override
  Future<Result<ReportDetail, Exception>> getReportDetail({required String reportType, required int reportId}) {
    return safeCall<ReportDetail>(dataSource.getAdminReportDetail(reportType, reportId));
  }

  @override
  Future<Result<Post, Exception>> create({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    bool isActive = true,
    bool isNotification = false,
    bool isAnonymous = false,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
    String? activeStartDate,
    String? activeEndDate,
    PushRequest? pushRequest,
    bool? isEscaped,
  }) async {
    final data = {
      'boardCategory': boardGroupCategory.name,
      'title': title,
      'content': content,
      'isAnonymous': isAnonymous,
      'isActive': isActive,
      'isNotification': isNotification,
      'isExclusiveToHolders': isExclusiveToHolders,
      'imageIds': uploadImages.map((e) => e.id).toList(),
      'polls': polls?.map((poll) => poll.toJson()).toList(),
      'digitalProxy': digitalProxy?.toString(),
      'digitalDocument': digitalDocument?.toJson(),
      'push': pushRequest?.toJson(),
      'activeStartDate': activeStartDate,
      'activeEndDate': activeEndDate,
      'isEd': isEscaped ?? false,
    };
    final res = await safeCall<DataResponse<Post>>(dataSource.createAdminBoardPost(
      stockCode,
      boardGroupType.value,
      data,
    ));
    final post = res.tryGetSuccess()?.data;
    return (res.isSuccess() && post != null) ? Result.success(post) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<void, Exception>> delete({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  }) {
    return safeCall<void>(dataSource.deleteAdminBoardPost(
      stockCode,
      boardGroupType.value,
      postId,
    ));
  }

  @override
  Future<Result<Post, Exception>> update({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required int postId,
    required String title,
    required String content,
    bool isAnonymous = false,
    bool isNotification = false,
    bool isActive = true,
    bool isExclusiveToHolders = false,
    List<UploadImageFile> uploadImages = const [],
    List<int>? pollIds = const [],
    DateTime? pollTargetEndDate,
    DateTime? digitalProxyTargetEndDate,
    DateTime? digitalDocumentTargetEndDate,
    String? activeStartDate,
    String? activeEndDate,
    bool? isEscaped,
  }) async {
    final data = {
      'boardCategory': boardGroupCategory.name,
      'title': title,
      'content': content,
      'isAnonymous': isAnonymous,
      'isNotification': isNotification,
      'isActive': isActive,
      'isExclusiveToHolders': isExclusiveToHolders,
      'imageIds': uploadImages.map((e) => e.id).toList(),
      'activeStartDate': activeStartDate,
      'activeEndDate': activeEndDate,
      'isEd': isEscaped ?? false,
    };
    if (pollTargetEndDate != null && pollIds?.isNotEmpty == true) {
      final pollsData = pollIds!
          .map((int pollId) => {
                'id': pollId.toString(),
                'targetEndDate': pollTargetEndDate.toUtc().toIso8601String(),
              })
          .toList();
      data['polls'] = pollsData;
    }

    if (digitalProxyTargetEndDate != null) {
      data['updateTargetDate'] = {'targetEndDate': digitalProxyTargetEndDate.toUtc().toIso8601String()};
    }

    if (digitalDocumentTargetEndDate != null) {
      data['updateTargetDate'] = {'targetEndDate': digitalDocumentTargetEndDate.toUtc().toIso8601String()};
      data['digitalDocument'] = {'targetEndDate': digitalDocumentTargetEndDate.toUtc().toIso8601String()};
    }

    final res = await safeCall<DataResponse<Post>>(dataSource.updateAdminBoardPost(
      stockCode,
      boardGroupType.value,
      postId,
      data,
    ));
    final post = res.tryGetSuccess()?.data;

    return (res.isSuccess() && post != null) ? Result.success(post) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<Post, Exception>> duplicateStockGroup({required int postId, required String stockCode}) async {
    final data = {"stockCode": stockCode};

    final res = await safeCall<DataResponse<Post>>(dataSource.duplicateAdimnStockGroup(postId, data));
    final result = res.tryGetSuccess()?.data;
    return (res.isSuccess() && result != null) ? Result.success(result) : Result.error(res.tryGetError()!);
  }

  @override
  Future<Result<ReportDetail, Exception>> updateReportStatus(
      {required String reportType,
      required int reportId,
      required String result,
      required String currentReportStatus,
      required String changeReportStatus}) {
    final data = {
      "result": result,
      "currentReportStatus": currentReportStatus,
      "changeReportStatus": changeReportStatus
    };
    return safeCall<ReportDetail>(dataSource.updateAdminReportStatus(reportType, reportId, data));
  }
}
