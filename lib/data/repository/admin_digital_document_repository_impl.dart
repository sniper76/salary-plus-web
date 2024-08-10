import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminDigitalDocumentRepositoryImpl implements AdminDigitalDocumentRepository {
  final ApiDataSource dataSource;

  const AdminDigitalDocumentRepositoryImpl({required this.dataSource});

  @override
  Future<Result<void, Exception>> delete(int digitalDocumentId) async {
    return safeCall<void>(dataSource.deleteAdminDigitalDocument(digitalDocumentId));
  }

  @override
  Future<Result<void, Exception>> create(int digitalDocumentId, bool isSecured) async {
    return safeCall<void>(dataSource.createAdminDigitalDocumentZipFile(digitalDocumentId, isSecured));
  }

  @override
  Future<Result<List<int>, Exception>> download(int digitalDocumentId) async {
    final res = await safeCall<List<int>>(dataSource.downloadAdminDigitalDocumentCsv(digitalDocumentId));
    final data = res.tryGetSuccess();

    if (res.isSuccess() && data != null) {
      return Result.success(data);
    } else {
      return Result.error(res.tryGetError() ?? Exception('empty data'));
    }
  }

  @override
  Future<Result<List<int>, Exception>> getDocumentPreview({
    required String type,
    String? companyName,
    String? shareholderMeetingType,
    String? shareholderMeetingName,
    DateTime? shareholderMeetingDate,
    String? designatedAgentNames,
    String? companyRegistrationNumber,
    String? title,
    String? content,
    int? acceptUserId,
    List<DigitalDocumentItem>? digitalDocumentList,
    String? version,
  }) async {
    final data = {
      'type': type,
      'companyName': companyName,
      'shareholderMeetingType': shareholderMeetingType,
      'shareholderMeetingName': shareholderMeetingName,
      'shareholderMeetingDate': shareholderMeetingDate?.toUtc().toIso8601String(),
      'designatedAgentNames': designatedAgentNames,
      'companyRegistrationNumber': companyRegistrationNumber,
      'title': title,
      'content': content,
      'acceptUserId': acceptUserId,
      'childItems': digitalDocumentList,
      'version': version,
    };
    data.removeWhere((k, v) => v == null);
    final res = await safeCall<List<int>>(dataSource.getAdminDocumentPreview(data));
    final result = res.tryGetSuccess();

    if (res.isSuccess() && result != null) {
      return Result.success(result);
    } else {
      return Result.error(res.tryGetError() ?? Exception('empty data'));
    }
  }

  @override
  Future<Result<DataResponse<List<DigitalDocumentUser>>, Exception>> getUsers(
      {required int digitalDocumentId,
      String? searchType,
      String? searchKeyword,
      int? page,
      int? size,
      String? sorts}) {
    return safeCall<DataResponse<List<DigitalDocumentUser>>>(
        dataSource.getAdminDigitalDocumentUsers(digitalDocumentId, searchType, searchKeyword, page, size, sorts));
  }

  @override
  Future<Result<List<int>, Exception>> getUserDigitalDocumentPdf(
      {required int userId, required int digitalDocumentId}) async {
    final res = await safeCall<List<int>>(dataSource.downloadAdminUserDigitalDocumentPdf(userId, digitalDocumentId));
    final result = res.tryGetSuccess();

    if (res.isSuccess() && result != null) {
      return Result.success(result);
    } else {
      return Result.error(res.tryGetError() ?? Exception('empty data'));
    }
  }

  @override
  Future<Result<StockReferenceDate, Exception>> updateReferenceDate(
      int digitalDocumentId, int referenceDateId, DateTime referenceDate) async {
    final data = {'referenceDate': referenceDate.toFormatString()};
    final res = await safeCall<DataResponse<StockReferenceDate>>(
        dataSource.updateAdminDigitalDocumentReferenceDate(digitalDocumentId, referenceDateId, data));
    final result = res.tryGetSuccess()?.data;
    if (res.isSuccess() && result != null) {
      return Result.success(result);
    } else {
      return Result.error(res.tryGetError() ?? Exception('empty data'));
    }
  }
}
