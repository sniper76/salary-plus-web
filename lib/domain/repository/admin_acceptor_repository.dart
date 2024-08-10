import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class AdminAcceptorRepository {
  Future<Result<DataResponse<List<Post>>, Exception>> get({
    required String digitalDocumentType,
    String? searchType,
    String? searchKeyword,
    int? page,
    int? size,
    String? sorts,
  });

  Future<Result<void, Exception>> assignAcceptUser({required String code, required int userId});

  Future<Result<void, Exception>> fireAcceptUser({required String code, required int userId});
}
