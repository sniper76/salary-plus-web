import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/digital_document_user.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/enum/digital_document_sort_type.dart';
import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class GetDigitalDocumentUsers {
  final AdminDigitalDocumentRepository repository;

  const GetDigitalDocumentUsers({required this.repository});

  Future<Result<DataResponse<List<DigitalDocumentUser>>, Exception>> call(
      {required int digitalDocumentId,
      String? searchType,
      String? searchKeyword,
      int page = 1,
      int size = 20,
      DigitalDocumentSortType? sort}) {
    final sorts = sort != null ? ['${sort.value}:DESC', '${BoardSortType.createdAt.value}:DESC'] : null;
    return repository.getUsers(
      digitalDocumentId: digitalDocumentId,
      searchType: searchType,
      searchKeyword: searchKeyword,
      page: page,
      size: size,
      sorts: sorts?.join(','),
    );
  }
}
