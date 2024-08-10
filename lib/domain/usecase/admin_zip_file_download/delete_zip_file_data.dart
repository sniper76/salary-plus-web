import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';

class DeleteZipFileData {
  final AdminLocalStorageRepository repository;

  DeleteZipFileData({required this.repository});

  void call(String storageKey) {
    repository.delete(storageKey);
  }
}
