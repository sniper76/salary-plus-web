import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class CreateZipFile {
  final AdminDigitalDocumentRepository repository;

  const CreateZipFile({required this.repository});

  Future<Result<void, Exception>> call({required int digitalDocumentId, bool isSecured = false}) {
    return repository.create(digitalDocumentId, isSecured);
  }
}
