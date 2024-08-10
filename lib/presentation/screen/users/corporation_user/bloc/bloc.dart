import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/enum/corporation_search_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/usecase/admin_users/get_corporations.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_state.dart';

part 'event.dart';
part 'state.dart';

class CorporationListBloc extends Bloc<CorporationListEvent, CorporationListState> {
  final _getCorporations = getIt<GetCorporations>();

  CorporationListBloc() : super(const CorporationListState()) {
    on<OnInit>(onInit);
    on<OnSetSearchType>(onSetSearchType);
    on<OnGetCorporationList>(onGetCorporationList);
  }

  void onInit(OnInit event, emit) {
    add(const CorporationListEvent.onGetCorporationList());
  }

  void onSetSearchType(OnSetSearchType event, emit) {}

  void onGetCorporationList(OnGetCorporationList event, emit) async {
    emit(state.copyWith(isLoading: true));

    final acceptanceList = await _getCorporations(
      searchType: event.searchType?.value ?? CorporationSearchType.corporationName.value,
      searchKeyword: event.searchKeyword ?? '',
      page: event.page ?? 1,
      size: apiLoadSize,
    );

    emit(state.copyWith(
      isLoading: false,
      corporations: acceptanceList.isSuccess() ? acceptanceList.tryGetSuccess()?.data ?? [] : null,
      errorToastMessage: acceptanceList.tryGetError()?.toString(),
      paging: acceptanceList.isSuccess() ? acceptanceList.tryGetSuccess()?.paging : null,
    ));
  }
}
