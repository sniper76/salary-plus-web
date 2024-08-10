import 'package:flutter/material.dart';

class IconsUtil {
  static IconData getFileExtensionIcon(String extension) {
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'xlsx':
      case 'xls':
        return Icons.article;
      default:
        return Icons.upload_file;
    }
  }
}
