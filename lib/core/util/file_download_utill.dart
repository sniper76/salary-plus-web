import 'dart:html' as html;

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/domain/model/enum/file_extension_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FileDownloadUtils {
  final BuildContext context;
  final baseUrl = Constants.getEnvironment.getApiBaseUrl();

  FileDownloadUtils({required this.context});

  String getUrl({required String key, FileExtensionType? extension}) {
    final extValue = extension?.value ?? FileExtensionType.zip.value;
    return "$baseUrl/public/download/$extValue/$key";
  }

  void pasteLink({required String key, FileExtensionType? extension}) {
    Clipboard.setData(ClipboardData(text: getUrl(key: key, extension: extension))).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("링크가 클립보드에 복사되었습니다.")));
    });
  }

  void downloadLink({required String key, FileExtensionType? extension}) {
    final apiUrl = getUrl(key: key, extension: extension);
    html.AnchorElement(href: apiUrl)
      ..setAttribute('download', '') // 필요한 경우 파일명 지정
      ..target = '_blank'
      ..click();
  }
}
