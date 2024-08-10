import 'dart:async';

import 'package:act_cms/core/injection.dart';
import 'package:act_cms/core/service/cms_commons_service.dart';
import 'package:act_cms/data/response/data_response.dart';
import 'package:act_cms/domain/model/dashboard_age_statistics.dart';
import 'package:act_cms/domain/model/dashboard_gender_statistics.dart';
import 'package:act_cms/domain/model/dashboard_statistics.dart';
import 'package:act_cms/domain/model/searching.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/usecase/admin_statistics/get_age_statistics.dart';
import 'package:act_cms/domain/usecase/admin_statistics/get_gender_statistics.dart';
import 'package:act_cms/domain/usecase/admin_statistics/get_statistics.dart';
import 'package:act_cms/presentation/base/base_state.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:multiple_result/multiple_result.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final _cmsCommonsData = getIt<CMSCommonsService>();
  final _basicStatics = getIt<GetStatistics>();
  final _genderStatics = getIt<GetGenderStatistics>();
  final _ageStatics = getIt<GetAgeStatistics>();
  static List<String> orderBasic = [
    'DAILY_USER_REGISTRATION_COUNT',
    'DAILY_USER_WITHDRAWAL_COUNT',
    'DAILY_ACTIVE_USER',
    'MONTHLY_ACTIVE_USER',
    'DAILY_TOTAL_ASSET_PRICE',
    'DAILY_USER_LOGIN_COUNT',
    'DAILY_USER_REUSE_RATE',
    'DAILY_POST_VIEW_COUNT',
    'DAILY_USER_ACCESS_PIN_NUMBER_COUNT',
  ];
  static List<String> orderStock = [
    'DAILY_STOCK_POST_COUNT',
    'DAILY_STOCK_COMMENT_COUNT',
    'DAILY_STOCK_USER_HOLDING_COUNT',
    'DAILY_STOCK_MEMBER_COUNT',
    'DAILY_STOCK_LIKED_COUNT',
  ];

  void sortStatisticsList(List<DashboardStatistics> statsList, List<String> order) {
    // 순서에 따라 항목을 정렬
    statsList.sort((a, b) {
      int indexA = order.indexOf(a.type);
      int indexB = order.indexOf(b.type);

      if (indexA == -1) indexA = order.length;
      if (indexB == -1) indexB = order.length;

      return indexA.compareTo(indexB);
    });
  }

  DashboardBloc() : super(const DashboardState()) {
    on<DashboardOnInit>(onDashboardOnMonthly);

    on<DashboardOnMonthly>(onDashboardOnMonthly);
    on<DashboardOnDaily>(onDashboardOnDaliy);
    on<PostOnGetStockStats>(onDashboardOnStockData);
    on<PostOnGetAllStockStats>(onDashboardOnAllStockData);

    on<DashboardOnSelectCategory>((event, emit) {
      emit(state.copyWith(
        selectedCategory: event.selectedCategory,
      ));
    });

    on<PostOnSetSimpleStock>((event, emit) async {
      emit(state.copyWith(
        selectedSimpleStock: event.stock,
      ));
    });

    on<PostOnSetTargetSearchKeyword>((event, emit) async {
      if (event.searchKeyword == "") {
        emit(state.copyWith(
          targetCandidateStockList: [],
        ));
      } else {
        final candidatedStockList = _cmsCommonsData.cmsCommons?.stocks
            .where((stock) {
              String searchKeywordLower = event.searchKeyword.toLowerCase();
              String stockCodeLower = stock.code.toLowerCase();
              String stockNameLower = stock.name.toLowerCase();

              return stockCodeLower.startsWith(searchKeywordLower) ||
                  (searchKeywordLower.length >= 2 && stockNameLower.contains(searchKeywordLower));
            })
            .map((data) => SimpleStock(code: data.code, name: data.name))
            .toList();

        emit(state.copyWith(
          targetCandidateStockList: candidatedStockList,
        ));
      }
    });
  }

  String subtractMonths(String dateStr, int months) {
    // 문자열을 DateTime 객체로 변환
    DateTime date = DateTime.parse("$dateStr-01");

    // 연도와 월을 계산
    int year = date.year;
    int month = date.month - months;

    // 월이 1보다 작아질 경우 연도를 조정
    while (month <= 0) {
      year -= 1;
      month += 12; // 한 해는 12개월이므로, 12를 더합니다.
    }

    // 새로운 날짜 객체 생성
    DateTime newDate = DateTime(year, month);

    // 날짜를 문자열로 변환 (yyyy-MM 형식)
    return "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}";
  }

  String? addMonthsConditional(String dateStr, int months) {
    // 문자열을 DateTime 객체로 변환
    DateTime date = DateTime.parse("$dateStr-01");

    // 연도와 월을 계산
    int year = date.year;
    int month = date.month + months;

    // 월이 12를 초과하는 경우 연도를 조정
    while (month > 12) {
      year += 1;
      month -= 12;
    }

    // 새로운 날짜 객체 생성
    DateTime newDate = DateTime(year, month);

    // 현재 날짜의 연도와 월만 추출
    DateTime now = DateTime.now();
    DateTime currentMonth = DateTime(now.year, now.month);

    // 새로운 날짜가 현재 월보다 큰 경우에만 문자열 반환
    if (newDate.isAfter(currentMonth)) {
      return null;
    } else {
      return "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}";
    }
  }

  FutureOr<void> onDashboardOnMonthly(event, emit) async {
    if (state.isLoading) return;
    emit(state.copyWith(
      isLoading: true,
    ));

    String? searchFrom;
    String? searchTo;

    if (event.mode == "previous") {
      if (state.search?.from == null) return;
      searchFrom = subtractMonths(state.search!.from!, 6);
      searchTo = state.search!.from!;
    } else if (event.mode == "next") {
      if (state.search?.to == null) return;
      searchFrom = state.search?.to;
      searchTo = addMonthsConditional(state.search!.to!, 6);
      if (searchTo == null) searchFrom = null;
    }

    // 분류된 데이터를 저장할 두 개의 리스트 초기화
    List<DashboardStatistics> stockStatsMonthly = [];
    List<DashboardStatistics> basicStatsMonthly = [];
    Searching? search;
    DashboardGenderStatistics? genderStatsMonthly;
    DashboardAgeStatistics? ageStatsMonthly;

    final res = await fetchBasic(
      stockCode: state.selectedSimpleStock?.code,
      periodType: "MONTHLY",
      searchFrom: searchFrom,
      searchTo: searchTo,
    );
    final data = res.tryGetSuccess();

    if (res.isSuccess()) {
      // data.data를 순회하면서 항목을 분류
      for (var item in data!.data ?? []) {
        if (item.type.startsWith("DAILY_STOCK")) {
          stockStatsMonthly.add(item);
        } else {
          basicStatsMonthly.add(item);
        }
      }
      sortStatisticsList(basicStatsMonthly, orderBasic);
      sortStatisticsList(stockStatsMonthly, orderStock);
      search = data.search;
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        errorToastMessage: err.toString(),
      ));
    }

    final resGender = await _genderStatics(
      periodType: "MONTHLY",
      searchFrom: searchFrom,
      searchTo: searchTo,
    );
    final dataGender = resGender.tryGetSuccess();

    if (res.isSuccess()) {
      genderStatsMonthly = dataGender;
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        errorToastMessage: err.toString(),
      ));
    }

    final resAge = await _ageStatics(
      periodType: "MONTHLY",
      searchFrom: searchFrom,
      searchTo: searchTo,
    );

    if (res.isSuccess()) {
      ageStatsMonthly = resAge.tryGetSuccess();
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        errorToastMessage: err.toString(),
      ));
    }
    emit(state.copyWith(
      stockStatsMonthly: stockStatsMonthly,
      basicStatsMonthly: basicStatsMonthly,
      ageStatsMonthly: ageStatsMonthly,
      search: search,
      genderStatsMonthly: genderStatsMonthly,
      isLoading: false,
    ));
  }

  String subtractSevenDays(String dateStr, int days) {
    DateTime date = DateTime.parse(dateStr);
    DateTime newDate = date.subtract(Duration(days: days));
    return "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
  }

  String? addSevenDaysConditional(String dateStr, int days) {
    DateTime date = DateTime.parse(dateStr);
    DateTime newDate = date.add(Duration(days: days));

    // 현재 날짜의 연도, 월, 일만 추출
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);

    // 계산된 날짜가 현재 날짜보다 이후인 경우 null 반환
    if (newDate.isAfter(currentDate)) {
      return null;
    } else {
      return "${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}";
    }
  }

  FutureOr<void> onDashboardOnDaliy(event, emit) async {
    const periodType = "DAILY";
    emit(state.copyWith(isLoading: true));

    List<DashboardStatistics> stockStatsDaily = [];
    List<DashboardStatistics> basicStatsDaily = [];
    Searching? search;
    DashboardGenderStatistics? genderStatsDaily;
    DashboardAgeStatistics? ageStatsDaily;

    String? searchFrom;
    String? searchTo;

    if (event.mode == "previous") {
      if (state.search?.from == null) return;
      searchFrom = subtractSevenDays(state.search!.from!, 6);
      searchTo = state.search!.from!;
    } else if (event.mode == "next") {
      if (state.search?.to == null) return;
      searchFrom = state.search?.to;
      searchTo = addSevenDaysConditional(state.search!.to!, 6);
      if (searchTo == null) searchFrom = null;
    }

    final res = await fetchBasic(
      stockCode: state.selectedSimpleStock?.code,
      periodType: periodType,
      searchFrom: searchFrom,
      searchTo: searchTo,
    );
    final data = res.tryGetSuccess();

    if (res.isSuccess()) {
      // 분류된 데이터를 저장할 두 개의 리스트 초기화
      List<DashboardStatistics> stockStats = [];
      List<DashboardStatistics> basicStats = [];

      // data.data를 순회하면서 항목을 분류
      for (var item in data!.data ?? []) {
        if (item.type.startsWith("DAILY_STOCK")) {
          stockStats.add(item);
        } else {
          basicStats.add(item);
        }
      }
      sortStatisticsList(basicStats, orderBasic);
      sortStatisticsList(stockStats, orderStock);

      stockStatsDaily = stockStats;
      basicStatsDaily = basicStats;
      search = data.search;

      // 상태 업데이트
      // emit(state.copyWith(
      //   stockStatsDaily: stockStats,
      //   basicStatsDaily: basicStats,
      //   search: data.search,
      // ));
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        errorToastMessage: err.toString(),
      ));
    }

    final resGender = await _genderStatics(
      periodType: periodType,
      searchFrom: searchFrom,
      searchTo: searchTo,
    );
    final dataGender = resGender.tryGetSuccess();

    if (res.isSuccess()) {
      genderStatsDaily = dataGender;
      // emit(state.copyWith(
      //   genderStatsDaily: dataGender,
      // ));
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        errorToastMessage: err.toString(),
      ));
    }

    final resAge = await _ageStatics(
      periodType: periodType,
      searchFrom: searchFrom,
      searchTo: searchTo,
    );
    final dataAge = resAge.tryGetSuccess();

    if (res.isSuccess()) {
      ageStatsDaily = dataAge;
      // emit(state.copyWith(
      //   ageStatsDaily: dataAge,
      // ));
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        errorToastMessage: err.toString(),
      ));
    }

    emit(state.copyWith(
      stockStatsDaily: stockStatsDaily,
      basicStatsDaily: basicStatsDaily,
      search: search,
      genderStatsDaily: genderStatsDaily,
      ageStatsDaily: ageStatsDaily,
      isLoading: false,
    ));
  }

  FutureOr<void> onDashboardOnAllStockData(event, emit) async {
    String periodType = state.selectedCategory;
    emit(state.copyWith(isLoading: true, clearSelectedSimpleStock: true));

    final res = await fetchBasic(
      periodType: periodType,
      stockCode: null,
      searchFrom: state.search?.from,
      searchTo: state.search?.to,
    );
    final data = res.tryGetSuccess();

    if (res.isSuccess()) {
      emit(state.copyWith(
        isLoading: false,
        basicStatsDaily: data!.data,
      ));
    }

    if (res.isSuccess()) {
      // 분류된 데이터를 저장할 두 개의 리스트 초기화
      List<DashboardStatistics> stockStats = [];

      // data.data를 순회하면서 항목을 분류
      for (var item in data!.data ?? []) {
        if (item.type.startsWith("DAILY_STOCK")) {
          stockStats.add(item);
        }
      }

      sortStatisticsList(stockStats, orderStock);

      // 상태 업데이트
      if (periodType == "DAILY") {
        emit(state.copyWith(
          isLoading: false,
          stockStatsDaily: stockStats,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          stockStatsMonthly: stockStats,
        ));
      }
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: err.toString(),
      ));
    }
  }

  FutureOr<void> onDashboardOnStockData(event, emit) async {
    String periodType = state.selectedCategory;
    emit(state.copyWith(isLoading: true, selectedSimpleStock: event.stock));

    final res = await fetchBasic(
      periodType: periodType,
      stockCode: event.stock.code,
      searchFrom: state.search?.from,
      searchTo: state.search?.to,
    );
    // state.selectedSimpleStock?.code
    final data = res.tryGetSuccess();

    if (res.isSuccess()) {
      emit(state.copyWith(
        isLoading: false,
        basicStatsDaily: data!.data,
      ));
    }

    if (res.isSuccess()) {
      // 분류된 데이터를 저장할 두 개의 리스트 초기화
      List<DashboardStatistics> stockStats = [];
      List<DashboardStatistics> basicStats = [];

      // data.data를 순회하면서 항목을 분류
      for (var item in data!.data ?? []) {
        if (item.type.startsWith("DAILY_STOCK")) {
          stockStats.add(item);
        } else {
          basicStats.add(item);
        }
      }

      sortStatisticsList(stockStats, orderStock);
      // sortStatisticsList(basicStats, orderBasic);

      // 상태 업데이트
      if (periodType == "DAILY") {
        emit(state.copyWith(
          isLoading: false,
          stockStatsDaily: stockStats,
          // basicStatsDaily: basicStats,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          stockStatsMonthly: stockStats,
          // basicStatsDaily: basicStats,
        ));
      }
    } else {
      final err = res.tryGetError();
      emit(state.copyWith(
        isLoading: false,
        errorToastMessage: err.toString(),
      ));
    }
  }

  Future<Result<DataResponse<List<DashboardStatistics>>, Exception>> fetchBasic({
    required String periodType,
    String? type,
    String? searchFrom,
    String? searchTo,
    String? stockCode,
  }) {
    return _basicStatics(
      type: type ?? "DashboardStatisticsType",
      periodType: periodType,
      stockCode: stockCode,
      searchFrom: searchFrom,
      searchTo: searchTo,
    );
  }
}

// String? searchFrom, String? searchTo
