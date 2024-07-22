import 'package:json_annotation/json_annotation.dart';

enum ElectionStatus {
  @JsonValue('CANDIDATE_REGISTRATION_PERIOD')
  candidateRegistrationPeriod,
  @JsonValue('VOTE_PERIOD')
  votePeriod,
  @JsonValue('FINISHED')
  finished,
}
