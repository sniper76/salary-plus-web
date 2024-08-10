import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/repository/admin_digital_document_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateDigitalDocumentReferenceDate {
  final AdminDigitalDocumentRepository repository;

  const UpdateDigitalDocumentReferenceDate({required this.repository});

  Future<Result<StockReferenceDate, Exception>> call(
      {required int digitalDocumentId, required int referenceDateId, required DateTime referenceDate}) {
    return repository.updateReferenceDate(digitalDocumentId, referenceDateId, referenceDate);
  }
}
