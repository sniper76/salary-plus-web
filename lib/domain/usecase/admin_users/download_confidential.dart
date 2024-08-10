import 'dart:html' as html;
import 'dart:typed_data';

import 'package:act_cms/domain/repository/admin_user_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DownloadConfidential {
  final AdminUserRepository repository;

  const DownloadConfidential({required this.repository});

  Future<Result<String, Exception>> call({required int userId}) async {
    final res = await repository.downloadConfidential(userId: userId);
    final bytes = res.tryGetSuccess();
    if (res.isSuccess() && bytes != null) {
      try {
        final blob = html.Blob([Uint8List.fromList(bytes)], 'application/pdf');
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
