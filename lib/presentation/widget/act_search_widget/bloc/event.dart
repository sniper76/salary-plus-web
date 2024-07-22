part of 'bloc.dart';

@freezed
class ActSearchWidgetEvent with _$ActSearchWidgetEvent {
  const factory ActSearchWidgetEvent.init() = _OnInit;

  const factory ActSearchWidgetEvent.searchStock(String stockCode) = _OnSearchStock;
}
