import 'dart:async';
import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/paging.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/model/user_stock_data.dart';
import 'package:act_cms/domain/usecase/admin_stock/delete_dummy_stock.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_dummy_stocks.dart';
import 'package:act_cms/domain/usecase/admin_users/download_confidential.dart';
import 'package:act_cms/domain/usecase/admin_users/get_user_detail.dart';
import 'package:act_cms/domain/usecase/admin_users/get_user_stocks.dart';
import 'package:act_cms/domain/usecase/admin_users/update_user_nickname.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:path/path.dart';

part 'event.dart';
part 'state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final _getUserStocks = getIt<GetUserStocks>();
  final _getDummyStocks = getIt<GetUserDummyStocks>();
  final _getUserDetail = getIt<GetUserDetail>();
  final _updateUserNickName = getIt<UpdateUserNickName>();
  final _deleteDummyStock = getIt<DeleteDummyStock>();
  final _downloadConfidential = getIt<DownloadConfidential>();

  final int userId;

  UserDetailBloc(this.userId) : super(UserDetailState(userId: userId)) {
    on<UserDetailOnInit>(onUserDetailOnInit);

    on<UserDetailOnLoadMore>((event, emit) async {
      if (state.isLoading) {
        return;
      }

      emit(state.copyWith(isLoading: true));

      final res = await _fetchUserStockData(
        userId: userId,
        page: event.page,
        size: event.size,
        sort: event.sorts,
      );
      final pagingData = res.tryGetSuccess();
      final newList = pagingData?.data ?? [];

      emit(state.copyWith(
        isLoading: false,
        paging: pagingData?.paging,
        userStockData: newList,
      ));
    });

    on<UserDetailOnUpdateNickname>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final userDataRes = await _updateUserNickName(userId: userId, nickname: event.nickname);

      if (userDataRes.isSuccess()) {
        final user = userDataRes.tryGetSuccess();
        emit(state.copyWith(userData: user, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    });

    on<UserAddDummyStock>((event, emit) {
      emit(state.copyWith(userStockDummyData: [...state.userStockDummyData, event.dummyStock]));
    });

    on<FetchUserDummyStocks>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      final res = await _getDummyStocks(
        userId: userId,
        page: event.page ?? state.dummyPaging.page,
        size: event.size ?? state.dummyPaging.size,
      );

      final pagingData = res.tryGetSuccess();
      final dummyStocks = pagingData?.data ?? [];

      emit(state.copyWith(
        isLoading: false,
        dummyPaging: pagingData?.paging,
        userStockDummyData: dummyStocks,
        errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
      ));
    });

    on<UserDeleteDummyStock>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final stockCode = event.stockCode;
      final res = await _deleteDummyStock(userId: userId, stockCode: stockCode);

      emit(state.copyWith(
        isLoading: false,
        userStockDummyData: res.isSuccess()
            ? state.userStockDummyData.where((stock) => stock.code != stockCode).toList()
            : state.userStockDummyData,
        errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
      ));
    });

    on<UserDetailOnDownLoadConfidential>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      final res = await _downloadConfidential(userId: userId);

      if (res.isSuccess()) {
        emit(state.copyWith(
          confidentialDownloadLink: res.tryGetSuccess(),
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorToastMessage: res.isError() ? res.tryGetError().toString() : null,
        ));
      }
    });
  }

  Future<Result<DataResponse<List<UserStockData>>, Exception>> _fetchUserStockData({
    required int userId,
    int? page,
    int? size,
    String? sort,
  }) {
    return _getUserStocks(
      userId: userId,
      page: page ?? 1,
      size: size ?? 10,
      sort: sort,
    );
  }

  FutureOr<void> onUserDetailOnInit(event, emit) async {
    emit(state.copyWith(isLoading: true));
    add(UserDetailEvent.fetchUserDummyStocks(userId: userId));

    final userDataRes = await _getUserDetail(userId: userId);

    if (userDataRes.isSuccess()) {
      final user = userDataRes.tryGetSuccess();
      emit(state.copyWith(userData: user));
    }

    final userStockDataRes = await _fetchUserStockData(userId: userId, size: apiLoadSize);

    if (userStockDataRes.isSuccess()) {
      final userStockData = userStockDataRes.tryGetSuccess();
      emit(state.copyWith(isLoading: false, userStockData: userStockData?.data, paging: userStockData?.paging));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
