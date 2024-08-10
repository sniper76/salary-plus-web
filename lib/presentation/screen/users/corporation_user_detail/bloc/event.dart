part of 'bloc.dart';

@immutable
abstract class CorporationDetailEvent {
  const CorporationDetailEvent._();

  const factory CorporationDetailEvent.init() = OnInit;
}

class OnInit extends CorporationDetailEvent {
  const OnInit() : super._();
}
