import 'package:act_web/core/util/helper.dart';
import 'package:act_web/data/datasource/remote/api_datasource.dart';
import 'package:act_web/data/response/data_response.dart';
import 'package:act_web/domain/model/file/upload_image_file.dart';
import 'package:act_web/domain/repository/web_repository.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multiple_result/multiple_result.dart';

class WebRepositoryImpl implements WebRepository {
  final ApiDataSource dataSource;

  const WebRepositoryImpl({required this.dataSource});

  @override
  Future<Result<UploadImageFile, Exception>> uploadImage(List<int> file) async {
    final MultipartFile multipartFile = MultipartFile.fromBytes(
      file,
      filename: 'image.jpeg',
      contentType: MediaType('image', 'jpeg'),
    );
    final FormData formData = FormData.fromMap({
      'file': multipartFile,
    });

    final res = await safeCall<DataResponse<UploadImageFile>>(dataSource.uploadImage(
      'multipart/form-data',
      formData,
    ));
    final uploadImage = res.tryGetSuccess()?.data;
    return (res.isSuccess() && uploadImage != null) ? Result.success(uploadImage) : Result.error(res.tryGetError()!);
  }
}
