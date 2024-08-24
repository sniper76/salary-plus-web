import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/dashboard_age_statistics.dart';
import 'package:act_cms/domain/model/dashboard_gender_statistics.dart';
import 'package:act_cms/domain/model/dashboard_statistics.dart';
import 'package:act_cms/domain/model/dashboard_statistics_basic_item.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/widget/charts/chart_container.dart';
import 'package:act_cms/presentation/widget/charts/donut_chart.dart';
import 'package:act_cms/presentation/widget/charts/line_chart.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  late TabController _tabController;
  OverlayEntry? overlayEntry;
  final textMonthlyKey = GlobalKey();
  final textDailyKey = GlobalKey();
  String period = "";

  int totalCount = 20;
  int columnCount = 7;
  int rowCount = 0;

  static Map<String, int> colorMap = {
    'DAILY_USER_REGISTRATION_COUNT': 0xff439CFB,
    'DAILY_USER_WITHDRAWAL_COUNT': 0xffFF0000,
    'DAILY_TOTAL_ASSET_PRICE': 0xff9FE85D,
    'DAILY_ACTIVE_USER': 0xff5D7DED,
    'MONTHLY_ACTIVE_USER': 0xff5D7DED,
    'DAILY_POST_VIEW_COUNT': 0xffB658E2,
    'DAILY_USER_LOGIN_COUNT': 0xff5D7DED,
    'DAILY_USER_REUSE_RATE': 0xffE15DED,
    'DAILY_USER_ACCESS_PIN_NUMBER_COUNT': 0xffFFA621,
    'DAILY_STOCK_MEMBER_COUNT': 0xff439CFB,
    'DAILY_STOCK_USER_HOLDING_COUNT': 0xff9FE85D,
    'DAILY_STOCK_POST_COUNT': 0xff5D7DED,
    'DAILY_STOCK_COMMENT_COUNT': 0xff5D7DED,
    'DAILY_STOCK_LIKED_COUNT': 0xffB658E2,
  };

  Color getColorForTag(String tag) => Color(colorMap[tag] ?? 0xff00ffff);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      final bloc = _scaffoldKey.currentContext?.read<DashboardBloc>();
      if (bloc == null) return;
      if (_tabController.index == 1) {
        bloc.add(const DashboardEvent.daily("dotay"));
      } else {
        bloc.add(const DashboardEvent.monthly('today'));
      }
      bloc.add(DashboardEvent.dashboardOnSelectCategory(_tabController.index == 0 ? 'MONTHLY' : 'DAILY'));
      _controller.text = "";
    }
  }

  _handleMove(String mode) {
    final bloc = _scaffoldKey.currentContext?.read<DashboardBloc>();
    if (bloc == null) return;
    if (mode == 'back') {
      if (_tabController.index == 1) {
        bloc.add(const DashboardEvent.daily("previous"));
      } else {
        bloc.add(const DashboardEvent.monthly("previous"));
      }
    } else if (mode == 'forward') {
      if (_tabController.index == 1) {
        bloc.add(const DashboardEvent.daily("next"));
      } else {
        bloc.add(const DashboardEvent.monthly("next"));
      }
    } else {
      if (_tabController.index == 1) {
        bloc.add(const DashboardEvent.daily("today"));
      } else {
        bloc.add(const DashboardEvent.monthly("today"));
      }
    }
  }

  String formatValue(double dataValue) {
    final NumberFormat numberFormat = NumberFormat('#,##0.##');
    String formattedValue;

    if (dataValue >= oneHundredMillion) {
      double valueInOneHundredMillion = dataValue / oneHundredMillion;
      formattedValue = '${numberFormat.format(valueInOneHundredMillion)}억';
    } else {
      formattedValue = numberFormat.format(dataValue);
    }
    return formattedValue;
  }

  List<DashboardStatisticsBasicItem> _convertChartData(dynamic statistics) {
    final List<DashboardStatisticsBasicItem> chartItem = [];
    final convertedJson = statistics.toJson();

    convertedJson.forEach((key, value) {
      if (value is DashboardStatisticsBasicItem) chartItem.add(value);
    });
    return chartItem;
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<DashboardBloc, DashboardState>(
      scaffoldKey: _scaffoldKey,
      backgroundColor: const Color(0xfff5f5f5),
      appBar: MainAppBar(
        mainTitle: "대시보드",
      ),
      create: (context) => DashboardBloc()
        ..add(
          const DashboardEvent.init("today"),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        return _buildMainScreen(context, bloc, state);
      },
    );
  }

  Widget _buildMainScreen(BuildContext context, DashboardBloc bloc, DashboardState state) {
    // 예시 데이터를 생성
    List<String> dataList = List.generate(20, (index) => 'Item ${index + 1}');

    // Row 당 아이템 개수를 설정
    List<int> itemsPerRow = [7, 7, 6];

    // 데이터를 Row 단위로 분할
    List<List<String>> rows = _splitDataIntoRows(dataList, itemsPerRow);

    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen: (previous, current) => previous.search != current.search,
      listener: (context, state) {
        setState(() {
          period = "${state.search?.from} ~ ${state.search?.to}";
        });
      },
      child: Column(
        children: rows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: row.map((item) {
              return _buildGridItem(item);
            }).toList(),
          );
        }).toList(),
      ),
      // child: Container(
      //   width: double.infinity,
      //   margin: const EdgeInsets.only(left: 10, right: 10),
      //   color: Colors.grey.shade100,
      //   child: GridView.builder(
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 7, // 바둑판의 열 수
      //       mainAxisSpacing: 10, // 각 셀의 세로 간격
      //       crossAxisSpacing: 10, // 각 셀의 가로 간격
      //       childAspectRatio: 2, // 셀의 가로 세로 비율
      //     ),
      //     itemCount: 7, // 아이템 수
      //     itemBuilder: (context, index) {
      //       return GridTile(
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: AppTheme.primaryColor[600],
      //             fixedSize: const Size(120, 50),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8),
      //             ), // 모서리의 둥근 정도
      //           ),
      //           onPressed: () {
      //             print("onPressed");
      //           },
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Icon(Icons.star, size: 30),
      //               SizedBox(height: 5),
      //               Text('Button ${index + 1}'),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }

  // 데이터를 원하는 크기만큼의 Row로 분할하는 함수
  List<List<String>> _splitDataIntoRows(List<String> dataList, List<int> itemsPerRow) {
    List<List<String>> rows = [];
    int startIndex = 0;

    for (int itemCount in itemsPerRow) {
      rows.add(dataList.sublist(startIndex, startIndex + itemCount));
      startIndex += itemCount;
    }

    return rows;
  }

  Widget _buildGridItem(String title) {
    return Container(
      width: 120, // 원하는 width 설정
      height: 80, // 원하는 height 설정
      margin: const EdgeInsets.only(left: 10, bottom: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 30),
            SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicScreen(
    BuildContext context,
    DashboardBloc bloc,
    DashboardState state,
    List<DashboardStatistics> basicStats,
    List<DashboardStatistics> stockStats,
    DashboardGenderStatistics? genderStats,
    DashboardAgeStatistics? ageStats,
    GlobalKey<State<StatefulWidget>> globalKey,
  ) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SingleChildScrollView(
            child: basicStats.isEmpty
                ? const Text("월별 대시보드 데이터가 없습니다.")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...basicStats.map((e) => _buildChartItem(data: e, mainColor: getColorForTag(e.type))).toList()
                        ],
                      ),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (genderStats != null) _buildChartGender(genderStats),
                          if (ageStats != null) _buildChartAge(ageStats),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildStockSearch(context, bloc, state, globalKey),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...stockStats.map((e) => _buildChartItem(data: e, mainColor: getColorForTag(e.type))).toList()
                        ],
                      ),
                    ],
                  )));
  }

  Widget _buildChartGender(DashboardGenderStatistics genderStats) {
    return ChartContainer(
      width: 484,
      child: DonutChart(
        items: _convertChartData(genderStats),
        title: genderStats.title,
      ),
    );
  }

  Widget _buildChartAge(DashboardAgeStatistics ageStats) {
    return ChartContainer(
      width: 484,
      child: DonutChart(
        items: _convertChartData(ageStats),
        title: ageStats.title,
        fontSize: 10,
        gap: 5,
      ),
    );
  }

  Widget _buildChartItem({required DashboardStatistics data, Color mainColor = const Color(0xffFF0000)}) {
    return ChartContainer(
      child: LineChart(
        title: data.title,
        mainValue: formatValue(data.value),
        summary: data.summary,
        items: data.items,
        periodType: data.periodType,
        mainColor: mainColor,
      ),
    );
  }

  Widget _buildStockSearch(
    BuildContext context,
    DashboardBloc bloc,
    DashboardState state,
    GlobalKey<State<StatefulWidget>> globalKey,
  ) {
    double totalWidth = 976; // 320 * 3 + 8 * 2;
    if (context.mediaQuery.size.width > 1710) {
      totalWidth = 1304; // 320 * 4 + 8 * 3;
    }
    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen: (previousState, currentState) {
        return previousState.targetCandidateStockList != currentState.targetCandidateStockList;
      },
      listener: (context, state) {
        overlayEntry = createSimpleStockOverlay(
          context: context,
          textFieldKey: globalKey,
          simpleStockList: state.targetCandidateStockList,
          onListTap: (i) {
            _controller.text = state.targetCandidateStockList[i].name;
            bloc.add(DashboardEvent.getStockStats(state.targetCandidateStockList[i]));
            overlayEntry?.remove();
            overlayEntry = null;
          },
          oldOverlayEntry: overlayEntry,
          removeOverlay: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          sidebarSize: 0,
        );
      },
      child: SizedBox(
        width: totalWidth,
        height: 50.0,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                key: globalKey,
                controller: _controller,
                onSubmitted: (value) {
                  if (state.targetCandidateStockList.isNotEmpty) {
                    // 종목코드- 검색 리스트가 나올경우
                    bloc.add(DashboardEvent.getStockStats(state.targetCandidateStockList[0]));
                    // bloc.add(const DashboardEvent.getStockStats());
                    _controller.text = state.targetCandidateStockList[0].name;
                    overlayEntry?.remove();
                    overlayEntry = null;
                  } else if (value == "") {
                    // 종목코드 - 검색어 없을 경우 - 전체 호출
                    bloc.add(const DashboardEvent.getAllStockStats());
                  } else {
                    // 종목코드- 검색어를 넣었으나 검색리스트가 없는 경우, 아무것도 안함.
                  }
                },
                onChanged: (value) {
                  bloc.add(DashboardEvent.searchKeyword(value));
                },
                decoration: InputDecoration(
                  label: Text(state.selectedSimpleStock?.name ?? "전체종목통계"),
                  hintText: '주식의 이름 또는 코드를 입력하세요. (ex, 삼성전자, 000990)',
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), // 둥근 모서리 설정
                    borderSide: BorderSide(color: Colors.grey.shade300), // 테두리 색상 설정
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
            // Vertical Divider
            const SizedBox(
              width: 10,
            ),
            // Search button
            ElevatedButton(
              onPressed: state.selectedSimpleStock == null
                  ? null
                  : () {
                      bloc.add(DashboardEvent.getStockStats(state.selectedSimpleStock!));
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor[600],
                fixedSize: const Size(120, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ), // 모서리의 둥근 정도
              ),
              child: const Text(
                '검색',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            // Search button
            ElevatedButton(
              onPressed: () {
                bloc.add(const DashboardEvent.getAllStockStats());
                _controller.text = "";
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor[600],
                fixedSize: const Size(120, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ), // 모서리의 둥근 정도
              ),
              child: const Text(
                '전체',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
