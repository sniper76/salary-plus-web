import 'package:json_annotation/json_annotation.dart';

enum WebVerificationStatus {
  @JsonValue('VERIFIED')
  verified,
  @JsonValue('EXPIRED')
  expired,
  @JsonValue('WAITING')
  waiting,
}
