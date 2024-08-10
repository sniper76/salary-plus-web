import 'dart:convert';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/stock_summary.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/domain/usecase/admin_stock/get_stock_statistics.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'event.dart';
part 'state.dart';

enum StaticsType {
  // ignore: constant_identifier_names
  STOCK_QUANTITY,
  // ignore: constant_identifier_names
  STAKE,
  // ignore: constant_identifier_names
  MARKET_VALUE,
  // ignore: constant_identifier_names
  MEMBER_COUNT,
}

class CmsBloc extends Bloc<CmsEvent, CmsState> {
  final _getStockStatistics = getIt<GetStockStatistics>();

  List<bool> toggleOpenState(int index) {
    // 새로운 openState 리스트 생성
    final List<bool> updatedOpenState = List.from(state.openState);
    // 지정된 인덱스의 값을 토글
    updatedOpenState[index] = !updatedOpenState[index];
    return updatedOpenState;
  }

  CmsBloc() : super(const CmsState()) {
    on<CmsOnInit>((event, emit) async {
      emit(state.copyWith(
        periodStockQuantityDaliy: event.periodDaliy,
        periodMemberCountDaliy: event.periodDaliy,
        periodMarketValueDaliy: event.periodDaliy,
        periodStakeDaliy: event.periodDaliy,
        periodStockQuantityMonthly: event.periodMonthly,
        periodMemberCountMonthly: event.periodMonthly,
        periodMarketValueMonthly: event.periodMonthly,
        periodStakeMonthly: event.periodMonthly,
      ));
      // 비동기 작업을 동시에 수행
      final List<Future<Result<DataResponse<List<StockSummary>>, Exception>>> requests = [
        _getStockStatistics(
          code: event.stockDetail.solidarity!.code,
          type: StaticsType.STOCK_QUANTITY.name, // "STOCK_QUANTITY",
          periodType: "DAILY",
          period: event.periodDaliy,
        ),
        _getStockStatistics(
          code: event.stockDetail.solidarity!.code,
          type: StaticsType.STOCK_QUANTITY.name, // "STOCK_QUANTITY",
          periodType: "MONTHLY",
          period: event.periodMonthly, // 'M' for monthly
        ),
      ];
      // 두 작업 모두 완료를 기다림
      final results = await Future.wait(requests);

      // 두 작업의 결과를 검사
      if (results.every((result) => result.isSuccess())) {
        final dailyResult = results[0].tryGetSuccess();
        final monthlyResult = results[1].tryGetSuccess();

        // 두 결과 모두 성공적으로 가져왔을 때 상태 업데이트
        emit(state.copyWith(
          isLoading: false,
          isStockQuantity: true,
          openState: toggleOpenState(0),
          stockInfo: event.stockDetail,
          stockQuantityDaliy: dailyResult?.data,
          stockQuantityMonthly: monthlyResult?.data,
        ));
      } else {
        String errorMessages =
            results.where((result) => !result.isSuccess()).map((result) => result.tryGetError().toString()).join(", ");
        emit(state.copyWith(isLoading: false, errorToastMessage: errorMessages));
      }
    });

    on<CmsOnGetStockQuantity>((event, emit) async {
      if (state.stockQuantityDaliy!.isEmpty || state.stockQuantityMonthly!.isEmpty) {
        emit(state.copyWith(isLoading: true));
        // 비동기 작업을 동시에 수행
        final List<Future<Result<DataResponse<List<StockSummary>>, Exception>>> requests = [
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.STOCK_QUANTITY.name, // "STOCK_QUANTITY",
            periodType: "DAILY",
            period: event.periodStockQuantityDaliy,
          ),
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.STOCK_QUANTITY.name, // "STOCK_QUANTITY",
            periodType: "MONTHLY",
            period: event.periodStockQuantityMonthly, // 'M' for monthly
          ),
        ];
        // 두 작업 모두 완료를 기다림
        final results = await Future.wait(requests);

        // 두 작업의 결과를 검사
        if (results.every((result) => result.isSuccess())) {
          final dailyResult = results[0].tryGetSuccess();
          final monthlyResult = results[1].tryGetSuccess();
          emit(state.copyWith(
            isLoading: false,
            stockQuantityDaliy: dailyResult?.data,
            // 추가적인 상태 업데이트 필요 시 여기에 코드를 추가하세요. 예를 들어,
            stockQuantityMonthly: monthlyResult?.data, // 월간 데이터를 상태에 추가할 필요가 있다면
          ));
        } else {
          String errorMessages = results
              .where((result) => !result.isSuccess())
              .map((result) => result.tryGetError().toString())
              .join(", ");
          emit(state.copyWith(isLoading: false, errorToastMessage: errorMessages));
        }
      }
    });

    on<CmsOnGetMemberCount>((event, emit) async {
      if (state.memberCountDaliy!.isEmpty || state.memberCountMonthly!.isEmpty) {
        emit(state.copyWith(isLoading: true));
        // 비동기 작업을 동시에 수행
        final List<Future<Result<DataResponse<List<StockSummary>>, Exception>>> requests = [
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.MEMBER_COUNT.name,
            periodType: "DAILY",
            period: event.periodMemberCountDaliy,
          ),
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.MEMBER_COUNT.name,
            periodType: "MONTHLY",
            period: event.periodMemberCountMonthly,
          ),
        ];
        // 두 작업 모두 완료를 기다림
        final results = await Future.wait(requests);

        // 두 작업의 결과를 검사
        if (results.every((result) => result.isSuccess())) {
          final dailyResult = results[0].tryGetSuccess();
          final monthlyResult = results[1].tryGetSuccess();
          emit(state.copyWith(
            isLoading: false,
            memberCountDaliy: dailyResult?.data,
            memberCountMonthly: monthlyResult?.data,
          ));
        } else {
          String errorMessages = results
              .where((result) => !result.isSuccess())
              .map((result) => result.tryGetError().toString())
              .join(", ");
          emit(state.copyWith(isLoading: false, errorToastMessage: errorMessages));
        }
      }
    });

    on<CmsOnGetMakeValue>((event, emit) async {
      if (state.marketValueDaliy!.isEmpty || state.marketValueMonthly!.isEmpty) {
        emit(state.copyWith(isLoading: true));
        // 비동기 작업을 동시에 수행
        final List<Future<Result<DataResponse<List<StockSummary>>, Exception>>> requests = [
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.MARKET_VALUE.name,
            periodType: "DAILY",
            period: event.periodMarketValueDaliy,
          ),
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.MARKET_VALUE.name,
            periodType: "MONTHLY",
            period: event.periodMarketValueMonthly,
          ),
        ];
        // 두 작업 모두 완료를 기다림
        final results = await Future.wait(requests);

        // 두 작업의 결과를 검사
        if (results.every((result) => result.isSuccess())) {
          final dailyResult = results[0].tryGetSuccess();
          final monthlyResult = results[1].tryGetSuccess();
          emit(state.copyWith(
            isLoading: false,
            marketValueDaliy: dailyResult?.data,
            marketValueMonthly: monthlyResult?.data,
          ));
        } else {
          String errorMessages = results
              .where((result) => !result.isSuccess())
              .map((result) => result.tryGetError().toString())
              .join(", ");
          emit(state.copyWith(isLoading: false, errorToastMessage: errorMessages));
        }
      }
    });

    on<CmsOnGetStake>((event, emit) async {
      if (state.stakeDaliy!.isEmpty || state.stakeMonthly!.isEmpty) {
        emit(state.copyWith(isLoading: true));
        // 비동기 작업을 동시에 수행
        final List<Future<Result<DataResponse<List<StockSummary>>, Exception>>> requests = [
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.STAKE.name,
            periodType: "DAILY",
            period: event.periodStakeDaliy,
          ),
          _getStockStatistics(
            code: state.stockInfo!.solidarity!.code,
            type: StaticsType.STAKE.name,
            periodType: "MONTHLY",
            period: event.periodStakeMonthly,
          ),
        ];
        // 두 작업 모두 완료를 기다림
        final results = await Future.wait(requests);

        // 두 작업의 결과를 검사
        if (results.every((result) => result.isSuccess())) {
          final dailyResult = results[0].tryGetSuccess();
          final monthlyResult = results[1].tryGetSuccess();

          emit(state.copyWith(
            isLoading: false,
            stakeDaliy: dailyResult?.data,
            stakeMonthly: monthlyResult?.data,
          ));
        } else {
          String errorMessages = results
              .where((result) => !result.isSuccess())
              .map((result) => result.tryGetError().toString())
              .join(", ");
          emit(state.copyWith(isLoading: false, errorToastMessage: errorMessages));
        }
      }
    });

    on<CmsOnSetOpenState>((event, emit) async {
      emit(state.copyWith(
        openState: toggleOpenState(event.index),
      ));
    });

    on<CmsOnSetPeriodDaily>((event, emit) async {
      if (event.index == StaticsType.STOCK_QUANTITY) {
        emit(state.copyWith(periodStockQuantityDaliy: event.period, stockQuantityDaliy: []));
        add(CmsEvent.getStockQuantity(state.periodStockQuantityDaliy, state.periodStockQuantityMonthly));
      } else if (event.index == StaticsType.STAKE) {
        emit(state.copyWith(periodStakeDaliy: event.period, stakeDaliy: []));
        add(CmsEvent.getStake(state.periodStakeDaliy, state.periodStakeMonthly));
      } else if (event.index == StaticsType.MEMBER_COUNT) {
        emit(state.copyWith(periodMemberCountDaliy: event.period, memberCountDaliy: []));
        add(CmsEvent.getMemberCount(state.periodMemberCountDaliy, state.periodMemberCountMonthly));
      } else if (event.index == StaticsType.MARKET_VALUE) {
        emit(state.copyWith(periodMarketValueDaliy: event.period, marketValueDaliy: []));
        add(CmsEvent.getMakeValue(state.periodMarketValueDaliy, state.periodMarketValueMonthly));
      }
    });

    on<CmsOnSetPeriodMonthly>((event, emit) async {
      if (event.index == StaticsType.STOCK_QUANTITY) {
        emit(state.copyWith(periodStockQuantityMonthly: event.period, stockQuantityMonthly: []));
        add(CmsEvent.getStockQuantity(state.periodStockQuantityDaliy, state.periodStockQuantityMonthly));
      } else if (event.index == StaticsType.STAKE) {
        emit(state.copyWith(periodStakeMonthly: event.period, stakeMonthly: []));
        add(CmsEvent.getStake(state.periodStakeDaliy, state.periodStakeMonthly));
      } else if (event.index == StaticsType.MEMBER_COUNT) {
        emit(state.copyWith(periodMemberCountMonthly: event.period, memberCountMonthly: []));
        add(CmsEvent.getMemberCount(state.periodMemberCountDaliy, state.periodMemberCountMonthly));
      } else if (event.index == StaticsType.MARKET_VALUE) {
        emit(state.copyWith(periodMarketValueMonthly: event.period, marketValueMonthly: []));
        add(CmsEvent.getMakeValue(state.periodMarketValueDaliy, state.periodMarketValueMonthly));
      }
    });
  }
}
