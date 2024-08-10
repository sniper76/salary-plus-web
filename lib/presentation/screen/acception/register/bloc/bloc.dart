import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/accept_user.dart';
import 'package:act_cms/domain/model/enum/corporation_search_type.dart';
import 'package:act_cms/domain/model/enum/user_search_category.dart';
import 'package:act_cms/domain/model/enum/user_type.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/usecase/admin_acceptor/assign_accept_user.dart';
import 'package:act_cms/domain/usecase/admin_users/get_corporations.dart';
import 'package:act_cms/domain/usecase/admin_users/get_users.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:event_bus_plus/event_bus_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class RegisterAcceptUserBloc extends Bloc<RegisterAcceptUserEvent, RegisterAcceptUserState> {
  final _eventBus = getIt<IEventBus>();
  final _getCorporations = getIt<GetCorporations>();
  final _getUsers = getIt<GetUsers>();
  final _assignAcceptUser = getIt<AssignAcceptUser>();

  RegisterAcceptUserBloc() : super(const RegisterAcceptUserState()) {
    on<OnInit>(_onInit);
    on<OnChangeCategories>(_onChangeCategories);
    on<OnChangeSearchKeyword>(_onChangeSearchKeyword);
    on<OnGetUserList>(_onGetUserList);
    on<OnSearchCorporationList>(_onSearchCorporationList);
    on<OnSearchIndividualList>(_onSearchIndividualList);
    on<OnChangePaging>(_onChangePaging);
    on<OnAssignAcceptUser>(_onAssignAcceptUser);
  }

  void _onInit(OnInit event, emit) {}

  void _onChangeCategories(OnChangeCategories event, emit) {
    emit(state.copyWith(
      userType: event.userType ?? state.userType,
      searchKeyword: event.userType != null ? '' : state.searchKeyword,
      paging: event.userType != null ? const Paging(total: 1) : state.paging,
      corporationSearchType: event.corporationSearchType ?? state.corporationSearchType,
      individualSearchType: event.individualSearchType ?? state.individualSearchType,
    ));
  }

  void _onChangeSearchKeyword(OnChangeSearchKeyword event, emit) {
    emit(state.copyWith(searchKeyword: event.searchKeyword));
  }

  void _onGetUserList(OnGetUserList event, emit) {
    if (state.userType == UserType.corporation) add(const RegisterAcceptUserEvent.onSearchCorporationList());
    if (state.userType == UserType.individual) add(const RegisterAcceptUserEvent.onSearchIndividualList());
  }

  void _onSearchCorporationList(OnSearchCorporationList event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _getCorporations(
      searchKeyword: state.searchKeyword,
      page: state.paging.page,
      size: state.paging.size,
      searchType: state.corporationSearchType.value,
    );

    final corporations = res
        .tryGetSuccess()
        ?.data
        ?.map(
          (corporation) => AcceptUser(
            userId: corporation.userId,
            name: corporation.corporateName,
            uniqueNumber: corporation.corporateNo,
            isSolidarityLeader: corporation.leadingSolidarityStockCodes.isNotEmpty,
          ),
        )
        .toList();

    emit(state.copyWith(
      isLoading: false,
      acceptUser: corporations,
      errorToastMessage: res.tryGetError()?.toString(),
      paging: res.isSuccess() ? res.tryGetSuccess()?.paging : null,
    ));
  }

  void _onSearchIndividualList(OnSearchIndividualList event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _getUsers(
      searchType: state.individualSearchType.value,
      searchKeyword: state.searchKeyword,
      page: state.paging.page,
      size: state.paging.size,
    );

    final users = res
        .tryGetSuccess()
        ?.data
        ?.map(
          (user) => AcceptUser(
            userId: user.id,
            name: user.name,
            uniqueNumber: user.phoneNumber,
            nickname: user.nickname,
            email: user.email,
            profileImageUrl: user.profileImageUrl,
            isAdmin: user.isAdmin,
            isSolidarityLeader: user.isSolidarityLeader,
          ),
        )
        .toList();

    emit(state.copyWith(
      isLoading: false,
      acceptUser: users,
      errorToastMessage: res.tryGetError()?.toString(),
      paging: res.isSuccess() ? res.tryGetSuccess()?.paging : null,
    ));
  }

  void _onChangePaging(OnChangePaging event, emit) {
    emit(state.copyWith(paging: state.paging.copyWith(page: event.page)));
    add(const RegisterAcceptUserEvent.onGetUserList());
  }

  void _onAssignAcceptUser(OnAssignAcceptUser event, emit) async {
    emit(state.copyWith(isLoading: true));

    final res = await _assignAcceptUser(code: event.stockCode, userId: event.acceptUser.userId);

    if (res.isSuccess()) _eventBus.fire(AcceptUserChangeEvent(event.acceptUser));

    emit(state.copyWith(
      isLoading: false,
      isComplete: res.isSuccess(),
      errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
    ));
  }
}
