import 'dart:async';

import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/local_storage_zip_file.dart';
import 'package:act_cms/domain/repository/admin_local_storage_repository.dart';

class PollingZipFileList {
  final AdminLocalStorageRepository repository;
  final Duration duration = const Duration(seconds: 30);

  PollingZipFileList({required this.repository});

  void call({
    required Function({
      required LocalStorageZipFile zipFileData,
    }) callback,
    required List<LocalStorageZipFile> Function() getZipFileDataList,
  }) {
    Timer.periodic(duration, (Timer time) async {
      final zipFileDataList = getZipFileDataList();
      if (zipFileDataList.isEmpty) {
        time.cancel();
        return;
      }

      Future.wait(zipFileDataList
          .where((zipFileData) => ActionPostType.values.contains(zipFileData.type))
          .map((zipFileData) => callback(zipFileData: zipFileData)));
    });
  }
}
