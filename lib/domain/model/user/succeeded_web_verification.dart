import 'package:act_web/domain/enum/web_verification_status.dart';
import 'package:act_web/domain/model/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'succeeded_web_verification.freezed.dart';
part 'succeeded_web_verification.g.dart';

@freezed
class SucceededWebVerification with _$SucceededWebVerification {
  const factory SucceededWebVerification({
    required WebVerificationStatus status,
    String? token,
    User? user,
  }) = _SucceededWebVerification;

  factory SucceededWebVerification.fromJson(Map<String, dynamic> json) => _$SucceededWebVerificationFromJson(json);
}
