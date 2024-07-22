import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/user_action_on_post.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/presentation/widget/act_comment_item_widget.dart';
import 'package:act_web/presentation/widget/act_comment_text_field.dart';
import 'package:act_web/presentation/widget/act_reply_list_widget/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_report_reason_dialog.dart';
import 'package:act_web/presentation/widget/act_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ActReplyListWidget extends StatefulWidget {
  final int postId;
  final String stockCode;
  final BoardGroupType boardGroupType;
  final Comment comment;

  const ActReplyListWidget({
    super.key,
    required this.postId,
    required this.stockCode,
    required this.boardGroupType,
    required this.comment,
  });

  @override
  State<ActReplyListWidget> createState() => _ActReplyListWidgetState();
}

class _ActReplyListWidgetState extends State<ActReplyListWidget> {
  final TextEditingController _replyControllerForCreate = TextEditingController();
  final TextEditingController _replyControllerForUpdate = TextEditingController();

  @override
  void didChangeDependencies() {
    if (GetIt.I.isRegistered<ActReplyListWidgetBloc>(instanceName: 'comment_${widget.comment.id}') == false) {
      GetIt.I.registerSingleton<ActReplyListWidgetBloc>(
        ActReplyListWidgetBloc(
          postId: widget.postId,
          stockCode: widget.stockCode,
          boardGroupType: widget.boardGroupType,
          commentId: widget.comment.id,
          firstPageReplyList: widget.comment.replyComments,
          totalReplyCount: widget.comment.replyCommentCount,
        ),
        instanceName: 'comment_${widget.comment.id}',
      );
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ActReplyListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ActReplyListWidgetBloc>(instanceName: 'comment_${widget.comment.id}')
        ..add(const ActReplyListWidgetEvent.init()),
      child: BlocBuilder<ActReplyListWidgetBloc, ActReplyListWidgetState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state.isWritingReply)
                ActCommentTextField(
                  commentController: _replyControllerForCreate,
                  isAnonymousChecked: state.isWritingAnonymousReply,
                  onChangeAnonymousCheck: (_) {
                    context.read<ActReplyListWidgetBloc>().add(const ActReplyListWidgetEvent.toggleAnonymousWriting());
                  },
                  onSubmitComment: () {
                    context
                        .read<ActReplyListWidgetBloc>()
                        .add(ActReplyListWidgetEvent.createReply(_replyControllerForCreate.text));
                    _replyControllerForCreate.clear();
                    context.read<ActReplyListWidgetBloc>().add(const ActReplyListWidgetEvent.toggleIsWritingReply());
                  },
                  hintText: '답글을 남겨보세요.',
                ),
              ...state.replyList.map((Comment reply) {
                if (state.updatingReplyId == reply.id) {
                  return Column(
                    children: [
                      ActTextFormField(
                        controller: _replyControllerForUpdate,
                        maxLines: null,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.read<ActReplyListWidgetBloc>().add(
                                        const ActReplyListWidgetEvent.toggleUpdatingReply(null),
                                      );
                                  context.read<ActReplyListWidgetBloc>().add(
                                        ActReplyListWidgetEvent.updateReply(
                                            replyId: reply.id,
                                            content: _replyControllerForUpdate.text,
                                            isAnonymous: false),
                                      );

                                  _replyControllerForUpdate.clear();
                                },
                                child: ClipOval(
                                  child: Container(
                                    width: 24.0,
                                    height: 24.0,
                                    color: context.colorScheme.primary,
                                    child: const Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ActCommentItemWidget(
                        comment: reply,
                        stockCode: widget.stockCode,
                        margin: const EdgeInsets.only(top: 16.0, left: 48),
                        enabledReply: false,
                        enableMoreButton: true,
                        isReply: true,
                        commentOwnerNickname: widget.comment.userProfile?.nickname ?? '',
                        boardGroupType: widget.boardGroupType,
                        postId: widget.postId,
                        isOwner: reply.userId == GetIt.I<UserAuthService>().userMe?.id,
                        onLikePressed: () {
                          if (reply.liked) {
                            context.read<ActReplyListWidgetBloc>().add(ActReplyListWidgetEvent.unLike(reply.id));
                          } else {
                            context.read<ActReplyListWidgetBloc>().add(ActReplyListWidgetEvent.like(reply.id));
                          }
                        },
                        onSelectUserAction: (action) async {
                          switch (action) {
                            case UserActionOnPost.delete:
                              context
                                  .read<ActReplyListWidgetBloc>()
                                  .add(ActReplyListWidgetEvent.deleteReply(replyId: reply.id));
                              break;
                            case UserActionOnPost.update:
                              _replyControllerForUpdate.text = reply.content;
                              context
                                  .read<ActReplyListWidgetBloc>()
                                  .add(ActReplyListWidgetEvent.toggleUpdatingReply(reply.id));
                              break;
                            case UserActionOnPost.block:
                              context
                                  .read<ActReplyListWidgetBloc>()
                                  .add(ActReplyListWidgetEvent.blockReply(reply.userId));
                              break;
                            case UserActionOnPost.report:
                              ActReportReasonDialog.show(context: context).then((String? reason) {
                                if (reason?.isNotEmpty == true) {
                                  context
                                      .read<ActReplyListWidgetBloc>()
                                      .add(ActReplyListWidgetEvent.reportReply(reply.id, reason!));
                                }
                              });

                              break;
                            default:
                          }
                        },
                      ),
                      if (state.replyList.last == reply && state.hasMoreReplies)
                        InkWell(
                          onTap: () {
                            context.read<ActReplyListWidgetBloc>().add(const ActReplyListWidgetEvent.loadMore());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 48.0, top: 12.0),
                            child: Text(
                              '답글 ${state.remainingReplyCount}개 더보기',
                              style: context.textTheme.bodyMedium?.copyWith(color: context.theme.primaryColor),
                            ),
                          ),
                        ),
                    ],
                  );
                }
              })
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<ActReplyListWidgetBloc>(instanceName: 'comment_${widget.comment.id}');
    super.dispose();
  }
}
