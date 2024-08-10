import 'package:act_cms/core/util/helper.dart';
import 'package:act_cms/data/datasource/remote/api_datasource.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/repository/admin_acceptor_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class AdminAcceptorRepositoryImpl implements AdminAcceptorRepository {
  final ApiDataSource dataSource;

  const AdminAcceptorRepositoryImpl({required this.dataSource});

  @override
  Future<Result<DataResponse<List<Post>>, Exception>> get(
      {required String digitalDocumentType,
      String? searchType,
      String? searchKeyword,
      int? page,
      int? size,
      String? sorts}) {
    return safeCall<DataResponse<List<Post>>>(dataSource.getAcceptorDigitalDocsList(
      digitalDocumentType,
      searchType,
      searchKeyword,
      page,
      size,
      sorts,
    ));
  }

  @override
  Future<Result<void, Exception>> assignAcceptUser({required String code, required int userId}) {
    final body = {"userId": userId};
    return safeCall<void>(dataSource.assignAcceptUser(code, body));
  }

  @override
  Future<Result<void, Exception>> fireAcceptUser({required String code, required int userId}) {
    final body = {"userId": userId};
    return safeCall<void>(dataSource.fireAcceptUser(code, body));
  }
}
