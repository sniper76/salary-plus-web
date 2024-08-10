import 'package:equatable/equatable.dart';

class AuthVerification extends Equatable {
  final String name;
  final String birthDate;
  final String gender;
  final String phoneProvider;
  final String phoneNumber;
  final String? txSeqNo;

  const AuthVerification({
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.phoneProvider,
    required this.phoneNumber,
    this.txSeqNo,
  });

  AuthVerification copyWith({
    String? txSeqNo,
  }) {
    return AuthVerification(
      name: name,
      birthDate: birthDate,
      gender: gender,
      phoneProvider: phoneProvider,
      phoneNumber: phoneNumber,
      txSeqNo: txSeqNo ?? this.txSeqNo,
    );
  }

  @override
  List<Object?> get props => [
        name,
        birthDate,
        gender,
        phoneProvider,
        phoneNumber,
        txSeqNo,
      ];
}
