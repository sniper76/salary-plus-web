enum FileExtensionType { zip, unknown }

extension FileExtensionTypeExtension on FileExtensionType {
  String get value {
    switch (this) {
      case FileExtensionType.zip:
        return 'zip';
      default:
        return '';
    }
  }
}
