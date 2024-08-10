part of 'bloc.dart';

@immutable
abstract class PopupDetailEvent {
  const PopupDetailEvent._();

  const factory PopupDetailEvent.init(int updatePopupId) = PopupDetailOnInit;
}

class PopupDetailOnInit extends PopupDetailEvent {
  final int popupId;

  const PopupDetailOnInit(this.popupId) : super._();
}
