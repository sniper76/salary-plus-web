import 'dart:html' as html;
import 'dart:typed_data';

import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetDocumentPreview {
  final AdminDigitalDocumentRepository repository;

  const GetDocumentPreview({required this.repository});

  Future<Result<String, Exception>> call({
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
    final res = await repository.getDocumentPreview(
      type: type,
      companyName: companyName,
      shareholderMeetingType: shareholderMeetingType,
      shareholderMeetingName: shareholderMeetingName,
      shareholderMeetingDate: shareholderMeetingDate,
      designatedAgentNames: designatedAgentNames,
      companyRegistrationNumber: companyRegistrationNumber,
      title: title,
      content: content,
      acceptUserId: acceptUserId,
      digitalDocumentList: digitalDocumentList,
      version: version,
    );
    final bytes = res.tryGetSuccess();
    if (res.isSuccess() && bytes != null) {
      try {
        final blob = html.Blob([Uint8List.fromList(bytes)]);

        // Blob을 이용해 Object URL 생성
        final url = html.Url.createObjectUrlFromBlob(blob);

        // 앵커 태그를 생성하고 파일 다운로드를 트리거합니다
        // final anchor = html.AnchorElement(href: url)
        //   ..setAttribute('download', "test.pdf")
        //   ..click();

        // 사용 후 Object URL 해제
        // html.Url.revokeObjectUrl(url);

        return Result.success(url);
      } catch (e) {
        return Result.error(res.tryGetError() ?? Exception('not found file'));
      }
    } else {
      return Result.error(res.tryGetError() ?? Exception('not found file'));
    }
  }
}
