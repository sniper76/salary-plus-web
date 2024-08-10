import 'dart:html' as html;
import 'dart:typed_data';

import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetUserDigitalDocumentPdf {
  final AdminDigitalDocumentRepository repository;

  const GetUserDigitalDocumentPdf({required this.repository});

  Future<Result<String, Exception>> call({
    required int userId,
    required int digitalDocumentId,
  }) async {
    final res = await repository.getUserDigitalDocumentPdf(userId: userId, digitalDocumentId: digitalDocumentId);
    final bytes = res.tryGetSuccess();
    if (res.isSuccess() && bytes != null) {
      try {
        final blob = html.Blob([Uint8List.fromList(bytes)]);
        final url = html.Url.createObjectUrlFromBlob(blob);

        return Result.success(url);
      } catch (e) {
        return Result.error(res.tryGetError() ?? Exception('not found file'));
      }
    } else {
      return Result.error(res.tryGetError() ?? Exception('not found file'));
    }
  }
}
