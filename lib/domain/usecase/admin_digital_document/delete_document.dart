import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class DeleteDocument {
  final AdminDigitalDocumentRepository repository;

  const DeleteDocument({required this.repository});

  Future<Result<void, Exception>> call({required int digitalDocumentId}) {
    return repository.delete(digitalDocumentId);
  }
}
