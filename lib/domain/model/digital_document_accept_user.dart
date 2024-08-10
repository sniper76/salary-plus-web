import 'package:json_annotation/json_annotation.dart';

part 'digital_document_accept_user.g.dart';

@JsonSerializable()
class DigitalDocumentAcceptUser {
  final String name;
  final DateTime birthDate;
  final String phoneNumber;
  final int id;

  const DigitalDocumentAcceptUser({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.phoneNumber,
  });

  DigitalDocumentAcceptUser copyWith({
    String? name,
    String? phoneNumber,
  }) {
    return DigitalDocumentAcceptUser(
      name: name ?? this.name,
      id: id,
      birthDate: birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory DigitalDocumentAcceptUser.fromJson(Map<String, dynamic> json) => _$DigitalDocumentAcceptUserFromJson(json);

  Map<String, dynamic> toJson() => _$DigitalDocumentAcceptUserToJson(this);

  @override
  List<Object?> get props => [name, birthDate];
}
