import 'package:act_cms/config/theme.dart';
import 'package:act_cms/domain/model/enum/stock_sort_type.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/screen/stock/cmsStock/bloc/cms_stock_bloc.dart';
import 'package:act_cms/presentation/widget/act_card_item_list.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:number_paginator/number_paginator.dart';

@RoutePage()
class CmsStockScreen extends StatefulWidget {
  const CmsStockScreen({super.key});

  @override
  State<CmsStockScreen> createState() => _CmsStockState();
}

class _CmsStockState extends State<CmsStockScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController controller = TextEditingController();
  final NumberPaginatorController _numberPaginatorController = NumberPaginatorController();

  // OverlayEntry 변수를 클래스 레벨에 선언합니다.
  OverlayEntry? overlayEntry;
  final textFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    removeHighlightOverlay();
    super.dispose();
  }

// Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CmsStockBloc, CmsStockState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CmsStockBloc()
        ..add(
          const CmsStockEvent.init(),
        ),
      listener: (context, state) async {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildUserScreen(context, bloc, state);
      },
    );
  }

  Widget _buildUserScreen(BuildContext context, CmsStockBloc bloc, CmsStockState state) {
    return BlocListener<CmsStockBloc, CmsStockState>(
      listenWhen: (previousState, currentState) {
        return previousState.candidatedStockList != currentState.candidatedStockList;
      },
      listener: (context, state) {
        overlayEntry = createSimpleStockOverlay(
          context: context,
          textFieldKey: textFieldKey,
          simpleStockList: state.candidatedStockList,
          onListTap: (i) {
            // bloc.add(CmsStockEvent.selec(state.cadiatedStockList[i]));
            overlayEntry?.remove();
            overlayEntry = null;
            bloc.add(CmsStockEvent.fetchCmsStock(
              page: 1,
              size: apiLoadSize,
              stock: state.candidatedStockList[i],
            ));
            controller.text = state.candidatedStockList[i].name;
            _numberPaginatorController.currentPage = 0;
          },
          oldOverlayEntry: overlayEntry,
          removeOverlay: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          sidebarSize: 300,
        );
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: "종목 (개별)",
          trailingWidgets: [
            Text(
              "총 ${(state.paging.total > state.totalCount ? state.paging.total : state.totalCount).toNumberFormat}개",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 800,
                    height: 50.0,
                    child: Row(
                      children: [
                        // Vertical Divider
                        // Search bar
                        Expanded(
                          child: TextField(
                            key: textFieldKey,
                            controller: controller,
                            onSubmitted: (value) {
                              if (value == "") {
                                bloc.add(const CmsStockEvent.init());
                                return;
                              }
                              if (state.candidatedStockList.isNotEmpty) {
                                bloc.add(CmsStockEvent.fetchCmsStock(stock: state.candidatedStockList[0]));
                                controller.text = state.candidatedStockList[0].name;
                                removeHighlightOverlay();
                                _numberPaginatorController.currentPage = 0;
                              }
                            },
                            onChanged: (value) {
                              bloc.add(CmsStockEvent.searchKeyword(value));
                            },
                            decoration: InputDecoration(
                              hintText: '종목명 또는 종목코드를 입력하세요.',
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
                        BlocListener<CmsStockBloc, CmsStockState>(
                          listenWhen: (previous, current) => previous.isRegistered != current.isRegistered,
                          listener: (context, state) {
                            EasyLoading.showInfo("기준일이 등록되었습니다.");
                          },
                          child: ElevatedButton(
                            onPressed: state.seletedStock == null
                                ? null
                                : () async {
                                    final ret = await showDatePicker(
                                      context: context,
                                      helpText: "${state.seletedStock?.name ?? ""} [${state.seletedStock?.code ?? ""}]",
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365)),
                                    );
                                    if (ret != null) {
                                      bloc.add(CmsStockEvent.assignStockReferencDate(ret));
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor[600],
                              fixedSize: const Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ), // 모서리의 둥근 정도
                            ),
                            child: Text(
                              '기준일 등록 (${state.seletedStock?.name ?? "종목선택"})',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Wrap(
                      spacing: 16.0,
                      children: List.generate(state.stockSortTypeList.length, (index) {
                        final StockSortType curIndexSortType = state.stockSortTypeList[index];
                        return _buildCmsStockSortButton(bloc, curIndexSortType, state);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (state.stockList.isNotEmpty)
                    ActCardItemList(
                      itemWidget: (int index) => _buildSimpleItem(context, bloc, state, state.stockList[index]),
                      totalSize: state.stockList.length,
                    ),
                  _buildPagination(context, bloc, state),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCmsStockSortButton(CmsStockBloc bloc, StockSortType curIndexSortType, CmsStockState state) {
    return InkWell(
      borderRadius: BorderRadius.circular(4.0),
      onTap: () {
        bloc.add(CmsStockEvent.changeSortType(curIndexSortType));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          curIndexSortType.label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: state.selectedSortType == curIndexSortType ? Colors.black : Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, CmsStockBloc bloc, CmsStockState state) {
    if (state.stockList.isNotEmpty) {
      return ActPagination<CmsStockBloc, CmsStockState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(CmsStockEvent.fetchCmsStockLoadMore(
            page: page,
          ));
        },
      );
    }

    return Container();
  }

  Widget _buildSimpleItem(BuildContext context, CmsStockBloc bloc, CmsStockState state, Stock stockData) {
    return InkWell(
      onTap: () {
        context.router.navigateNamed('stock/${stockData.code}/${stockData.name}');
      },
      child: Container(
        width: 394,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 28),
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
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        stockData.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        stockData.code,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${stockData.memberCount}명",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "${stockData.stake?.toStringAsFixed(2) ?? '0.00'}%",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
// }
}
