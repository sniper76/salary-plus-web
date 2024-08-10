import 'package:act_cms/domain/model/enum/file_download_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'digital_document_download.g.dart';

@JsonSerializable()
class DigitalDocumentDownload {
  final int? id;
  final int? requestUserId;
  final FileDownloadStatusType? zipFileStatus;
  final int? downloadCount;
  final String? zipFilePath;
  final String? zipFileKey;
  final DateTime? updatedAt;

  const DigitalDocumentDownload({
    this.id,
    this.requestUserId,
    this.zipFileStatus,
    this.downloadCount,
    this.zipFilePath,
    this.zipFileKey,
    this.updatedAt,
  });

  factory DigitalDocumentDownload.fromJson(Map<String, dynamic> json) => _$DigitalDocumentDownloadFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentDownloadToJson(this);

  DigitalDocumentDownload copyWith({
    String? title,
  }) {
    return DigitalDocumentDownload();
  }
}
