import 'package:json_annotation/json_annotation.dart';

part 'digital_document_user.g.dart';

@JsonSerializable()
class DigitalDocumentUser {
  final String name;
  final DateTime birthDate;
  final String gender;
  final String phoneNumber;
  final int issuedNumber;

  final String? zipcode;
  final String? address;
  final String? addressDetail;
  final int? userId;
  final int? digitalDocumentId;

  const DigitalDocumentUser(
      {required this.name,
      required this.birthDate,
      required this.gender,
      required this.phoneNumber,
      required this.issuedNumber,
      this.zipcode,
      this.address,
      this.addressDetail,
      this.userId,
      this.digitalDocumentId});

  factory DigitalDocumentUser.fromJson(Map<String, dynamic> json) => _$DigitalDocumentUserFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentUserToJson(this);
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
