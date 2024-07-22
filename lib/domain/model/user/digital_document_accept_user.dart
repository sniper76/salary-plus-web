import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_document_accept_user.freezed.dart';
part 'digital_document_accept_user.g.dart';

@freezed
class DigitalDocumentAcceptUser with _$DigitalDocumentAcceptUser {
  const factory DigitalDocumentAcceptUser({
    required String name,
    required DateTime birthDate,
    required String phoneNumber,
    String? corporateNo,
  }) = _DigitalDocumentAcceptUser;

  factory DigitalDocumentAcceptUser.fromJson(Map<String, dynamic> json) => _$DigitalDocumentAcceptUserFromJson(json);
}
