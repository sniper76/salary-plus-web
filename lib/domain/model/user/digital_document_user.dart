import 'package:freezed_annotation/freezed_annotation.dart';

part 'digital_document_user.freezed.dart';
part 'digital_document_user.g.dart';

@freezed
class DigitalDocumentUser with _$DigitalDocumentUser {
  const DigitalDocumentUser._();

  const factory DigitalDocumentUser({
    required String name,
    required DateTime birthDate,
    required String gender,
    required String phoneNumber,
    String? zipcode,
    String? address,
    String? addressDetail,
  }) = _DigitalDocumentUser;

  factory DigitalDocumentUser.fromJson(Map<String, dynamic> json) => _$DigitalDocumentUserFromJson(json);
}

extension DigitalDocumentUserExtension on DigitalDocumentUser {
  String get genderTitle {
    if (gender == 'M') {
      return '남';
    } else {
      return '여';
    }
  }
}
