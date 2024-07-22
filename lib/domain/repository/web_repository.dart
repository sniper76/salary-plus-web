import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class WebRepository {
  Future<Result<UploadImageFile, Exception>> uploadImage(List<int> file);
}
