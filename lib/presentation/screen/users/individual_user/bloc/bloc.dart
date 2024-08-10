import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/enum/user_search_category.dart';
import 'package:act_cms/domain/model/enum/user_filter_type.dart';
import 'package:act_cms/domain/model/enum/user_sort_type.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/user_search/user_filter_type_wrapper.dart';
import 'package:act_cms/domain/model/enum_wrapper/search_control_enum_wrapper/user_search/user_sort_type_wrapper.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_users/assign_admin.dart';
import 'package:act_cms/domain/usecase/admin_users/get_users.dart';
import 'package:act_cms/domain/usecase/admin_users/revoke_admin_user.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _getUsers = getIt<GetUsers>();
  final _revokeUser = getIt<RevokeAdminUser>();
  final _assignAdmin = getIt<AssignAdmin>();

  UsersBloc() : super(UsersState()) {
    on<UsersOnInit>(
      (event, emit) async {
        add(const UsersEvent.refresh());
      },
    );

    on<UsersRefresh>(
      (event, emit) async {
        emit(state.copyWith(
          isLoading: true,
        ));
        try {
          add(UsersEvent.fetchUsers(
            page: state.paging.page,
            size: state.paging.size,
          ));
        } catch (e) {
          emit(state.copyWith(isLoading: false, errorToastMessage: e.toString()));
        }
      },
    );

    on<UsersSetRefresh>((event, emit) {
      emit(state.copyWith(
        refreshPage: !state.refreshPage,
      ));
    });

    on<UsersOnSelectCategory>((event, emit) {
      emit(state.copyWith(
        selectedCategory: event.selectedCategory,
      ));
    });

    on<FetchUsers>((FetchUsers event, emit) async {
      emit(state.copyWith(isLoading: true));

      final Result result = await _fetchUsers(
        page: event.page,
        size: event.size,
        searchKeyword: event.searchKeyword,
        userSearchCategory: event.searchCategory,
        userSortType: event.sortType ?? state.selectedSortType,
        userFilterType: event.filterType ?? state.selectedFilterType,
      );

      if (result.isSuccess()) {
        final DataResponse<List<User>>? succeededResponse = result.tryGetSuccess();
        emit(state.copyWith(
          isLoading: false,
          searchKeyword: event.searchKeyword ?? state.searchKeyword,
          selectedCategory: event.searchCategory ?? state.selectedCategory,
          userDataList: succeededResponse?.data ?? state.userDataList,
          paging: succeededResponse?.paging ?? state.paging,
          refreshPage: false,
          totalCount: succeededResponse?.paging?.total ?? state.totalCount,
          selectedSortType: event.sortType ?? state.selectedSortType,
          selectedFilterType: event.filterType ?? state.selectedFilterType,
        ));
      } else {
        final Exception? failedResponse = result.tryGetError();
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: failedResponse.toString(),
          refreshPage: true,
        ));
      }
    });

    on<UsersOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }

      add(UsersEvent.fetchUsers(
        page: event.page,
      ));
    });

    on<AddRoleToUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _revokeUser(userId: event.userId);

      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          refreshPage: !state.refreshPage,
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    });

    on<AssignAdminEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _assignAdmin(userId: event.userId);

      if (res.isSuccess()) {
        emit(state.copyWith(
          isLoading: false,
          refreshPage: !state.refreshPage,
        ));
      } else {
        emit(state.copyWith(isLoading: false, errorToastMessage: res.tryGetError().toString()));
      }
    });

    on<ChangeSortType>((event, emit) async {
      if (state.selectedSortType == event.changedSortType) return;
      emit(state.copyWith(isLoading: true));

      add(UsersEvent.fetchUsers(
        sortType: event.changedSortType,
      ));
    });

    on<ChangeFilterType>((event, emit) async {
      if (state.selectedFilterType == event.changedFilterType) return;
      emit(state.copyWith(isLoading: true));

      add(UsersEvent.fetchUsers(
        filterType: event.changedFilterType,
      ));
    });
  }

  Future<Result<DataResponse<List<User>>, Exception>> _fetchUsers({
    int? page,
    int? size,
    String? searchKeyword,
    UserSearchCategory? userSearchCategory,
    UserSortType? userSortType,
    UserFilterType? userFilterType,
  }) {
    return _getUsers(
      page: page ?? 1,
      size: size ?? 10,
      searchKeyword: searchKeyword ?? state.searchKeyword,
      searchType: userSearchCategory?.value ?? state.selectedCategory.value,
      sorts: userSortType?.queryValue ?? state.selectedSortType.queryValue,
      filterType: userFilterType?.queryValue ?? state.selectedFilterType.queryValue,
    );
  }
}
