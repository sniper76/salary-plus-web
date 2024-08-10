import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:act_cms/presentation/bottomsheet/bottom_sheet_menu.dart';
import 'package:act_cms/presentation/bottomsheet/comment_menu_bottom_sheet.dart';
import 'package:act_cms/presentation/bottomsheet/reason_bottom_sheet.dart';
import 'package:act_cms/presentation/widget/act_comment_list/bloc/act_comment_list_bloc.dart';
import 'package:act_cms/presentation/widget/act_divide.dart';
import 'package:act_cms/presentation/widget/comment_register_widget.dart';
import 'package:act_cms/presentation/widget/comment_update_widget.dart';
import 'package:act_cms/presentation/widget/filter_checked_button.dart';
import 'package:act_cms/presentation/widget/loading_list_item.dart';
import 'package:act_cms/presentation/widget/reply_list_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActCommentsList extends StatefulWidget {
  final String stockCode;
  final String stockName;
  final String boardGroup;
  final User? userMe;

  const ActCommentsList({
    super.key,
    required this.stockCode,
    required this.stockName,
    required this.boardGroup,
    this.userMe,
  });

  @override
  State<ActCommentsList> createState() => _ActCommentsListState();
}

class _ActCommentsListState extends State<ActCommentsList> {
  final _scrollController = ScrollController();
  late ActCommentListBloc _actCommentListBloc;

  void _onMenuPressed({required Comment comment, required BuildContext context}) async {
    final bool isOwner = comment.userId == widget.userMe?.id;
    final BottomSheetMenu? ret = await CommentMenuBottomSheet.show(context, isOwner: isOwner);
    if (ret != null) {
      if (ret == BottomSheetMenu.delete) {
        final confirm = await context.showConfirmDialog(title: '댓글 삭제', message: '댓글을 삭제하시겠습니까?');
        if (confirm) {}
      } else if (ret == BottomSheetMenu.modify) {
        // _onCommentEdit(comment);
      } else if (ret == BottomSheetMenu.report) {
        final String? ret = await ReasonBottomSheet.show(context);
        if (ret != null) {
          _actCommentListBloc.add(
            ActCommentListEvent.reportComment(comment, ret),
          );
        }
      }
    }
  }

  void _onCommentDeletePressed({required Comment comment, required BuildContext context, required int postId}) async {
    final bool confirm = await context.showConfirmDialog(title: '댓글 삭제', message: '댓글을 삭제하시겠습니까?');
    if (confirm) {
      _actCommentListBloc.add(
        ActCommentListEvent.deleteComment(
          comment: comment,
          boardGroup: widget.boardGroup,
          postId: postId,
          stockCode: widget.stockCode,
        ),
      );
    }
  }

  void _onCommentActivePressed({required Comment comment, required BuildContext context, required int postId}) async {
    final confirm = await context.showConfirmDialog(title: '댓글 삭제 취소', message: '댓글을 삭제를 취소 하시겠습니까?');
    if (confirm) {
      _actCommentListBloc.add(ActCommentListEvent.activeComment(
        comment: comment,
        boardGroup: widget.boardGroup,
        postId: postId,
        stockCode: widget.stockCode,
      ));
    }
  }

  void _onCommentEditPressed({required Comment comment, required BuildContext context}) async {
    final ActCommentListBloc actCommentListBloc = context.read<ActCommentListBloc>();
    actCommentListBloc.add(
      ActCommentListEvent.activateCommentEditingMode(
        true,
        comment,
      ),
    );
  }

  void _onReplyPressed({required Comment comment, required BuildContext context, required int postId}) {
    context.router.push(ReplyListRoute(
      stockCode: widget.stockCode,
      boardGroup: widget.boardGroup,
      postId: postId,
      comment: comment,
    ));
  }

  _onUpdateComment(String editedContent, Comment comment) {
    _actCommentListBloc.add(
      ActCommentListEvent.editComment(
        editedContent: editedContent,
        boardGroup: widget.boardGroup,
        postId: _actCommentListBloc.state.post.id,
        commentId: comment.id,
        stockCode: widget.stockCode,
      ),
    );
  }

  _onSaveNewComment(String content, bool isAnonymous) {
    _actCommentListBloc.add(
      ActCommentListEvent.saveComment(
        text: content,
        isAnonymous: isAnonymous,
        boardGroup: widget.boardGroup,
        postId: _actCommentListBloc.state.post.id,
        stockCode: widget.stockCode,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _actCommentListBloc = BlocProvider.of<ActCommentListBloc>(context);
    _actCommentListBloc.add(const ActCommentListEvent.init());

    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter < loadMoreScrollPosition) {
        _actCommentListBloc.add(const ActCommentListEvent.loadMoreComments());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {
      if (_scrollController.position.extentAfter < loadMoreScrollPosition) {
        _actCommentListBloc.add(const ActCommentListEvent.loadMoreComments());
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActCommentListBloc, ActCommentListState>(
      builder: (BuildContext context, ActCommentListState state) {
        return Column(
          children: [
            _buildCommentsListHeader(state),
            Expanded(child: _buildCommentListView(context, state)),
            if (widget.userMe?.isAdmin == true) _buildCreateComment(state),
          ],
        );
      },
    );
  }

  Widget _buildCommentsListHeader(ActCommentListState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCommentCount(state),
        Wrap(
          children: [BoardSortType.createdAtAsc, BoardSortType.likeCount]
              .map((BoardSortType sortType) => FilterCheckedButton(
                    text: sortType.title,
                    isChecked: sortType == state.sortType,
                    onTap: () {
                      _actCommentListBloc.add(
                        ActCommentListEvent.sortComments(sortType),
                      );
                    },
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildCommentCount(ActCommentListState state) {
    return Text(
      '댓글 ${state.paging.total.toNumberFormat}',
      style: context.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCommentListView(BuildContext context, ActCommentListState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: ListView(
        controller: _scrollController,
        children: [
          ...state.comments.map(
            (Comment comment) => Column(
              children: [
                ReplyListItem(
                  key: ValueKey('post-comment-${comment.id}-${comment.createdAt}'),
                  comment: comment,
                  stockCode: widget.stockCode,
                  onMenuPressed: () {
                    _onMenuPressed(comment: comment, context: context);
                  },
                  onCommentDeletePressed: () {
                    _onCommentDeletePressed(comment: comment, context: context, postId: state.post.id);
                  },
                  onCommentActivePressed: () {
                    _onCommentActivePressed(comment: comment, context: context, postId: state.post.id);
                  },
                  onCommentEditPressed: () {
                    _onCommentEditPressed(comment: comment, context: context);
                  },
                  onLikePressed: () {},
                  onReplyPressed: () {
                    _onReplyPressed(comment: comment, context: context, postId: state.post.id);
                  },
                  isAdmin: widget.userMe?.isAdmin ?? false,
                  isReport: comment.reported,
                ),
                _buildDivide(),
              ],
            ),
          ),
          if (state.comments.isEmpty) _buildEmptyComment(),
          if (state.isCommentMoreLoading) const LoadingListItem(),
        ],
      ),
    );
  }

  Widget _buildDivide() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ActDivide(),
    );
  }

  Widget _buildEmptyComment() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: Text(
          '댓글이 없습니다.',
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
      ),
    );
  }

  Widget _buildCreateComment(ActCommentListState state) {
    return SizedBox(
      height: 110,
      child: state.isEditingComment && state.curEditingComment != null
          ? CommentEditWidget(
              comment: state.curEditingComment!,
              onUpdate: _onUpdateComment,
            )
          : CommentRegisterWidget(
              onSave: _onSaveNewComment,
            ),
    );
  }
}
