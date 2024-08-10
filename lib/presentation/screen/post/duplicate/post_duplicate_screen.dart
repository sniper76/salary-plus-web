import 'dart:async';
import 'dart:html';

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_target_search_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/base/base_constant.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/screen/post/duplicate/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

@RoutePage()
class PostDuplicateScreen extends StatefulWidget {
  final BoardGroupType boardGroupType;

  const PostDuplicateScreen({super.key, required this.boardGroupType});

  @override
  State<PostDuplicateScreen> createState() => _PostState();
}

class _PostState extends State<PostDuplicateScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerSource = TextEditingController();
  final TextEditingController _controllerTarget = TextEditingController();
  OverlayEntry? overlayEntry;
  final textFieldSourceKey = GlobalKey();
  final textFieldTargetKey = GlobalKey();
  List<FocusNode>? listItemFocusNodes;
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  StreamSubscription<PopStateEvent>? _popStateSubscription;

  void _registerPopStateListener() {
    _popStateSubscription = window.onPopState.listen((event) {
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    _registerPopStateListener();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    removeOverlay();
    _popStateSubscription?.cancel();
    super.dispose();
  }

  onCompleteDuplicate() {
    context.showAlertDialog(title: "게시글 복제", message: "게시글이 복제되었습니다.").then((value) {
      context.router.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostBloc, PostState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PostBloc(widget.boardGroupType)
        ..add(
          const PostEvent.init(),
        ),
      listener: (context, state) {
        if (state.isComplete) onCompleteDuplicate();
      },
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildPostDuplicateScreen(context, bloc, state);
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

  String formatAssetAmount(int? amount) {
    if (amount == null) {
      return "-";
    }
    final numberFormat = NumberFormat('#,###', 'ko_KR');
    return numberFormat.format(amount);
  }

  void createPostListOverlay({
    required PostBloc bloc,
    required PostState state,
    required BuildContext context,
    required TextEditingController textController,
  }) {
    final RenderBox renderBox = textFieldSourceKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final topPosition = offset.dy + size.height + 8;
    // Remove the existing OverlayEntry.
    removeOverlay();

    assert(overlayEntry == null);
    if (state.sourcePostList.isEmpty) return;

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (context) {
        // 여기서 Positioned 위젯을 사용하여 정확한 위치를 설정합니다.
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // 사용자가 Overlay 바깥을 탭했을 때 실행됩니다.
                removeOverlay();
              },
            ),
            Positioned(
              top: topPosition, // 위에서 떨어진 위치
              left: 54, // 왼쪽에서 떨어진 위치
              // width: size.width, // TextField의 가로 크기를 설정합니다.
              width: 848,
              child: SingleChildScrollView(
                child: Container(
                  // constraints: const BoxConstraints(maxHeight: 500),
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
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      // SfDataGrid의 최대 너비를 1200, 최소 너비를 800으로 설정합니다.
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                                          child: SfDataGrid(
                                            shrinkWrapColumns: true,
                                            shrinkWrapRows: true,
                                            columnWidthMode: ColumnWidthMode.none,
                                            columns: <GridColumn>[
                                              GridColumn(
                                                  columnName: 'title',
                                                  label: Container(
                                                    padding: const EdgeInsets.all(4.0),
                                                    decoration: sfTableBoxStyle,
                                                    child: const Center(child: Text('제목', style: sfTableTextStyle)),
                                                  ),
                                                  width: 350),
                                              GridColumn(
                                                columnName: 'createAt',
                                                label: Container(
                                                  padding: const EdgeInsets.all(4.0), // Padding 추가
                                                  decoration: sfTableBoxStyle,
                                                  child: const Center(
                                                      child: Text(
                                                    '작성일',
                                                    style: sfTableTextStyle,
                                                  )),
                                                ),
                                                width: 120,
                                              ),
                                              GridColumn(
                                                columnName: 'viewCount',
                                                label: Container(
                                                  padding: const EdgeInsets.all(4.0), // Padding 추가
                                                  decoration: sfTableBoxStyle,
                                                  child: const Center(
                                                      child: Text(
                                                    '조회수',
                                                    style: sfTableTextStyle,
                                                  )),
                                                ),
                                                width: 80,
                                              ),
                                              GridColumn(
                                                columnName: 'likeCount',
                                                label: Container(
                                                  padding: const EdgeInsets.all(4.0), // Padding 추가
                                                  decoration: sfTableBoxStyle,
                                                  child: const Center(
                                                      child: Text(
                                                    '좋아요',
                                                    style: sfTableTextStyle,
                                                  )),
                                                ),
                                                width: 80,
                                              ),
                                              GridColumn(
                                                columnName: 'commentCount',
                                                label: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets.all(4.0), // Padding 추가
                                                  decoration: sfTableBoxStyle,
                                                  child: const Center(
                                                      child: Text(
                                                    '댓글',
                                                    style: sfTableTextStyle,
                                                  )),
                                                ),
                                                width: 80,
                                              ),
                                            ],
                                            onCellTap: (details) {
                                              final rowIndex = details.rowColumnIndex.rowIndex - 1;
                                              final dataSource = getCurrentPageItems(state)[rowIndex];
                                              // print("index $rowIndex");
                                              // print(
                                              //     "index ${dataSource.id}, ${dataSource.title}, ${dataSource.boardGroupType}");
                                              bloc.add(PostEvent.postOnSelectPost(dataSource));
                                              removeOverlay();
                                            },
                                            headerRowHeight: 32,
                                            rowHeight: 32,
                                            headerGridLinesVisibility: GridLinesVisibility.none,
                                            gridLinesVisibility: GridLinesVisibility.none,
                                            source: PostDuplicateDataSource(getCurrentPageItems(state)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  _buildPagination(context, bloc, state),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
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

  List<Post> getCurrentPageItems(PostState state, {bool countOnly = false}) {
    return state.sourcePostList;
  }

  void createSourceStockOverlay({
    required PostBloc bloc,
    required PostState state,
    required BuildContext context,
    required TextEditingController textController,
  }) {
    final RenderBox renderBox = textFieldSourceKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final topPosition = offset.dy + size.height + 8;
    // Remove the existing OverlayEntry.
    removeOverlay();

    assert(overlayEntry == null);
    if (state.sourceCandidateStockList.isEmpty) return;

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // 여기서 Positioned 위젯을 사용하여 정확한 위치를 설정합니다.
        return Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // 사용자가 Overlay 바깥을 탭했을 때 실행됩니다.
                removeOverlay();
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
                    itemCount: state.sourceCandidateStockList.length,
                    itemBuilder: (context, i) {
                      // final itemFocusNode = listItemFocusNodes![i];
                      // 리스트 아이템을 구축합니다.
                      return ListTile(
                        title: Text(state.sourceCandidateStockList[i].name),
                        onTap: () {
                          textController.text = state.sourceCandidateStockList[i].name;
                          bloc.add(PostEvent.setSourceStock(state.sourceCandidateStockList[i]));
                          removeOverlay();
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
  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
    // if (listItemFocusNodes != null) {
    //   for (var node in listItemFocusNodes!) {
    //     node.dispose();
    //   }
    // }
  }

  Widget _buildPostDuplicateScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(mainTitle: "게시글 복제", context: context),
        body: SizedBox(
          width: 1200,
          child: Padding(
            padding: const EdgeInsets.only(left: 54, right: 54, top: 32),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  _buildPostSearch(context, bloc, state),
                  const SizedBox(height: 16),
                  _buildPostListingAndSelect(context, bloc, state),
                  const SizedBox(height: 16),
                  _buildSelectTargetBoard(context, bloc, state),
                  // 빈 컨테이너 박스

                  const SizedBox(height: 16), // 세 번째 줄과 네 번째 줄 사이의 간격
                  // 등록 버튼
                  ElevatedButton(
                    onPressed: state.sourceSelectedPost == null ||
                            ((state.targetSearchType == BoardTargetSearchType.stockname &&
                                    state.targetSimpleStock == null) ||
                                (state.targetSearchType == BoardTargetSearchType.groupname &&
                                    state.targetStockGroup == null))
                        ? null
                        : () {
                            if (state.targetSearchType == BoardTargetSearchType.stockname) {
                              bloc.add(const PostEvent.duplicatePostToStock());
                            } else {
                              bloc.add(const PostEvent.duplicatePostToGroup());
                            }
                            // 등록 버튼 동작
                          },
                    child: Container(
                        width: 100,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text('복제')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostSearch(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listenWhen: (previousState, currentState) {
        // sourceCandidateStockList의 변화를 감지합니다.
        if (state.sourceSearchType == BoardSearchType.stockcode) {
          return (previousState.sourceCandidateStockList != currentState.sourceCandidateStockList);
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state.sourceSearchType == BoardSearchType.stockcode) {
          overlayEntry = createSimpleStockOverlay(
            context: context,
            textFieldKey: textFieldSourceKey,
            simpleStockList: state.sourceCandidateStockList,
            onListTap: (int i) {
              _controllerSource.text = state.sourceCandidateStockList[i].name;
              bloc.add(PostEvent.setSourceStock(state.sourceCandidateStockList[i]));
              removeOverlay();
            },
            oldOverlayEntry: overlayEntry,
            removeOverlay: () {
              overlayEntry?.remove();
              overlayEntry = null;
            },
            sidebarSize: 300,
          );
        }
      },
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text("복제대상게시글", style: titleStyle),
          ),
          const SizedBox(width: 32),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // flex: 2, // Giving more width to dropdown
            width: 200,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BoardSearchType>(
                focusColor: Colors.white,
                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                value: state.sourceSearchType,
                hint: const Text('카테고리 선택'),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (BoardSearchType? newValue) {
                  if (state.sourceSearchType != newValue) {
                    bloc.add(PostEvent.postOnSetSourceSearchType(newValue!));
                    _controllerSource.text = "";
                  }
                },
                items: [
                  BoardSearchType.title,
                  if (state.boardGroup == BoardGroupType.analysis) BoardSearchType.stockcode,
                ].map<DropdownMenuItem<BoardSearchType>>(
                  (BoardSearchType value) {
                    return DropdownMenuItem<BoardSearchType>(
                      value: value,
                      child: Text(
                        value.title,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                ).toList(),
                isExpanded: true, // Making dropdown expand fully in its space
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            // Flexible 위젯을 사용해 TextField가 Row의 대부분을 차지하도록 함
            child: TextField(
              key: textFieldSourceKey,
              controller: _controllerSource,
              decoration: InputDecoration(
                label: Text(
                  state.sourceSearchType == BoardSearchType.stockcode //
                      ? (state.sourceSimpleStock?.name ?? "") //
                      : "",
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
              onChanged: (value) {
                // if (state.sourceSearchType == BoardSearchType.stockcode) {
                bloc.add(PostEvent.postOnSetSourceSearchKeyword(value));
                // }
              },
              onSubmitted: (value) {
                if (state.sourceSearchType == BoardSearchType.stockcode) {
                  _controllerSource.text = state.sourceCandidateStockList[0].name;
                  bloc.add(PostEvent.setSourceStock(state.sourceCandidateStockList[0]));
                  removeOverlay();
                }
              },
            ),
          ),
          const SizedBox(width: 32), // 입력 필드와 버튼 사이의 간격
          ElevatedButton(
            onPressed:
                // state.sourceSearchKeyword.isEmpty
                (state.sourceSearchType == BoardSearchType.title
                        ? state.sourceSearchKeyword.isEmpty
                        : state.sourceSimpleStock == null)
                    ? null
                    : () {
                        bloc.add(const PostEvent.fetchPost(
                          page: 1,
                          size: apiLoadSize,
                        ));
                        // 추가 버튼 동작
                      },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 22, horizontal: 40),
              ),
            ),
            child: const Text('검색'),
          ),
        ],
      ),
    );
  }

  Widget _buildPostListingAndSelect(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listenWhen: (previousState, currentState) => previousState.sourcePostList != currentState.sourcePostList,
      listener: (context, state) {
        createPostListOverlay(
          bloc: bloc,
          state: state,
          context: context,
          textController: _controllerSource,
        );
      },
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text("복제대상포스트", style: titleStyle),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: state.sourceSelectedPost == null
                  ? const Row(children: [Text("")])
                  : Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "[ID:${state.sourceSelectedPost?.id}]",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "[${state.sourceSelectedPost?.stock?.name ?? "Global"}]",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text(state.sourceSelectedPost?.title ?? ""),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.sourceSelectedPost?.createdAt == null
                                      ? "-"
                                      : state.sourceSelectedPost!.createdAt.toFormatString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8),
                                Text("조회수 ${formatAssetAmount(state.sourceSelectedPost?.viewCount)}"),
                                const SizedBox(width: 8),
                                Text("좋아요 ${formatAssetAmount(state.sourceSelectedPost?.likeCount)}"),
                                const SizedBox(width: 8),
                                Text("좋아요 ${formatAssetAmount(state.sourceSelectedPost?.commentCount)}"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, PostBloc bloc, PostState state) {
    if (state.sourcePostList.isNotEmpty) {
      return BlocProvider.value(
        value: bloc,
        child: ActPagination<PostBloc, PostState>(
          paging: state.paging,
          onPageChange: (int page) {
            bloc.add(PostEvent.fetchPostLoadMore(
              page: page,
            ));
          },
        ),
      );
    }

    return Container();
  }

  Widget _buildSelectTargetBoard(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {},
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text("복제목표게시판", style: titleStyle),
          ),
          BlocListener<PostBloc, PostState>(
            listenWhen: (previousState, currentState) =>
                previousState.targetCandidateStockList != currentState.targetCandidateStockList,
            listener: (context, state) {
              if (state.targetCandidateStockList.isNotEmpty) {
                overlayEntry = createSimpleStockOverlay(
                  context: context,
                  textFieldKey: textFieldTargetKey,
                  simpleStockList: state.targetCandidateStockList,
                  onListTap: (int i) {
                    _controllerTarget.text = state.targetCandidateStockList[i].name;
                    bloc.add(PostEvent.setTargetStock(state.targetCandidateStockList[i]));
                    removeOverlay();
                  },
                  oldOverlayEntry: overlayEntry,
                  removeOverlay: () {
                    overlayEntry?.remove();
                    overlayEntry = null;
                  },
                  sidebarSize: 300,
                );
              }
            },
            child: const SizedBox(width: 32),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // flex: 2, // Giving more width to dropdown
            width: 200,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<BoardTargetSearchType>(
                focusColor: Colors.white,
                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                value: state.targetSearchType,
                hint: const Text('카테고리 선택'),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (BoardTargetSearchType? newValue) {
                  if (state.targetSearchType != newValue) {
                    bloc.add(PostEvent.postOnSetTargetSearchType(newValue!));
                    _controllerTarget.text = "";
                  }
                },
                items: [
                  BoardTargetSearchType.stockname,
                  BoardTargetSearchType.groupname,
                ].map<DropdownMenuItem<BoardTargetSearchType>>((BoardTargetSearchType value) {
                  return DropdownMenuItem<BoardTargetSearchType>(
                    value: value,
                    child: Text(
                      value.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                isExpanded: true, // Making dropdown expand fully in its space
              ),
            ),
          ),
          BlocListener<PostBloc, PostState>(
            listenWhen: (previousState, currentState) =>
                previousState.targetCandidateStockGroupList != currentState.targetCandidateStockGroupList,
            listener: (context, state) {
              overlayEntry = createStockGroupOverlay(
                context: context,
                textFieldKey: textFieldTargetKey,
                stockGroupList: state.targetCandidateStockGroupList,
                onListTap: (int i) {
                  _controllerTarget.text = state.targetCandidateStockGroupList[i].name;
                  bloc.add(PostEvent.setTargetStockGroup(state.targetCandidateStockGroupList[i]));
                  removeOverlay();
                },
                oldOverlayEntry: overlayEntry,
                removeOverlay: () {
                  overlayEntry?.remove();
                  overlayEntry = null;
                },
                sidebarSize: 300,
              );
            },
            child: const SizedBox(width: 32),
          ),
          Expanded(
            // Flexible 위젯을 사용해 TextField가 Row의 대부분을 차지하도록 함
            child: TextField(
              key: textFieldTargetKey,
              controller: _controllerTarget,
              decoration: InputDecoration(
                label: Text(state.targetSearchType == BoardTargetSearchType.stockname
                    ? (state.targetSimpleStock?.name ?? "")
                    : (state.targetStockGroup?.name ?? "")),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
              onChanged: (value) {
                bloc.add(PostEvent.postOnSetTargetSearchKeyword(value));
              },
              onSubmitted: (value) {
                if (state.targetSearchType == BoardTargetSearchType.stockname) {
                  if (state.targetCandidateStockList.isNotEmpty) {
                    _controllerTarget.text = state.targetCandidateStockList[0].name;
                    bloc.add(PostEvent.setTargetStock(state.targetCandidateStockList[0]));
                    removeOverlay();
                  }
                } else {
                  if (state.targetCandidateStockGroupList.isNotEmpty) {
                    _controllerTarget.text = state.targetCandidateStockGroupList[0].name;
                    bloc.add(PostEvent.setTargetStockGroup(state.targetCandidateStockGroupList[0]));
                    removeOverlay();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PostDuplicateDataSource extends DataGridSource {
  static const testStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);

  String formatViewCount(int? viewCount) {
    if (viewCount == null) return '0';
    return NumberFormat('#,###').format(viewCount);
  }

  PostDuplicateDataSource(List<Post> postList) {
    dataGridRows = postList
        .map<DataGridRow>(
          (postData) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'title',
                value:
                    "[${postData.stock?.name ?? ""}] [${postData.boardGroupCategory?.displayName}] ${postData.title}",
              ),
              DataGridCell<String>(columnName: 'createdAt', value: postData.createdAt.toFormatString()),
              DataGridCell<String>(columnName: 'viewCount', value: formatViewCount(postData.viewCount)),
              DataGridCell<String>(columnName: 'likeCount', value: formatViewCount(postData.likeCount)),
              DataGridCell<String>(columnName: 'commentCount', value: formatViewCount(postData.commentCount)),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row
          .getCells()
          .map<Widget>(
            (cell) => MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                alignment: cell.columnName == 'title' ? Alignment.centerLeft : Alignment.center,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
                child: Text(cell.value.toString(), style: testStyle),
              ),
            ),
          )
          .toList(),
    );
  }
}
