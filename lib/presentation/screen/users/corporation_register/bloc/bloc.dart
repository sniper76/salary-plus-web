import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/usecase/admin_users/create_corporation.dart';
import 'package:act_cms/domain/usecase/admin_users/update_corporation.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';

part 'event.dart';
part 'state.dart';

class CorporationRegisterBloc extends Bloc<CorporationRegisterEvent, CorporationRegisterState> {
  final _eventBus = getIt<IEventBus>();
  final _createCorporation = getIt<CreateCorporation>();
  final _updateCorporation = getIt<UpdateCorporation>();

  CorporationRegisterBloc() : super(const CorporationRegisterState()) {
    on<OnRegisterCorporation>(onRegisterCorporation);
    on<OnUpdateCorporationUser>(onUpdateCorporationUser);
  }

  void onRegisterCorporation(OnRegisterCorporation event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _createCorporation(corporateName: event.corporationName, corporateNo: event.registerNumber);

    emit(state.copyWith(
      isComplete: res.isSuccess(),
      isLoading: false,
      errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
    ));
  }

  void onUpdateCorporationUser(OnUpdateCorporationUser event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _updateCorporation(
      corporateId: event.corporateId,
      corporateName: event.corporateName,
      corporateNo: event.corporateNo,
    );

    if (res.isSuccess()) {
      final data = res.tryGetSuccess()?.data;
      _eventBus.fire(CorporationUserDetailChangedEvent(
        corporationName: data!.corporateName,
        corporationNo: data!.corporateNo,
      ));
    }

    emit(state.copyWith(
      isComplete: res.isSuccess(),
      isLoading: false,
      errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
    ));
  }
}
