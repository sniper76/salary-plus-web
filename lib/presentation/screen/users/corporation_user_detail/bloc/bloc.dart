import 'dart:async';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/enum/corporation_search_type.dart';
import 'package:bloc/bloc.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_state.dart';

part 'event.dart';
part 'state.dart';

class CorporationDetailBloc extends Bloc<CorporationDetailEvent, CorporationDetailState> {
  final CorporationUser corporationUser;
  late StreamSubscription _corporationChangeEventSubscription;
  final _eventBus = getIt<IEventBus>();

  CorporationDetailBloc(this.corporationUser) : super(CorporationDetailState(corporationUser: corporationUser)) {
    on<OnInit>(onInit);
    _corporationChangeEventSubscription = _eventBus.on<CorporationUserDetailChangedEvent>().listen((e) {
      final updatedCorporationUser = state.corporationUser.copyWith(
        corporateNo: e.corporationNo,
        corporateName: e.corporationName,
      );
      emit(state.copyWith(corporationUser: updatedCorporationUser));
    });
  }

  void onInit(OnInit event, emit) {}
}
