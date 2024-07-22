import 'package:freezed_annotation/freezed_annotation.dart';

part 'holder_list_read_and_copy_digital_document.freezed.dart';
part 'holder_list_read_and_copy_digital_document.g.dart';

@freezed
class HolderListReadAndCopyDigitalDocument with _$HolderListReadAndCopyDigitalDocument {
  const HolderListReadAndCopyDigitalDocument._();

  const factory HolderListReadAndCopyDigitalDocument({
    required int digitalDocumentId,
    required String fileName,
  }) = _HolderListReadAndCopyDigitalDocument;

  factory HolderListReadAndCopyDigitalDocument.fromJson(Map<String, dynamic> json) =>
      _$HolderListReadAndCopyDigitalDocumentFromJson(json);
}

extension HolderListReadAndCopyDigitalDocumentExtension on HolderListReadAndCopyDigitalDocument {
  String get getFileExtension {
    if (fileName.contains('.')) {
      return fileName.split('.').last;
    } else {
      return '';
    }
  }

  String get getName {
    String fileExtension = getFileExtension;

    return fileExtension.isNotEmpty == true
        ? fileName.substring(0, fileName.length - fileExtension.length - 1)
        : fileName;
  }
}
