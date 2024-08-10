import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/usecase/admin_popup/find_popup.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'event.dart';
part 'state.dart';

class PopupDetailBloc extends Bloc<PopupDetailEvent, PopupDetailState> {
  final _getPopup = getIt<FindPopup>();

  PopupDetailBloc() : super(const PopupDetailState()) {
    on<PopupDetailOnInit>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final res = await _getPopup(popupId: event.popupId);

      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          updatePopup: res.tryGetSuccess()?.data,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.tryGetError().toString(),
        ));
      }
    });
  }
}
