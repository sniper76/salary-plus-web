import 'dart:convert';

import 'package:act_cms/domain/model/local_storage_zip_file.dart';
import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';

class GetZipFileData {
  final AdminLocalStorageRepository repository;

  GetZipFileData({required this.repository});

  LocalStorageZipFile? call(String storageKey) {
    final value = repository.get(storageKey);
    if (value != null) {
      Map<String, dynamic> zipFileJson = jsonDecode(value);
      return LocalStorageZipFile.fromJson(zipFileJson);
    }
    return null;
  }
}
