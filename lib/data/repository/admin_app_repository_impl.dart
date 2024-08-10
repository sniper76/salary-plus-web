import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/upload_image_file.dart';
import 'package:act_cms/domain/repository/admin_app_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminAppRepositoryImpl implements AdminAppRepository {
  final ApiDataSource dataSource;

  const AdminAppRepositoryImpl({required this.dataSource});

  @override
  Future<Result<UploadImageFile, Exception>> uploadImage(
      {required String fileContentType, required List<int> file, String? description}) async {
    final res =
        await safeCall<DataResponse<UploadImageFile>>(dataSource.uploadAdminImages(fileContentType, file, description));
    final uploadImage = res.tryGetSuccess()?.data;
    return (res.isSuccess() && uploadImage != null) ? Result.success(uploadImage) : Result.error(res.tryGetError()!);
  }
}
