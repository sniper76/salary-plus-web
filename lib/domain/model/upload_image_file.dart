import 'package:json_annotation/json_annotation.dart';

part 'upload_image_file.g.dart';

@JsonSerializable()
class UploadImageFile {
  final int id;
  final String url;
  final String originalFilename;
  final String? fileContentType;
  final String? fileType;
  final String? description;

  const UploadImageFile({
    required this.id,
    required this.url,
    required this.originalFilename,
    this.fileContentType,
    this.fileType,
    this.description,
  });

  factory UploadImageFile.fromJson(Map<String, dynamic> json) => _$UploadImageFileFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageFileToJson(this);
}
