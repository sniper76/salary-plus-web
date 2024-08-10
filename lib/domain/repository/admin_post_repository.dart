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
import 'package:multiple_result/multiple_result.dart';

abstract class AdminPostRepository {
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
  });

  Future<Result<DataResponse<Post>, Exception>> getDetail({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<void, Exception>> duplicate({required int postId, required int stockGroupId});

  Future<Result<Post, Exception>> duplicateStockGroup({required int postId, required String stockCode});

  Future<Result<DataResponse<List<ReportList>>, Exception>> getReports(
      {required String reportType, String? reportStatus, int? page, int? size, String? sorts});

  Future<Result<ReportDetail, Exception>> getReportDetail({required String reportType, required int reportId});

  Future<Result<Post, Exception>> create({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required String title,
    required String content,
    bool isActive,
    bool isNotification,
    bool isAnonymous,
    bool isExclusiveToHolders,
    List<UploadImageFile> uploadImages,
    List<Poll>? polls,
    DigitalProxyResult? digitalProxy,
    DigitalDocumentAdmin? digitalDocument,
    String? activeStartDate,
    String? activeEndDate,
    PushRequest? pushRequest,
    bool? isEscaped,
  });

  Future<Result<void, Exception>> delete({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required int postId,
  });

  Future<Result<Post, Exception>> update({
    required String stockCode,
    required BoardGroupType boardGroupType,
    required BoardGroupCategory boardGroupCategory,
    required int postId,
    required String title,
    required String content,
    bool isAnonymous,
    bool isNotification,
    bool isActive,
    bool isExclusiveToHolders,
    List<UploadImageFile> uploadImages,
    List<int>? pollIds,
    DateTime? pollTargetEndDate,
    DateTime? digitalProxyTargetEndDate,
    DateTime? digitalDocumentTargetEndDate,
    String? activeStartDate,
    String? activeEndDate,
    bool? isEscaped,
  });

  Future<Result<ReportDetail, Exception>> updateReportStatus({
    required String reportType,
    required int reportId,
    required String result,
    required String currentReportStatus,
    required String changeReportStatus,
  });
}
