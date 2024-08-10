import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminAppRepository {
  Future<Result<UploadImageFile, Exception>> uploadImage(
      {required String fileContentType, required List<int> file, String? description});
}
