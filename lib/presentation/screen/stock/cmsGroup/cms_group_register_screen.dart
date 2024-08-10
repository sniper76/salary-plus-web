import 'dart:async';
import 'dart:html' as html;

import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/stock/cmsGroup/group_register/cms_group_bloc.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

@RoutePage()
class CmsGroupRegisterScreen extends StatefulWidget {
  final int? code;

  const CmsGroupRegisterScreen({super.key, @pathParam this.code});

  @override
  State<CmsGroupRegisterScreen> createState() => _CmsStockGroupState();
}

class _CmsStockGroupState extends State<CmsGroupRegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerStock = TextEditingController();
  final TextEditingController _controllerBatch = TextEditingController();
  OverlayEntry? overlayEntry;
  final textFieldKey = GlobalKey();
  List<FocusNode>? listItemFocusNodes;
  int visibleItemCount = 50; // 처음에 표시할 항목 수
  StreamSubscription<html.PopStateEvent>? _popStateSubscription;

  void _showMore() {
    setState(() {
      visibleItemCount += 50; // 더 보기 클릭 시 50개 항목 추가
    });
  }

  void _onDeleteStockGroup() {
    final bloc = _scaffoldKey.currentContext?.read<CmsStockGroupBloc>();
    final stockGroupCode = widget.code;
    if (bloc == null || stockGroupCode == null) return;

    try {
      bloc.add(CmsStockGroupEvent.deleteStockGroup(stockGroupCode));
      context.router.pop(true);
    } catch (e) {
      EasyLoading.showError('에러가 발생했습니다.');
    }
  }

  void _onOpenDeleteDialog() async {
    final res = await context.showConfirmDialog(title: '종목 그룹 삭제', message: '종목그룹을 삭제하시겠습니까?');
    if (res) _onDeleteStockGroup();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    removeHighlightOverlay();
    _popStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CmsStockGroupBloc, CmsStockGroupState>(
      scaffoldKey: _scaffoldKey,
      create: (context) {
        return CmsStockGroupBloc()..add(CmsStockGroupEvent.init(widget.code));
      },
      listener: (context, state) {
        if (state.groupName != null && _controllerName.text.isEmpty) {
          _controllerName.text = state.groupName!;
        }
        if (state.groupDescription != null && _controllerDescription.text.isEmpty) {
          _controllerDescription.text = state.groupDescription!;
        }
      },
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildCmsGroupRegisterScreen(context, bloc, state);
      },
    );
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
    if (state.matchedStockList.isEmpty) return;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                removeHighlightOverlay();
                _controllerStock.text = "";
              },
            ),
            Positioned(
              top: topPosition, // 위에서 떨어진 위치
              left: 54, // 왼쪽에서 떨어진 위치
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
                    itemCount: state.matchedStockList.length,
                    itemBuilder: (context, i) {
                      // final itemFocusNode = listItemFocusNodes![i];
                      // 리스트 아이템을 구축합니다.
                      return ListTile(
                        title: Text(state.matchedStockList[i].name),
                        trailing: ElevatedButton(
                          onPressed: () {
                            textController.text = state.matchedStockList[i].name;
                            bloc.add(CmsStockGroupEvent.addStock(state.matchedStockList[i]));
                          },
                          child: const Text(
                            '추가',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        onTap: () {
                          textController.text = state.matchedStockList[i].name;
                          bloc.add(CmsStockGroupEvent.addStock(state.matchedStockList[i]));
                          // removeHighlightOverlay();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
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

  Widget _buildCmsGroupRegisterScreen(BuildContext context, CmsStockGroupBloc bloc, CmsStockGroupState state) {
    return BlocListener<CmsStockGroupBloc, CmsStockGroupState>(
      listenWhen: (previousState, currentState) {
        return previousState.matchedStockList != currentState.matchedStockList;
      },
      listener: (context, state) {
        createHighlightOverlay(
            // alignment: AlignmentDirectional.bottomStart,
            bloc: bloc,
            state: state,
            context: context,
            textController: _controllerStock);
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(
          context: context,
          mainTitle: state.isCreateMode
              ? "그룹등록하기"
              : state.isEditable
                  ? "그룹수정하기"
                  : "그룹정보 보기",
        ),
        body: SizedBox(
          width: 1200,
          child: Padding(
            padding: const EdgeInsets.only(left: 54, right: 54, top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    TextField(
                      controller: _controllerName,
                      enabled: state.isEditable,
                      style: state.isEditable ? null : const TextStyle(color: Colors.black),
                      // enabled가 false일 때 검정색 텍스트
                      onChanged: (value) {
                        bloc.add(CmsStockGroupEvent.setStockGroupName(value));
                      },
                      decoration: InputDecoration(
                        labelText: '그룹이름',
                        labelStyle: state.isEditable ? null : const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // 입력 필드 사이의 간격
                    TextField(
                      controller: _controllerDescription,
                      onChanged: (value) {
                        bloc.add(CmsStockGroupEvent.setDescripntion(value));
                      },
                      enabled: state.isEditable,
                      style: state.isEditable ? null : const TextStyle(color: Colors.black),
                      // enabled가 false일 때 검정색 텍스트
                      decoration: InputDecoration(
                        labelText: '그룹설명',
                        labelStyle: state.isEditable ? null : const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // 입력 필드 사이의 간격
                    if (state.isEditable)
                      Row(
                        children: [
                          Expanded(
                            // Flexible 위젯을 사용해 TextField가 Row의 대부분을 차지하도록 함
                            child: TextField(
                              key: textFieldKey,
                              controller: _controllerStock,
                              decoration: InputDecoration(
                                labelText: '종목추가',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                                ),
                              ),
                              onChanged: (value) {
                                bloc.add(CmsStockGroupEvent.searchStockByKeyword(value));
                                // searchStockGroupKeword
                              },
                            ),
                          ),
                          const SizedBox(width: 8), // 입력 필드와 버튼 사이의 간격
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                // 일괄추가 버튼 동작
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.transparent, // 팝업 뒤의 배경색을 투명하게 설정
                                  builder: (BuildContext dialogContext) {
                                    // BlocBuilder를 사용하여 상태 변화에 따라 UI를 재구축합니다.
                                    return BlocBuilder<CmsStockGroupBloc, CmsStockGroupState>(
                                      bloc: bloc, // 여기서 bloc은 상위 컨텍스트에서 주입된 bloc 인스턴스입니다.
                                      builder: (context, state) {
                                        // 이제 state는 항상 최신 상태를 반영합니다.
                                        return _buildBatchDialog(context, bloc, state);
                                      },
                                    );
                                  },
                                ).then((value) {
                                  _controllerBatch.text = "";
                                  return null;
                                });
                              },
                              child: Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 15.5),
                                  child: const Text('일괄추가')),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    // 빈 컨테이너 박스
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minHeight: 48, // 최소 높이 설정
                            ), // 최소 높이 설정
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffD9D9D9)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: _buildCandidateList(bloc, state),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // 세 번째 줄과 네 번째 줄 사이의 간격
                    // 등록 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.isEditable && !state.isCreateMode)
                          ElevatedButton(
                            onPressed: () {
                              if (state.newStockGroup != null) {
                                _controllerName.text = state.newStockGroup!.name;
                                _controllerDescription.text = state.newStockGroup!.description ?? '';
                              }
                              bloc.add(CmsStockGroupEvent.init(widget.code));
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff999999)),
                            child: Container(
                                width: 100,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: const Text('취소')),
                          ),
                        const SizedBox(width: 24),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: (state.isEditable)
                                  ? () {
                                      bloc.add(const CmsStockGroupEvent.registerStockGroup());
                                    }
                                  : () {
                                      bloc.add(const CmsStockGroupEvent.setEditorble(true));
                                    },
                              child: Text(state.isEditable ? '등록' : '수정'),
                            ),
                            if (!state.isEditable) ...[
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: _onOpenDeleteDialog,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) => AppTheme.defaultColorScheme.error),
                                ),
                                child: const Text('삭제'),
                              )
                            ]
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBatchDialog(BuildContext context, CmsStockGroupBloc bloc, CmsStockGroupState state) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 팝업 크기를 내용물에 맞게 조절
          crossAxisAlignment: CrossAxisAlignment.start, // 자식들을 시작점(왼쪽)으로 정렬
          children: [
            const Text(
              "일괄 추가",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerBatch, // 필요한 경우 해당 컨트롤러 할당
                    decoration: InputDecoration(
                      labelText: '종목코드',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        bloc.add(CmsStockGroupEvent.searchStocksByCodeList(value));
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controllerBatch.text.isNotEmpty) {
                      bloc.add(CmsStockGroupEvent.searchStocksByCodeList(_controllerBatch.text));
                    }
                  },
                  child: Container(padding: const EdgeInsets.symmetric(vertical: 15.5), child: const Text('검색')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildChipContainer(
              state.matchedBatchStockList.map<Widget>(
                (SimpleStock stock) {
                  return Chip(
                    backgroundColor: Colors.transparent,
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(stock.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4.0),
                        Text(stock.code, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
                      ],
                    ),
                    deleteIcon: state.isEditable ? const Icon(Icons.close, color: Colors.red, size: 12) : null,
                    onDeleted: () {
                      if (state.isEditable) bloc.add(CmsStockGroupEvent.deleteMatchBatchStock(stock));
                    },
                  );
                },
              ).toList(),
            ),
            const SizedBox(height: 16),
            if (state.nonMatchedBatchStockList.isNotEmpty)
              Text(
                "종목 업로드 중 오류가 발생하여 아래 종목은 불러오지 못했습니다.",
                style: TextStyle(fontSize: 12, color: Colors.red.shade500),
              ),
            _buildChipContainer(state.nonMatchedBatchStockList.map<Widget>((String stock) {
              return Chip(
                backgroundColor: Colors.transparent,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(stock, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal))],
                ),
              );
            }).toList()),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 추가 버튼 동작
                      bloc.add(CmsStockGroupEvent.addStockByBatchList(state.matchedBatchStockList));
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 15.5),
                      ),
                    ),
                    child: const Text('추가'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipContainer(List<Widget> chips) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            constraints: const BoxConstraints(minHeight: 48, maxHeight: 100),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffd9d9d9), width: 1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                children: chips,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCountInfo(CmsStockGroupState state) {
    String text;
    if (visibleItemCount < state.candidateStockList.length) {
      // 전체 항목이 아직 모두 표시되지 않았을 때
      text = "($visibleItemCount개 / 총 ${state.candidateStockList.length}개)";
    } else {
      // 전체 항목이 모두 표시되었을 때
      text = "(총 ${state.candidateStockList.length}개)";
    }

    return Chip(
        backgroundColor: Colors.amber.shade50,
        label: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)));
  }

  Widget _buildCandidateList(
    CmsStockGroupBloc bloc,
    CmsStockGroupState state,
  ) {
    List<Widget> chips = state.candidateStockList
        .take(visibleItemCount) // 현재 표시할 항목 수만큼만 가져옵니다.
        .map<Widget>((SimpleStock stock) {
      return Chip(
        backgroundColor: Colors.transparent,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              stock.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Text(stock.code, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        deleteIcon: state.isEditable
            ? const Icon(
                Icons.close,
                color: Colors.red,
                size: 12,
              )
            : null,
        onDeleted: state.isEditable
            ? () {
                bloc.add(CmsStockGroupEvent.deleteStock(stock));
                // bloc.add(cadidateStockList(stock)); // 가정: 이벤트를 발송하여 칩을 삭제합니다.
              }
            : null,
      );
    }).toList();

    chips.add(_buildItemCountInfo(state)); // 항목 수 정보 위젯 추가

    if (state.candidateStockList.length > visibleItemCount) {
      chips.add(
        TextButton(
          onPressed: _showMore,
          child: const Text("더 보기"),
        ),
      );
    }

    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: chips,
    );
  }
}
