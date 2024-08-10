part of 'bloc.dart';

@immutable
abstract class CorporationRegisterEvent {
  const CorporationRegisterEvent._();

  const factory CorporationRegisterEvent.onRegisterCorporation({
    required String corporationName,
    required String registerNumber,
  }) = OnRegisterCorporation;

  const factory CorporationRegisterEvent.onUpdateCorporationUser({
    required int corporateId,
    required String corporateName,
    required String corporateNo,
  }) = OnUpdateCorporationUser;
}

class OnRegisterCorporation extends CorporationRegisterEvent {
  final String corporationName;
  final String registerNumber;

  const OnRegisterCorporation({required this.corporationName, required this.registerNumber}) : super._();
}

class OnUpdateCorporationUser extends CorporationRegisterEvent {
  final int corporateId;
  final String corporateName;
  final String corporateNo;

  const OnUpdateCorporationUser({
    required this.corporateId,
    required this.corporateName,
    required this.corporateNo,
  }) : super._();
}
