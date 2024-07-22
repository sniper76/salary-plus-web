import 'package:freezed_annotation/freezed_annotation.dart';

part 'web_verification.freezed.dart';
part 'web_verification.g.dart';

@freezed
class WebVerification with _$WebVerification {
  const WebVerification._();

  const factory WebVerification({
    required String verificationCode,
    required DateTime expirationDateTime,
  }) = _WebVerification;

  factory WebVerification.fromJson(Map<String, dynamic> json) => _$WebVerificationFromJson(json);
}
