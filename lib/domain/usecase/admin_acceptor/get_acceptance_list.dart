import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/repository/admin_acceptor_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetAcceptanceList {
  final AdminAcceptorRepository repository;

  const GetAcceptanceList({required this.repository});

  Future<Result<DataResponse<List<Post>>, Exception>> call({
    required String digitalDocumentType,
    String? searchType,
    String? searchKeyword,
    int? page,
    int? size,
    String? sorts,
  }) {
    return repository.get(
      digitalDocumentType: digitalDocumentType,
      searchType: searchType,
      searchKeyword: searchKeyword,
      page: page,
      size: size,
    );
  }
}
