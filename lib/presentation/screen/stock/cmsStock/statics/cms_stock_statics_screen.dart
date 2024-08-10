import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/dashboard_item.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/domain/model/stock_summary.dart';
import 'package:act_cms/domain/model/variation.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/stock/cmsStock/statics/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/dashboard_list_item.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const Color tickLabelColor = Color(0xff999999);

@RoutePage()
class CmsStockStaticsScreen extends StatefulWidget {
  final StockDetail param;

  const CmsStockStaticsScreen({super.key, required this.param});

  @override
  State<CmsStockStaticsScreen> createState() => _CmsState();
}

class _CmsState extends State<CmsStockStaticsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  String getCurrentYear() {
    DateTime now = DateTime.now();
    return now.toFormatString(pattern: "yyyy"); // 현재 연도만 (예: "2023")
  }

  String getCurrentYearMonth() {
    DateTime now = DateTime.now();
    return now.toFormatString(pattern: "yyyyMM"); // 현재 연도와 월 (예: "202311")
  }

  String formatDateString(String dateString) {
    try {
      DateTime parsedDate = DateTime.parse(dateString);
      return parsedDate.toFormatString(pattern: "MM/dd");
    } catch (e) {
      return dateString; // 형식 변환에 실패한 경우 원본 문자열 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CmsBloc, CmsState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CmsBloc()
        ..add(
          CmsEvent.init(widget.param, getCurrentYearMonth(), getCurrentYear()),
          // CmsEvent.init(widget.param, "202310", getCurrentYear()),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildCmsStockStaticscreen(context, bloc, state);
      },
    );
  }

  String formatPhoneNumber(String rawNumber) {
    // 숫자만 포함된 문자열을 기대합니다.
    if (rawNumber.length == 11) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 7)}-${rawNumber.substring(7, 11)}';
    } else if (rawNumber.length == 10) {
      // 일부 번호는 10자리일 수 있습니다.
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 6)}-${rawNumber.substring(6, 10)}';
    }
    return rawNumber; // 다른 길이의 번호는 수정하지 않고 반환합니다.
  }

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "-";
    } else {
      // 'yyyy-MM-dd  HH:mm' 형태로 포맷합니다.
      return dateTime.toFormatString(pattern: dateTimeFormatPattern2);
    }
  }

  String formatAssetAmount(int? amount) {
    if (amount == null) {
      return "-";
    } else if (amount >= 10000) {
      // 만 단위 이하가 모두 0인지 확인합니다.
      final numberFormat = NumberFormat('#,###', 'ko_KR');
      // 금액을 만으로 나누고 정수부만 취합니다.
      final formattedAmount = numberFormat.format(amount ~/ 10000);
      return '$formattedAmount만원';
    } else {
      final numberFormat = NumberFormat('#,###', 'ko_KR');
      return '${numberFormat.format(amount)}원';
    }
  }

  Widget _buildCmsStockStaticscreen(BuildContext context, CmsBloc bloc, CmsState state) {
    return BlocListener<CmsBloc, CmsState>(
      listenWhen: (previousState, currentState) {
        return previousState.stockQuantityDaliy != currentState.stockQuantityDaliy ||
            previousState.stockQuantityMonthly != currentState.stockQuantityMonthly;
      },
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(
          context: context,
          mainTitle: '${widget.param.solidarity!.name} ${widget.param.solidarity!.code}',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                _buildUserProfile(context, bloc, state),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, CmsBloc bloc, CmsState state) {
    // const heightSpace = 16.0;
    // const checkIconSpace = 16.0;
    // const horizonalSpace = 12.0;
    return Container(
      width: 1200,
      // clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xffD9D9D9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
            spreadRadius: 0, // 그림자의 범위를 설정합니다.
            blurRadius: 11, // 흐림 정도를 설정합니다.
            offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...StaticsType.values
                .map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 500,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DashboardListItem(
                                item: DashboardItem(
                                    title: state.stockInfo?.todayDelta?.items?[e.index].title ?? "",
                                    value: state.stockInfo?.todayDelta?.items?[e.index].value ?? "",
                                    variation: state.stockInfo?.todayDelta?.items?[e.index].variation ??
                                        const Variation(text: "", colorHex: "#000000"))),
                            // 폴드 아이콘 추가
                            Material(
                              color: Colors.transparent, // 배경색을 투명하게 설정
                              child: IconButton(
                                icon: Icon(
                                  state.openState[e.index] ? Icons.expand_less : Icons.expand_more,
                                ),
                                onPressed: () {
                                  if (state.openState[e.index]) {
                                    bloc.add(CmsEvent.setOpenState(e.index));
                                    return;
                                  }
                                  if (e.index == 0) {
                                    bloc.add(CmsEvent.getStockQuantity(
                                        state.periodStockQuantityDaliy, state.periodStockQuantityMonthly));
                                  } else if (e.index == 1) {
                                    bloc.add(CmsEvent.getStake(state.periodStakeDaliy, state.periodStakeMonthly));
                                  } else if (e.index == 2) {
                                    bloc.add(CmsEvent.getMakeValue(
                                        state.periodMarketValueDaliy, state.periodMarketValueMonthly));
                                  } else {
                                    bloc.add(CmsEvent.getMemberCount(
                                        state.periodMemberCountDaliy, state.periodMemberCountMonthly));
                                  }
                                  bloc.add(CmsEvent.setOpenState(e.index));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.openState[e.index]) _buildStaticsDisplay(context, bloc, state, e.index, e),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticsDisplay(BuildContext context, CmsBloc bloc, CmsState state, int index, StaticsType staticsType
      // List<StockSummary>? staticsDaliy,
      // List<StockSummary>? staticsMonthly,
      ) {
    final dailyValues = {
      0: state.stockQuantityDaliy,
      1: state.stakeDaliy,
      2: state.marketValueDaliy,
      3: state.memberCountDaliy
    };

    final monthlyValues = {
      0: state.stockQuantityMonthly,
      1: state.stakeMonthly,
      2: state.marketValueMonthly,
      3: state.memberCountMonthly
    };

    final periodDailyValues = {
      0: state.periodStockQuantityDaliy,
      1: state.periodStakeDaliy,
      2: state.periodMarketValueDaliy,
      3: state.periodMemberCountDaliy
    };

    final periodMonthlyValues = {
      0: state.periodStockQuantityMonthly,
      1: state.periodStakeMonthly,
      2: state.periodMarketValueMonthly,
      3: state.periodMemberCountMonthly
    };

    return Container(
      // padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xffD9D9D9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
            spreadRadius: 0, // 그림자의 범위를 설정합니다.
            blurRadius: 11, // 흐림 정도를 설정합니다.
            offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(builder: (context, constraints) {
            return IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("일별추이"),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(periodDailyValues[index] ?? ""),
                            IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () async {
                                await showMonthPicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 5, 0),
                                  lastDate: DateTime(DateTime.now().year, DateTime.now().month),
                                  initialDate: DateTime.now(),
                                  headerColor: const Color(0xffD7DEFB),
                                  headerTextColor: Colors.black,
                                  selectedMonthBackgroundColor: const Color(0xffD7DEFB),
                                  selectedMonthTextColor: Colors.black87,
                                  unselectedMonthTextColor: Colors.black87,
                                  confirmWidget: Text(
                                    '선택',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[900],
                                    ),
                                  ),
                                  cancelWidget: Text(
                                    '취소',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber[900],
                                    ),
                                  ),
                                  roundedCornersRadius: 8,
                                  yearFirst: false,
                                  backgroundColor: Colors.white,
                                ).then((DateTime? date) {
                                  if (date != null) {
                                    bloc.add(
                                        CmsEvent.setPeriodDaily(staticsType, date.toFormatString(pattern: 'yyyyMM')));
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          // height: 76,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD9D9D9), // 테두리 색상
                              width: 1, // 테두리 두께
                            ),
                            borderRadius: BorderRadius.circular(8), // 모서리 둥근 정도
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Wrap(
                              // shrinkWrap: true, // ListView를 내용에 맞게 크기를 줄임
                              // physics: const NeverScrollableScrollPhysics(),
                              // scrollDirection: Axis.horizontal, // 스크롤 방향을 가로로 설정
                              children: ((dailyValues[index]?.length ?? 0) > 7
                                          ? dailyValues[index]!.sublist(dailyValues[index]!.length - 7)
                                          : dailyValues[index])
                                      ?.map(
                                        (e) => Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 0), // 가로 간격
                                          child: IntrinsicWidth(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  color: const Color(0xffD7DEFB),
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    formatDateString(e.key),
                                                    style: const TextStyle(fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  padding: const EdgeInsets.all(8),
                                                  child: Text(
                                                    NumberFormat.decimalPattern().format(e.value),
                                                    style: const TextStyle(fontSize: 12),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        if (dailyValues[index] != null)
                          SizedBox(
                            height: 100,
                            child: SfCartesianChart(
                              margin: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20),
                              // 마진 제거
                              primaryYAxis: NumericAxis(
                                desiredIntervals: 4,
                                labelStyle: const TextStyle(fontSize: 8, color: tickLabelColor),
                                // 틱 라벨 스타일
                                majorTickLines: const MajorTickLines(size: 0),
                                // 틱 라인 제거
                                axisLine: const AxisLine(width: 0),
                                // 축 라인 제거
                                numberFormat: NumberFormat.compact(locale: "ko_KR"),
                              ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries>[
                                AreaSeries<StockSummary, DateTime>(
                                    dataSource: dailyValues[index] ?? [],
                                    enableTooltip: true,
                                    name: state.stockInfo?.todayDelta?.items?[index].title,
                                    xValueMapper: (StockSummary dataItem, _) {
                                      // 'MONTHLY'와 'DAILY'에 따라 다른 포맷 적용
                                      return DateTime.parse(dataItem.key); // 일별 데이터 처리
                                      // if (data.periodType == "MONTHLY") {
                                      //   return DateTime.parse("${dataItem.key}-01"); // 월별 데이터 처리
                                      // } else {
                                      //   return DateTime.parse(dataItem.key); // 일별 데이터 처리
                                      // }
                                    },
                                    yValueMapper: (StockSummary dataItem, _) => dataItem.value,
                                    color: Colors.red.withAlpha(25),
                                    // 라인 색상
                                    borderDrawMode: BorderDrawMode.top,
                                    borderWidth: 1,
                                    borderColor: Colors.red,
                                    markerSettings: const MarkerSettings(
                                        isVisible: true,
                                        shape: DataMarkerType.circle,
                                        width: 2,
                                        height: 2,
                                        color: Colors.red)),
                              ],
                              primaryXAxis: DateTimeAxis(
                                // X축이 DateTime 유형일 때, 여백 제어를 위한 추가 설정
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                intervalType: DateTimeIntervalType.auto,
                                labelAlignment: LabelAlignment.center,
                                labelStyle: const TextStyle(fontSize: 8, color: tickLabelColor),
                                // 틱 라벨 스타일
                                majorTickLines: const MajorTickLines(size: 0),
                                // 틱 라인 제거
                                axisLine: const AxisLine(width: 0), // 축 라인 제거
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: 1, // 점선의 너비
                      height: constraints.maxHeight,
                      child: CustomPaint(
                        painter: VerticalDottedLinePainter(),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("월별추이"),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(periodMonthlyValues[index] ?? ""),
                              IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  // 팝업 메뉴 띄우기
                                  await showDialog(
                                    context: context,
                                    // barrierColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      // 현재 연도 계산
                                      int currentYear = DateTime.now().year;
                                      // 연도 리스트 생성 (올해부터 10년 전까지)
                                      List<String> years =
                                          List.generate(10, (int index) => (currentYear - index).toString());

                                      // 그리드 형태로 연도 표시
                                      return AlertDialog(
                                        content: SizedBox(
                                          width: 400, // 가로 크기를 300으로 설정
                                          height: 150, // 세로 크기를 100으로 설정
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text("연도 선택"),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              GridView.builder(
                                                physics: const NeverScrollableScrollPhysics(),
                                                // 스크롤 비활성화
                                                shrinkWrap: true,
                                                // 팝업 내용에 맞게 크기 조절
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 5, // 한 줄에 5개의 아이템
                                                  childAspectRatio: 2, // 아이템 비율 설정 (가로 세로 비율을 조정하였습니다)
                                                ),
                                                itemCount: years.length,

                                                itemBuilder: (BuildContext context, int index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      bloc.add(CmsEvent.setPeriodMonthly(staticsType, years[index]));
                                                      Navigator.of(context).pop(); // 팝업 닫기
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets.all(4),
                                                      height: 40,
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white, // 배경색
                                                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                        border: Border.all(color: const Color(0xFFD9D9D9), width: 0.5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.1),
                                                            spreadRadius: 0,
                                                            blurRadius: 11,
                                                            offset: const Offset(0, 3), // 그림자 위치
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        years[index].toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            // height: 76,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFD9D9D9), // 테두리 색상
                                width: 1, // 테두리 두께
                              ),
                              borderRadius: BorderRadius.circular(8), // 모서리 둥근 정도
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Wrap(
                                // shrinkWrap: true, // ListView를 내용에 맞게 크기를 줄임
                                // physics: const NeverScrollableScrollPhysics(),
                                // scrollDirection:
                                //     Axis.horizontal, // 스크롤 방향을 가로로 설정
                                children: monthlyValues[index]
                                        ?.map(
                                          (e) => Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 0), // 가로 간격
                                            child: IntrinsicWidth(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    color: const Color(0xffD7DEFB),
                                                    padding: const EdgeInsets.all(8),
                                                    child: Text(
                                                      e.key,
                                                      style: const TextStyle(fontSize: 12),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    padding: const EdgeInsets.all(8),
                                                    child: Text(
                                                      NumberFormat.decimalPattern().format(e.value),
                                                      style: const TextStyle(fontSize: 12),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList() ??
                                    [],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (monthlyValues[index] != null)
                            SizedBox(
                                height: 100,
                                child: SfCartesianChart(
                                  margin: const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 20),
                                  // 마진 제거
                                  primaryYAxis: NumericAxis(
                                    desiredIntervals: 4,
                                    labelStyle: const TextStyle(fontSize: 8, color: tickLabelColor),
                                    // 틱 라벨 스타일
                                    majorTickLines: const MajorTickLines(size: 0),
                                    // 틱 라인 제거
                                    axisLine: const AxisLine(width: 0),
                                    // 축 라인 제거
                                    numberFormat: NumberFormat.compact(locale: "ko_KR"),
                                  ),
                                  tooltipBehavior:
                                      TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer),
                                  series: <ChartSeries>[
                                    AreaSeries<StockSummary, DateTime>(
                                        dataSource: monthlyValues[index] ?? [],
                                        enableTooltip: true,
                                        name: state.stockInfo?.todayDelta?.items?[index].title,
                                        xValueMapper: (StockSummary dataItem, _) {
                                          // 'MONTHLY'와 'DAILY'에 따라 다른 포맷 적용
                                          return DateTime.parse("${dataItem.key}-01"); // 월별 데이터 처리
                                          // if (data.periodType == "MONTHLY") {
                                          //   return DateTime.parse("${dataItem.key}-01"); // 월별 데이터 처리
                                          // } else {
                                          //   return DateTime.parse(dataItem.key); // 일별 데이터 처리
                                          // }
                                        },
                                        yValueMapper: (StockSummary dataItem, _) => dataItem.value,
                                        color: Colors.red.withAlpha(25),
                                        // 라인 색상
                                        borderDrawMode: BorderDrawMode.top,
                                        borderWidth: 1,
                                        borderColor: Colors.red,
                                        markerSettings: const MarkerSettings(
                                            isVisible: true,
                                            shape: DataMarkerType.circle,
                                            width: 2,
                                            height: 2,
                                            color: Colors.red)),
                                  ],
                                  primaryXAxis: DateTimeAxis(
                                    // X축이 DateTime 유형일 때, 여백 제어를 위한 추가 설정
                                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                                    intervalType: DateTimeIntervalType.auto,
                                    labelAlignment: LabelAlignment.center,
                                    labelStyle: const TextStyle(fontSize: 8, color: tickLabelColor),
                                    // 틱 라벨 스타일
                                    majorTickLines: const MajorTickLines(size: 0),
                                    // 틱 라인 제거
                                    axisLine: const AxisLine(width: 0), // 축 라인 제거
                                  ),
                                )
                                // SfCartesianChart(
                                //   primaryYAxis: NumericAxis(
                                //     desiredIntervals: 4, // Y축에 4개의 틱을 원합니다.
                                //   ),
                                //   series: <ChartSeries>[
                                //     LineSeries<StockSummary, String>(
                                //         dataSource: monthlyValues[index] ?? [],
                                //         xValueMapper: (StockSummary data, _) => data.key,
                                //         yValueMapper: (StockSummary data, _) => data.value,
                                //         color: Colors.red.shade400),
                                //   ],
                                //   primaryXAxis: CategoryAxis(),
                                // ),
                                )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      //),
    );
  }
}

class VerticalDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD9D9D9)
      ..strokeWidth = 1;

    const double dashHeight = 4.0;
    const double dashSpace = 4.0;
    double startY = 0.0;
    while (startY < size.height) {
      // size.height를 사용하여 점선의 높이 조절
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
