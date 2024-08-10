import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/domain/model/enum/board_sort_type.dart';
import 'package:act_cms/domain/model/write_count.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/reply/bloc/reply_list_bloc.dart';
import 'package:act_cms/presentation/widget/comment_register_widget.dart';
import 'package:act_cms/presentation/widget/comment_update_widget.dart';
import 'package:act_cms/presentation/widget/filter_checked_button.dart';
import 'package:act_cms/presentation/widget/reply_list_item.dart';
import 'package:act_cms/presentation/widget/sub_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ReplyListScreen extends StatefulWidget {
  final String stockCode;
  final String boardGroup;
  final int postId;
  final Comment comment;

  const ReplyListScreen({
    super.key,
    required this.stockCode,
    required this.boardGroup,
    required this.postId,
    required this.comment,
  });

  @override
  State<ReplyListScreen> createState() => _ReplyListScreenState();
}

class _ReplyListScreenState extends State<ReplyListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _replyTextController = TextEditingController();
  final _replyFocusNode = FocusNode();

  _onChangedSortType(BoardSortType boardSortType) {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;

    bloc.add(ReplyListEvent.sort(boardSortType));
  }

  _onChangedCommentAnonymous(
    bool isAnonymous,
    WriteCount? writeCount,
  ) {
    if (writeCount != null && isAnonymous) {
      EasyLoading.showToast('익명 작성 잔여 횟수 : ${writeCount.remainingCount}회 (최대: ${writeCount.max}회)');
    }
  }

  _onClearReplyInput() {
    _replyTextController.clear();
    _replyFocusNode.unfocus();
    _onChangedCommentAnonymous(false, null);
  }

  _onUpdateScroll() {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;

    if (_scrollController.position.extentAfter < loadMoreScrollPosition) {
      // ignore: prefer_const_constructors
      bloc.add(ReplyListEvent.loadMore());
    }
  }

  _onCommentDeletePressed({
    required Comment comment,
  }) async {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;
    final confirm = await context.showConfirmDialog(title: '댓글 삭제', message: '댓글을 삭제하시겠습니까?');
    if (confirm) {
      bloc.add(ReplyListEvent.deleteComment(
        comment: comment,
        boardGroup: widget.boardGroup,
        postId: widget.postId,
        stockCode: widget.stockCode,
      ));
    }
  }

  _onCommentActivePressed({
    required Comment comment,
  }) async {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;
    final confirm = await context.showConfirmDialog(title: '댓글 삭제 취소', message: '댓글을 삭제를 취소 하시겠습니까?');
    if (confirm) {
      bloc.add(ReplyListEvent.activeComment(
        comment: comment,
        boardGroup: widget.boardGroup,
        postId: widget.postId,
        stockCode: widget.stockCode,
      ));
    }
  }

  _onCommentEditPressed({
    required Comment editTargetComment,
  }) async {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;

    bloc.add(ReplyListEvent.activateCommentEditingMode(true, editTargetComment));
  }

  _onUpdateComment(String editedContent, Comment comment) {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;

    bloc.add(
      ReplyListEvent.editComment(
        editedContent: editedContent,
        boardGroup: widget.boardGroup,
        postId: widget.postId,
        commentId: comment.id,
        stockCode: widget.stockCode,
      ),
    );
  }

  _onSaveNewComment(content, isAnonymous) {
    final bloc = _scaffoldKey.currentContext?.read<ReplyListBloc>();
    if (bloc == null) return;

    bloc.add(ReplyListEvent.saveReply(
      text: content,
      isAnonymous: isAnonymous,
      commentId: widget.comment.id,
      boardGroup: widget.boardGroup,
      postId: widget.postId,
      stockCode: widget.stockCode,
    ));
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onUpdateScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onUpdateScroll);
    _replyFocusNode.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BaseBlocLayout<ReplyListBloc, ReplyListState>(
        scaffoldKey: _scaffoldKey,
        appBar: SubAppBar(
          context: context,
          title: '답글',
        ),
        create: (context) => ReplyListBloc(
          stockCode: widget.stockCode,
          boardGroup: widget.boardGroup,
          postId: widget.postId,
          comment: widget.comment,
          // ignore: prefer_const_constructors
        )..add(ReplyListEvent.init()),
        listener: (context, state) {
          if (state.isSuccessReplySaved) {
            _onClearReplyInput();
          }
        },
        builder: (context, bloc, state) {
          return Stack(
            children: [
              Positioned.fill(
                bottom: 52,
                child: Column(
                  children: [
                    _buildHeaderReply(state),
                    if (state.comment != null) _buildParentComment(state),
                    Container(
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        color: context.colorScheme.outline),
                    _buildReplyList(state),
                    _buildCreateComment(bloc),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReplyList(ReplyListState state) {
    return Expanded(
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 12, bottom: 20, left: 46, right: 20),
        itemCount: state.replies.length,
        itemBuilder: (context, index) {
          final reply = state.replies[index];
          return ReplyListItem(
            comment: reply,
            enabledReply: false,
            onCommentDeletePressed: () {
              _onCommentDeletePressed(comment: reply);
            },
            onCommentActivePressed: () {
              _onCommentActivePressed(comment: reply);
            },
            onCommentEditPressed: () {
              _onCommentEditPressed(editTargetComment: reply);
            },
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 12),
            color: context.colorScheme.outline,
          );
        },
      ),
    );
  }

  Widget _buildParentComment(ReplyListState state) {
    return ReplyListItem(
      comment: state.comment!,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      enabledReply: false,
      enableMoreButton: false,
      onCommentDeletePressed: () {
        _onCommentDeletePressed(comment: state.comment!);
      },
      onCommentActivePressed: () {
        _onCommentActivePressed(comment: state.comment!);
      },
      onCommentEditPressed: () {
        _onCommentEditPressed(editTargetComment: state.comment!);
      },
    );
  }

  Widget _buildHeaderReply(ReplyListState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [BoardSortType.createdAtAsc, BoardSortType.likeCount]
            .map((e) => FilterCheckedButton(
                  text: e.title,
                  isChecked: e == state.sortType,
                  onTap: () => _onChangedSortType(e),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCreateComment(ReplyListBloc bloc) {
    return SizedBox(
      height: 110,
      child: bloc.state.isEditingComment && bloc.state.curEditingComment != null
          ? CommentEditWidget(
              comment: bloc.state.curEditingComment!,
              onUpdate: _onUpdateComment,
            )
          : CommentRegisterWidget(
              onSave: _onSaveNewComment,
            ),
    );
  }
}
