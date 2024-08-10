import 'dart:convert';

import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/local_storage_zip_file.dart';
import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';

class GetZipFileDataList {
  final AdminLocalStorageRepository repository;

  GetZipFileDataList({required this.repository});

  bool checkActionPostTypeInLocalStorage(String value) => ActionPostType.values.map((e) => e.value).contains(value);

  List<LocalStorageZipFile> call() {
    final list = repository.list();
    return list.where((localData) {
      try {
        jsonDecode(localData);
        return true;
      } catch (_) {
        return false;
      }
    }).map((fileData) {
      Map<String, dynamic> zipFileJson = jsonDecode(fileData);
      return LocalStorageZipFile.fromJson(zipFileJson);
    }).toList();
  }
}
