// import 'package:act_cms/domain/model/user.dart';
// import 'package:multiple_result/multiple_result.dart';

import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:multiple_result/src/result.dart';

abstract class AdminDigitalDocumentRepository {
  Future<Result<void, Exception>> delete(int digitalDocumentId);

  Future<Result<void, Exception>> create(int digitalDocumentId, bool isSecured);

  Future<Result<List<int>, Exception>> download(int digitalDocumentId);

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
  });

  Future<Result<DataResponse<List<DigitalDocumentUser>>, Exception>> getUsers(
      {required int digitalDocumentId, String? searchType, String? searchKeyword, int? page, int? size, String? sorts});

  Future<Result<List<int>, Exception>> getUserDigitalDocumentPdf({required int userId, required int digitalDocumentId});

  Future<Result<StockReferenceDate, Exception>> updateReferenceDate(
      int digitalDocumentId, int referenceDateId, DateTime referenceDate);
}
