part of 'bloc.dart';

@freezed
class StockHomeEvent with _$StockHomeEvent {
  const factory StockHomeEvent.init() = _OnInit;

  const factory StockHomeEvent.updateSolidarityLeaderMessage(String message) = _OnUpdateSolidarityLeaderMessage;
}
