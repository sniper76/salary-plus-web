import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_app_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UploadImage {
  final AdminAppRepository repository;

  const UploadImage({required this.repository});

  Future<Result<UploadImageFile, Exception>> call(
      {String fileContentType = "DEFAULT", required List<int> file, String? description}) {
    return repository.uploadImage(fileContentType: fileContentType, file: file, description: description);
  }
}
