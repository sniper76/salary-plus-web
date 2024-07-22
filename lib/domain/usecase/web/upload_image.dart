import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/repository/web_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UploadImage {
  final WebRepository repository;
  const UploadImage({required this.repository});

  Future<Result<UploadImageFile, Exception>> call(List<int> file) {
    return repository.uploadImage(file);
  }
}
