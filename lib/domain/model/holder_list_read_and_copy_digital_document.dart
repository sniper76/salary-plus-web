import 'package:json_annotation/json_annotation.dart';

part 'holder_list_read_and_copy_digital_document.g.dart';

@JsonSerializable()
class HolderListReadAndCopyDigitalDocument {
  final int digitalDocumentId;
  final String fileName;
  @JsonKey(name: 'userId')
  final int digitalDocumentOwnerId;

  HolderListReadAndCopyDigitalDocument({
    required this.digitalDocumentId,
    required this.fileName,
    required this.digitalDocumentOwnerId,
  });

  factory HolderListReadAndCopyDigitalDocument.fromJson(Map<String, dynamic> json) =>
      _$HolderListReadAndCopyDigitalDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$HolderListReadAndCopyDigitalDocumentToJson(this);

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
