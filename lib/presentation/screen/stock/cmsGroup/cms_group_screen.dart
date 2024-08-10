import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/stock_group.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/stock/cmsGroup/bloc/cms_group_bloc.dart';
import 'package:act_cms/presentation/widget/act_card_item_list.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:number_paginator/number_paginator.dart';

@RoutePage()
class CmsStockGroupScreen extends StatefulWidget {
  const CmsStockGroupScreen({super.key});

  @override
  State<CmsStockGroupScreen> createState() => _CmsStockGroupState();
}

class _CmsStockGroupState extends State<CmsStockGroupScreen> {
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

  void createHighlightOverlay({
    required CmsStockGroupBloc bloc,
    required CmsStockGroupState state,
    required BuildContext context,
    required TextEditingController textController,
  }) {
    final RenderBox renderBox = textFieldKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final topPosition = offset.dy + size.height + 8;

    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);
    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // 여기서 Positioned 위젯을 사용하여 정확한 위치를 설정합니다.
        return Positioned(
          top: topPosition, // 위에서 300만큼 떨어진 위치
          left: 32, // 왼쪽에서 200만큼 떨어진 위치
          width: size.width, // TextField의 가로 크기를 설정합니다.
          child: Container(
            constraints: const BoxConstraints(maxHeight: 500),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xffd9d9d9), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                    spreadRadius: 0, // 그림자의 범위를 설정합니다.
                    blurRadius: 11, // 흐림 정도를 설정합니다.
                    offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                  ),
                ]),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.cadiatedStocGroupkList.length,
                itemBuilder: (context, i) {
                  // 리스트 아이템을 구축합니다.
                  return ListTile(
                    title: Text(state.cadiatedStocGroupkList[i].name),
                    onTap: () {
                      textController.text = state.cadiatedStocGroupkList[i].name;
                      bloc.add(CmsStockGroupEvent.fetchCmsStockGroup(
                        stockGroupId: state.cadiatedStocGroupkList[i].id,
                      ));
                      removeHighlightOverlay();
                      _numberPaginatorController.currentPage = 0;
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context).insert(overlayEntry!);
  }

// Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CmsStockGroupBloc, CmsStockGroupState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CmsStockGroupBloc()
        ..add(
          const CmsStockGroupEvent.init(),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildUserScreen(context, bloc, state);
      },
    );
  }

  Widget _buildUserScreen(BuildContext context, CmsStockGroupBloc bloc, CmsStockGroupState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        mainTitle: "종목 (그룹)",
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
                      _buildSearchBox(bloc, state),
                      // Vertical Divider
                      const SizedBox(width: 10),
                      // Search button
                      ElevatedButton(
                        onPressed: () {
                          context.router.navigate(CmsGroupRegisterRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor[600],
                          fixedSize: const Size(180, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ), // 모서리의 둥근 정도
                        ),
                        child: const Text('그룹 등록', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (state.stockGroupList.isNotEmpty)
                  ActCardItemList(
                    itemWidget: (int index) => _buildSimpleItem(context, bloc, state, state.stockGroupList[index]),
                    totalSize: state.stockGroupList.length,
                  ),
                if (state.stockGroupList.isNotEmpty) _buildPagination(context, bloc, state),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(BuildContext context, CmsStockGroupBloc bloc, CmsStockGroupState state) {
    if (state.stockGroupList.isNotEmpty) {
      return ActPagination<CmsStockGroupBloc, CmsStockGroupState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(CmsStockGroupEvent.fetchCmsStockGroupLoadMore(
            stockGroupId: state.stockGroupId,
            page: page,
          ));
        },
      );
    }

    return Container();
  }

  Widget _buildSimpleItem(
      BuildContext context, CmsStockGroupBloc bloc, CmsStockGroupState state, StockGroup stockData) {
    return InkWell(
      onTap: () {
        context.router.push(CmsGroupRegisterRoute(code: stockData.id));
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
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${stockData.stockCount}개",
                        style: const TextStyle(fontSize: 16),
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

  Widget _buildSearchBox(CmsStockGroupBloc bloc, CmsStockGroupState state) {
    return BlocListener<CmsStockGroupBloc, CmsStockGroupState>(
      listenWhen: (previousState, currentState) {
        return previousState.cadiatedStocGroupkList != currentState.cadiatedStocGroupkList;
      },
      listener: (context, state) {
        createHighlightOverlay(
          bloc: bloc,
          state: state,
          context: context,
          textController: controller,
        );
      },
      child: Expanded(
        child: TextField(
          key: textFieldKey,
          controller: controller,
          onSubmitted: (value) {
            if (value == "") {
              bloc.add(const CmsStockGroupEvent.init());
              return;
            }
            if (state.cadiatedStocGroupkList.isNotEmpty) {
              bloc.add(CmsStockGroupEvent.fetchCmsStockGroup(stockGroupId: state.cadiatedStocGroupkList[0].id));
              controller.text = state.cadiatedStocGroupkList[0].name;
              removeHighlightOverlay();
              _numberPaginatorController.currentPage = 0;
            }
          },
          onChanged: (value) {
            bloc.add(CmsStockGroupEvent.searchKeyword(value));
            createHighlightOverlay(
              bloc: bloc,
              state: state,
              context: context,
              textController: controller,
            );
          },
          decoration: InputDecoration(
            hintText: '검색',
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
    );
  }
// }
}
