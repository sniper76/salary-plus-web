part of 'bloc.dart';

@freezed
class ActLoginEvent with _$ActLoginEvent {
  const factory ActLoginEvent.init() = _OnInit;

  const factory ActLoginEvent.tick() = _OnTick;

  const factory ActLoginEvent.pollingWebVerification() = _OnPollingWebVerification;
}
