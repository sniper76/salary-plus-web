import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';

class SaveZipFileData {
  final AdminLocalStorageRepository repository;

  SaveZipFileData({required this.repository});

  void call(String storageKey, String fileData) {
    repository.save(storageKey, fileData);
  }
}
