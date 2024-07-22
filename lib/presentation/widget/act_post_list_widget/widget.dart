import 'package:act_web/config/theme.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/presentation/widget/act_filter_checked_button.dart';
import 'package:act_web/presentation/widget/act_pagination.dart';
import 'package:act_web/presentation/widget/act_post_list_widget/bloc/bloc.dart';
import 'package:act_web/presentation/widget/action_post_list_item_widget.dart';
import 'package:act_web/presentation/widget/post_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

part 'widget/page_size_changer_widget.dart';
part 'widget/board_group_category_selection.dart';

class ActPostListWidget extends StatefulWidget {
  final String stockCode;
  final BoardGroupType boardGroupType;
  final String? boardCategory;

  const ActPostListWidget({
    super.key,
    required this.stockCode,
    required this.boardGroupType,
    this.boardCategory,
  });

  @override
  State<ActPostListWidget> createState() => _ActPostListWidgetState();
}

class _ActPostListWidgetState extends State<ActPostListWidget> {
  OverlayEntry? _overlay;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActPostListWidgetBloc(stockCode: widget.stockCode, boardGroupType: widget.boardGroupType)
        ..add(const ActPostListWidgetEvent.init()),
      child: BlocListener<ActPostListWidgetBloc, ActPostListWidgetState>(
        listener: (context, state) {
          if (state.isLoading) {
            _showLoading(context);
          } else {
            _hideLoading();
          }

          if (state.errorToastMessage?.isNotEmpty == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorToastMessage!),
              backgroundColor: context.colorScheme.error,
            ));
          }
        },
        child: BlocBuilder<ActPostListWidgetBloc, ActPostListWidgetState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.boardGroupType.title.isNotEmpty)
                      Text(
                        widget.boardGroupType.title,
                        style: context.textTheme.displayLarge?.copyWith(fontSize: 28.0, height: 1.3),
                      ),
                    if (state.boardGroupCategoryList.length > 1) ...[
                      const SizedBox(width: 20.0),
                      Flexible(
                        child: _BoardGroupCategorySelection(
                          categories: state.boardGroupCategoryList,
                          selectedCategory: state.selectedBoardGroupCategory,
                          onChange: (BoardGroupCategory boardGroupCategory) {
                            context
                                .read<ActPostListWidgetBloc>()
                                .add(ActPostListWidgetEvent.changeBoardGroupCategory(boardGroupCategory));
                          },
                        ),
                      ),
                    ]
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: state.boardSortTypeList
                          .map(
                            (BoardSortType boardSortType) => ActFilterCheckedButton(
                              text: boardSortType.title,
                              isChecked: boardSortType == state.selectedBoardSortType,
                              onTap: () {
                                context
                                    .read<ActPostListWidgetBloc>()
                                    .add(ActPostListWidgetEvent.changeBoardSortType(boardSortType));
                              },
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _PageSizeChangerWidget(
                          isCurrentPageSize: state.paging.size == 10,
                          pageSize: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('/'),
                        ),
                        _PageSizeChangerWidget(
                          isCurrentPageSize: state.paging.size == 20,
                          pageSize: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('/'),
                        ),
                        _PageSizeChangerWidget(
                          isCurrentPageSize: state.paging.size == 50,
                          pageSize: 50,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Container(height: 1, color: Colors.grey.shade300),
                ...List.generate(state.postList.length, (int index) {
                  final Post post = state.postList[index];

                  return Column(
                    children: [
                      post.boardGroupType == BoardGroupType.action
                          ? ActionPostListItemWidget(
                              title: post.title,
                              actionEndDate: post.digitalDocument?.targetEndDate ?? DateTime.now(),
                              postDetailpath: post.getDetailRoutePath(
                                stockCode: widget.stockCode,
                                boardGroupType: widget.boardGroupType,
                              ),
                              boardGroupCategory: post.boardGroupCategory,
                              digitalDocument: post.digitalDocument,
                              poll: post.polls?.isNotEmpty == true ? post.polls?.first : null,
                            )
                          : PostListItemWidget(
                              title: post.title,
                              isUploadedImageExist: post.thumbnailImageUrl?.isNotEmpty == true,
                              nickname: post.userProfile?.nickname ?? '',
                              boardGroupCategory: post.boardGroupCategory,
                              createdAt: post.createdAt,
                              likeCount: post.likeCount,
                              viewCount: post.viewCount,
                              commentCount: post.commentCount,
                              postDetailpath: post.getDetailRoutePath(
                                stockCode: widget.stockCode,
                                boardGroupType: widget.boardGroupType,
                              ),
                            ),
                      if (index != state.postList.length - 1) Container(height: 1, color: Colors.grey.shade300),
                    ],
                  );
                }),
                if (state.postList.isNotEmpty) ...[
                  const SizedBox(height: 12.0),
                  ActPagination<ActPostListWidgetBloc, ActPostListWidgetState>(
                    paging: state.postPaging,
                    onChangePage: (int page) {
                      context.read<ActPostListWidgetBloc>().add(ActPostListWidgetEvent.changePage(page: page));
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLoading(BuildContext context) {
    if (_overlay != null) {
      return;
    }
    _overlay = OverlayEntry(
      builder: (_) => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: SpinKitCircle(
            color: context.colorScheme.primary,
            size: 50.0,
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlay!);
  }

  void _hideLoading() {
    _overlay?.remove();
    _overlay = null;
  }
}
