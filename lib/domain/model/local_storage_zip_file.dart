import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_storage_zip_file.g.dart';

@JsonSerializable()
class LocalStorageZipFile {
  final int id;
  final ActionPostType type;
  final String? fileKey;
  final String? code;
  final BoardGroupType? boardGroupType;

  const LocalStorageZipFile({required this.id, required this.type, this.code, this.boardGroupType, this.fileKey});

  factory LocalStorageZipFile.fromJson(Map<String, dynamic> json) => _$LocalStorageZipFileFromJson(json);

  Map<String, dynamic> toJson() => _$LocalStorageZipFileToJson(this);
}
