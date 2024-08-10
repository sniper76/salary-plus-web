import 'dart:html' as html;
import 'dart:typed_data';

import 'package:act_cms/data/datasource/remote/api_request_dio_factory.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

class DownloadCsvUtil {
  final ApiRequestDioFactory apiRequestDioFactory;

  DownloadCsvUtil({required this.apiRequestDioFactory});

  Future<Result<void, Exception>> call({required String downloadUrl}) async {
    Dio dio = apiRequestDioFactory.getDioWithLongTimeout;

    try {
      var response = await dio.post(
        downloadUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      String fileName = extractFilename(response.headers, 'download_csv_${DateTime.now().millisecondsSinceEpoch}.csv');

      List<int> bytes = response.data ?? [];

      try {
        final blob = html.Blob([Uint8List.fromList(bytes)]);

        final url = html.Url.createObjectUrlFromBlob(blob);

        // ignore: unused_local_variable
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();

        html.Url.revokeObjectUrl(url);

        return const Result.success(null);
      } catch (e) {
        return Result.error(Exception('not found file'));
      }
    } catch (e) {
      return Result.error(Exception('not found file'));
    }
  }

  String extractFilename(Headers headers, String defaultFilename) {
    String? contentDisposition = headers.value('content-disposition');
    if (contentDisposition != null) {
      RegExp regExp = RegExp(r'filename="([^"]*)"');
      final match = regExp.firstMatch(contentDisposition);
      final fileName = Uri.decodeFull(match?.group(1) ?? "");
      return fileName;
    }
    return defaultFilename;
  }
}
