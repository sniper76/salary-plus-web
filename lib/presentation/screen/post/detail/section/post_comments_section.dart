part of '../screen.dart';

class _PostCommentsSection extends StatefulWidget {
  final BoardSortType sortType;
  final int totalCommentCount;
  final List<Comment> comments;
  final String stockCode;
  final BoardGroupType boardGroupType;
  final int postId;
  final Function(Comment comment)? onDeleteComment;
  final Function(Comment comment)? onCommentUpdate;
  final Function(Comment comment)? onCommentReport;
  final Function(Comment comment)? onCommentBlock;
  final Function(Comment comment)? onToggleCommentLike;
  final Function(Comment comment)? onReplyPressed;

  final void Function(BoardSortType boardSortType)? onChangeSortType;

  const _PostCommentsSection({
    required this.sortType,
    required this.totalCommentCount,
    required this.comments,
    required this.stockCode,
    this.onChangeSortType,
    this.onDeleteComment,
    this.onCommentUpdate,
    this.onCommentReport,
    this.onCommentBlock,
    this.onToggleCommentLike,
    this.onReplyPressed,
    required Post post,
    required this.boardGroupType,
    required this.postId,
  });

  @override
  State<_PostCommentsSection> createState() => _PostCommentsSectionState();
}

class _PostCommentsSectionState extends State<_PostCommentsSection> {
  final UserAuthService userAuthService = GetIt.I<UserAuthService>();

  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _commentControllerForUpdate = TextEditingController();

  late final Map<UserActionOnPost, Function(Comment comment)?> commentMenuActionMap = {
    UserActionOnPost.delete: widget.onDeleteComment,
    UserActionOnPost.update: widget.onCommentUpdate,
    UserActionOnPost.block: widget.onCommentBlock,
    UserActionOnPost.report: widget.onCommentReport,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '댓글 ${widget.totalCommentCount.toNumberFormat}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [BoardSortType.createdAtAsc, BoardSortType.likeCount]
                    .map(
                      (BoardSortType itemSortType) => ActFilterCheckedButton(
                        text: itemSortType.title,
                        isChecked: itemSortType == widget.sortType,
                        onTap: widget.onChangeSortType != null ? () => widget.onChangeSortType!(itemSortType) : null,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        ActCommentTextField(
          commentController: _commentController,
          isAnonymousChecked: context.read<PostDetailBloc>().state.isWritingAnonymousComment,
          onChangeAnonymousCheck: (bool _) {
            context.read<PostDetailBloc>().add(const PostDetailEvent.toggleAnonymousCommentWriting());
          },
          onSubmitComment: () {
            context.read<PostDetailBloc>().add(PostDetailEvent.createComment(_commentController.text));
          },
        ),
        const SizedBox(
          height: 18.0,
        ),
        ...widget.comments.map(
          (comment) => context.read<PostDetailBloc>().state.updatingCommentId == comment.id
              ? Column(
                  children: [
                    ActTextFormField(
                      controller: _commentControllerForUpdate,
                      maxLines: null,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<PostDetailBloc>().add(const PostDetailEvent.toggleUpdatingComment(null));
                                context.read<PostDetailBloc>().add(PostDetailEvent.updateComment(
                                      commentId: comment.id,
                                      content: _commentControllerForUpdate.text,
                                    ));

                                _commentControllerForUpdate.clear();
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
                )
              : Column(
                  children: [
                    ActCommentItemWidget(
                      comment: comment,
                      stockCode: widget.stockCode,
                      onSelectUserAction: (action) async {
                        commentMenuActionMap[action]!(comment);
                      },
                      onLikePressed:
                          widget.onToggleCommentLike != null ? () => widget.onToggleCommentLike!(comment) : null,
                      onReplyPressed: widget.onReplyPressed != null ? () => widget.onReplyPressed!(comment) : () {},
                      isReply: false,
                      boardGroupType: widget.boardGroupType,
                      postId: widget.postId,
                      isOwner: comment.userId == userAuthService.userMe?.id,
                    ),
                    ActReplyListWidget(
                      key: ValueKey(comment.id),
                      postId: widget.postId,
                      stockCode: widget.stockCode,
                      boardGroupType: widget.boardGroupType,
                      comment: comment,
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      color: context.colorScheme.outline,
                    ),
                  ],
                ),
        ),
        if (widget.comments.isEmpty)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                '첫 댓글을 남겨보세요',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
              ),
            ),
          ),
        if (widget.totalCommentCount > widget.comments.length)
          InkWell(
            onTap: () {
              context.read<PostDetailBloc>().add(const PostDetailEvent.loadMoreComment());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 48.0, top: 12.0),
              child: Text(
                '댓글 ${min(10, widget.totalCommentCount - widget.comments.length)}개 더보기',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.primaryColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
