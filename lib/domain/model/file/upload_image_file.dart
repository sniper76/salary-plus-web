import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_image_file.freezed.dart';
part 'upload_image_file.g.dart';

@freezed
class UploadImageFile with _$UploadImageFile {
  const factory UploadImageFile({
    required int id,
    required String url,
    required String originalFilename,
    String? fileContentType,
    String? fileType,
    String? description,
  }) = _UploadImageFile;

  factory UploadImageFile.fromJson(Map<String, dynamic> json) => _$UploadImageFileFromJson(json);
}
