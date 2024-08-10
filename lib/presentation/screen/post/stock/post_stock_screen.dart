import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/util/convert_column.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_filter_button.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/duplicate_post_button.dart';
import 'package:act_cms/presentation/widget/grid/data_grid_title_item.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc/post_stock_bloc.dart';

@RoutePage()
class PostStockScreen extends StatefulWidget {
  const PostStockScreen({super.key});

  @override
  State<PostStockScreen> createState() => _PostState();
}

class _PostState extends State<PostStockScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final textFieldSourceKey = GlobalKey();
  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostBloc, PostState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PostBloc()
        ..add(
          const PostEvent.init(),
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

  Widget _buildUserScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listenWhen: (previousState, currentState) {
        return previousState.postStatusType != currentState.postStatusType ||
            previousState.boardCategory != currentState.boardCategory;
      },
      listener: (context, state) {
        final value = _controller.text;
        if (state.searchType == BoardSearchType.title) {
          bloc.add(PostEvent.fetchPost(
            searchKeyword: value,
            page: 1,
            size: apiLoadSize,
          ));
        } else if (state.sourceCandidateStockList.isNotEmpty) {
          // 종목코드- 검색 리스트가 나올경우
          final searchKeyword = state.sourceCandidateStockList[0].code;
          bloc.add(PostEvent.setSelectedSimpleStock(state.sourceCandidateStockList[0]));
          bloc.add(PostEvent.fetchPost(
            searchKeyword: searchKeyword,
            page: 1,
            size: apiLoadSize,
          ));
          _controller.text = state.sourceCandidateStockList[0].name;
          overlayEntry?.remove();
          overlayEntry = null;
        } else if (value == "") {
          // 종목코드 - 검색어 없을 경우 - 전체 호출
          bloc.add(PostEvent.fetchPost(
            searchKeyword: value,
            page: 1,
            size: apiLoadSize,
          ));
        } else {
          // 종목코드- 검색어를 넣었으나 검색리스트가 없는 경우, 아무것도 안함.
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(
          mainTitle: "종목게시판",
          trailingWidgets: [
            Text(
              "총 ${state.paging.total.toNumberFormat}개",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostSearch(context, bloc, state),
              const SizedBox(height: 8),
              _buildActionButtons(context, bloc, state),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        final columns = refineColumns(
                          [
                            CustomColumn(width: 100, columnName: 'category', labelText: '카테고리'),
                            CustomColumn(width: 150, columnName: 'stock', labelText: '종목'),
                            CustomColumn(columnName: 'title', labelText: '제목'),
                            CustomColumn(width: 150, columnName: 'status', labelText: '상태'),
                            CustomColumn(width: 150, columnName: 'createdAt', labelText: '작성일'),
                            CustomColumn(width: 100, columnName: 'viewCount', labelText: '조회수'),
                            CustomColumn(width: 100, columnName: 'likeCount', labelText: '좋아요'),
                            CustomColumn(width: 100, columnName: 'commentCount', labelText: '댓글'),
                            CustomColumn(width: 100, columnName: 'linkPaste', labelText: ''),
                          ],
                          constraints.maxWidth,
                        );

                        return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: constraints.maxWidth),
                              child: ActDataGrid(
                                dataSource: GenericDataSource<Post>(
                                    data: state.postList,
                                    columnNames: columns.map((e) => e.columnName).toList(),
                                    valueExtractors: {
                                      'category': (Post item, int index) => item.boardGroupCategory?.displayName,
                                      'stock': (Post item, int index) => item.stock?.name,
                                      'title': (Post item, int index) => item,
                                      'status': (Post item, int index) => item.status.title,
                                      'createdAt': (Post item, int index) => item.createdAt.toFormatString(),
                                      'viewCount': (Post item, int index) => ConvertColumn.formatNumber(item.viewCount),
                                      'likeCount': (Post item, int index) => ConvertColumn.formatNumber(item.likeCount),
                                      'commentCount': (Post item, int index) =>
                                          ConvertColumn.formatNumber(item.commentCount),
                                      'linkPaste': (Post item, int index) => item,
                                    },
                                    columnAlignments: {
                                      'title': Alignment.centerLeft,
                                    },
                                    customWidgets: {
                                      'title': (Post post) => DataGridTitleItem(
                                          title: post.title, isAttachment: post.thumbnailImageUrl?.isNotEmpty),
                                      'linkPaste': (Post item) {
                                        return Container(
                                          alignment: Alignment.centerLeft,
                                          decoration: const BoxDecoration(
                                              border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
                                          child: IconButton(
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(text: item.id.toString()));
                                            },
                                            icon: const Icon(Icons.link),
                                          ),
                                        );
                                      }
                                    }),
                                columns: columns,
                                onCellTap: (details) {
                                  final rowIndex = details.rowColumnIndex.rowIndex - 1;
                                  if (rowIndex < 0) {
                                    return;
                                  }

                                  context.router
                                      .push(
                                    PostDetailRoute(
                                      stockCode: state.postList[rowIndex].stock!.code,
                                      stockName: state.postList[rowIndex].stock!.name,
                                      boardGroup: state.postList[rowIndex].boardGroupType!.value,
                                      postId: state.postList[rowIndex].id,
                                      boardGroupCategory: state.postList[rowIndex].boardGroupCategory,
                                    ),
                                  )
                                      .then((value) {
                                    bloc.add(const PostEvent.pageRefresh());
                                  });
                                },
                              ),
                            ),
                          );
                        });
                      },
                    ),
                    _buildPagination(context, bloc, state),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, PostBloc bloc, PostState state) {
    return Row(
      children: [
        _buildFilterList(context, bloc, state),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            context.router.push(PostRegisterRoute(boardGroupType: BoardGroupType.analysis)).then((value) {
              bloc.add(const PostEvent.pageRefresh());
            });
          },
          child: const Text("게시글 등록"),
        ),
        const SizedBox(width: 8),
        DuplicatePostButton(
          route: () => PostDuplicateRoute(boardGroupType: BoardGroupType.analysis),
          doneCallback: (value) => bloc.add(const PostEvent.pageRefresh()),
        ),
      ],
    );
  }

  Widget _buildPostSearch(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
        listenWhen: (previousState, currentState) {
          return previousState.sourceCandidateStockList != currentState.sourceCandidateStockList;
        },
        listener: (context, state) {
          if (state.searchType == BoardSearchType.title) return;
          overlayEntry = createSimpleStockOverlay(
            context: context,
            textFieldKey: textFieldSourceKey,
            simpleStockList: state.sourceCandidateStockList,
            onListTap: (i) {
              final searchKeyword = state.sourceCandidateStockList[i].code;
              bloc.add(PostEvent.setSelectedSimpleStock(state.sourceCandidateStockList[i]));
              bloc.add(PostEvent.fetchPost(
                searchKeyword: searchKeyword,
                page: 1,
                size: apiLoadSize,
              ));
              overlayEntry?.remove();
              overlayEntry = null;
            },
            oldOverlayEntry: overlayEntry,
            removeOverlay: () {
              overlayEntry?.remove();
              overlayEntry = null;
            },
            sidebarSize: 300,
          );
        },
        child: SizedBox(
          width: double.infinity,
          height: 50.0,
          child: Row(
            children: [
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
                    value: state.searchType,
                    hint: const Text('카테고리 선택'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onChanged: (BoardSearchType? newValue) {
                      bloc.add(PostEvent.postOnSetSearchType(newValue!));
                      _controller.text = "";
                    },
                    items: [BoardSearchType.title, BoardSearchType.stockcode]
                        .map<DropdownMenuItem<BoardSearchType>>((BoardSearchType value) {
                      return DropdownMenuItem<BoardSearchType>(
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                // createSimpleStockOverlay
                child: TextField(
                  key: textFieldSourceKey,
                  controller: _controller,
                  onSubmitted: (value) {
                    if (state.searchType == BoardSearchType.title) {
                      bloc.add(PostEvent.fetchPost(
                        searchKeyword: value,
                        page: 1,
                        size: apiLoadSize,
                      ));
                    } else if (state.sourceCandidateStockList.isNotEmpty) {
                      // 종목코드- 검색 리스트가 나올경우
                      final searchKeyword = state.sourceCandidateStockList[0].code;
                      bloc.add(PostEvent.setSelectedSimpleStock(state.sourceCandidateStockList[0]));
                      bloc.add(PostEvent.fetchPost(
                        searchKeyword: searchKeyword,
                        page: 1,
                        size: apiLoadSize,
                      ));
                      _controller.text = state.sourceCandidateStockList[0].name;
                      overlayEntry?.remove();
                      overlayEntry = null;
                    } else if (value == "") {
                      // 종목코드 - 검색어 없을 경우 - 전체 호출
                      bloc.add(PostEvent.fetchPost(
                        searchKeyword: value,
                        page: 1,
                        size: apiLoadSize,
                      ));
                    } else {
                      // 종목코드- 검색어를 넣었으나 검색리스트가 없는 경우, 아무것도 안함.
                    }
                  },
                  onChanged: (value) {
                    bloc.add(PostEvent.postOnSetSearchKeyword(value));
                  },
                  decoration: InputDecoration(
                    hintText: state.searchType == BoardSearchType.title ? "제목을 입력하세요." : "종목명 또는 종목코드를 입력하세요.",
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
              // Search button
              if (state.searchType == BoardSearchType.title)
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      bloc.add(const PostEvent.fetchPost(
                        page: 1,
                        size: apiLoadSize,
                      ));
                      // bloc.add(PostEvent.postOnSetSearchKeyword(
                      //     _controller.text));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor[600],
                      fixedSize: const Size(180, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ), // 모서리의 둥근 정도
                    ),
                    child: const Text(
                      '검색',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget _buildFilterList(BuildContext context, PostBloc bloc, PostState state) {
    List<PostStatusType> postStatusTypeList = [
      PostStatusType.all,
      PostStatusType.active,
      PostStatusType.inactive_by_admin,
      PostStatusType.deleted_by_user,
      PostStatusType.deleted_by_admin
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫 번째 라인의 필터
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...[BoardGroupCategory.defaultCategory(), ...state.boardCategoryList]
                .map((item) => ActFilterButton(
                      text: item.displayName,
                      isSelected: state.boardCategory == item,
                      onPressed: () {
                        if (state.boardCategory != item) {
                          bloc.add(PostEvent.postOnSetBoardCategory(item));
                        }
                      },
                    ))
                .toList(),
          ],
        ),
        // 두 번째 라인의 필터
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...postStatusTypeList
                .map((item) => ActFilterButton(
                      text: item.title,
                      isSelected: state.postStatusType == item,
                      onPressed: () {
                        bloc.add(PostEvent.postOnSetPostStatusType(item));
                      },
                    ))
                .toList()
          ],
        ),
      ],
    );
  }

  Widget _buildPagination(BuildContext context, PostBloc bloc, PostState state) {
    if (state.postList.isNotEmpty) {
      return ActPagination<PostBloc, PostState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(PostEvent.fetchPost(
            page: page,
          ));
        },
      );
    }

    return Container();
  }
}
