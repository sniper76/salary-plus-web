import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/enum/post_search_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/util/convert_column.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/act_filter_button.dart';
import 'package:act_cms/presentation/widget/act_pagination.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/grid/data_grid_title_item.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'bloc/community_bloc.dart';

@RoutePage()
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityState();
}

class _CommunityState extends State<CommunityScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    EasyLoading.dismiss();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CommunityBloc, CommunityState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CommunityBloc()
        ..add(
          const CommunityEvent.init(),
        ),
      appBar: _buildAppBar(),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildScreen(context, bloc, state);
      },
    );
  }

  AppBar _buildAppBar() {
    return MainAppBar(mainTitle: "자유토론방", trailingWidgets: [_buildCountPosts()]);
  }

  Widget _buildCountPosts() {
    return BlocSelector<CommunityBloc, CommunityState, int>(
      selector: (state) => state.paging.total,
      builder: (context, count) {
        return Text(
          "총 $count개",
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Color(0xff666666)),
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, CommunityBloc bloc, CommunityState state) {
    return BlocListener<CommunityBloc, CommunityState>(
      listenWhen: (previousState, currentState) {
        return previousState.postStatusType != currentState.postStatusType ||
            previousState.boardCategory != currentState.boardCategory ||
            previousState.searchKeyword != currentState.searchKeyword;
      },
      listener: (context, state) {
        bloc.add(const CommunityEvent.fetchCommunityPosts(
          page: 1,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchBar(
              controller: _controller,
              onSearch: () {
                bloc.add(CommunityEvent.setSearchKeyword(_controller.text));
              },
              onChange: () {},
              prefixWidget: CustomDropdown<BoardSearchType>(
                value: state.searchType,
                items: const [BoardSearchType.title],
                getText: (value) => value.title,
                onChanged: (newValue) {
                  if (newValue != null) {
                    bloc.add(CommunityEvent.setSearchType(newValue));
                  }
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            _buildFilterList(context, bloc, state),
            const SizedBox(
              height: 16,
            ),
            _buildDataList(context, bloc, state),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterList(BuildContext context, CommunityBloc bloc, CommunityState state) {
    List<PostStatusType> postStatusTypeList = [
      PostStatusType.all,
      PostStatusType.active,
      PostStatusType.inactive_by_admin,
      PostStatusType.deleted_by_admin
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...[BoardGroupCategory.defaultCategory(), ...state.boardCategoryList]
                .map(
                  (item) => ActFilterButton(
                      text: item.displayName,
                      isSelected: state.boardCategory == item,
                      onPressed: () {
                        if (state.boardCategory != item) {
                          bloc.add(CommunityEvent.setBoardCategory(item));
                        }
                      }),
                )
                .toList(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...postStatusTypeList
                .map(
                  (item) => ActFilterButton(
                      text: item.title,
                      isSelected: state.postStatusType == item,
                      onPressed: () {
                        if (state.postStatusType != item) {
                          bloc.add(CommunityEvent.setPostStatusType(item));
                        }
                      }),
                )
                .toList()
          ],
        ),
      ],
    );
  }

  Widget _buildDataList(BuildContext context, CommunityBloc bloc, CommunityState state) {
    return Expanded(
      child: ListView(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double gridWidth = constraints.maxWidth - 600;
              final columns = [
                CustomColumn(width: 150, columnName: 'category', labelText: '카테고리'),
                CustomColumn(width: gridWidth, columnName: 'title', labelText: '제목'),
                CustomColumn(width: 150, columnName: 'status', labelText: '상태'),
                CustomColumn(width: 150, columnName: 'createdAt', labelText: '작성일'),
                CustomColumn(width: 100, columnName: 'viewCount', labelText: '조회수'),
                CustomColumn(width: 100, columnName: 'likeCount', labelText: '좋아요'),
                CustomColumn(width: 100, columnName: 'commentCount', labelText: '댓글'),
              ];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: ActDataGrid(
                    columns: columns,
                    dataSource: GenericDataSource<Post>(
                      data: state.postList,
                      columnNames: columns.map((e) => e.columnName).toList(),
                      valueExtractors: {
                        'category': (Post item, int index) => item.boardGroupCategory?.displayName,
                        'title': (Post item, int index) => item,
                        'status': (Post item, int index) => item.status.title,
                        'createdAt': (Post item, int index) => item.createdAt.toFormatString(),
                        'viewCount': (Post item, int index) => ConvertColumn.formatNumber(item.viewCount),
                        'likeCount': (Post item, int index) => ConvertColumn.formatNumber(item.likeCount),
                        'commentCount': (Post item, int index) => ConvertColumn.formatNumber(item.commentCount),
                      },
                      columnAlignments: {
                        'title': Alignment.centerLeft,
                      },
                      customWidgets: {
                        'title': (Post post) =>
                            DataGridTitleItem(title: post.title, isAttachment: post.thumbnailImageUrl?.isNotEmpty)
                      },
                    ),
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
                        bloc.add(const CommunityEvent.pageRefresh());
                      });
                    },
                  ),
                ),
              );
            },
          ),
          _buildPagination(context, bloc, state),
        ],
      ),
    );
  }

  Widget _buildPagination(BuildContext context, CommunityBloc bloc, CommunityState state) {
    if (state.postList.isNotEmpty) {
      return ActPagination<CommunityBloc, CommunityState>(
        paging: state.paging,
        onPageChange: (int page) {
          bloc.add(CommunityEvent.fetchCommunityPosts(
            page: page,
          ));
        },
      );
    }

    return Container();
  }
}
