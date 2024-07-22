part of 'screen.dart';

extension _PostDetailScreenStateExtension on _PostDetailScreenState {
  void _onBlockPostUser(int userId) {
    context.showConfirmDialog(title: '안내', message: '해당 사용자를 차단하시겠습니까?').then((confirmRes) {
      if (confirmRes) {
        GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(PostDetailEvent.blockPost(userId));
      }
    });
  }

  void _onReportPost(int postId) {
    ActReportReasonDialog.show(context: context).then((String? reason) {
      if (reason != null) {
        GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(PostDetailEvent.reportPost(postId, reason));
      }
    });
  }

  void _onUpdatePost(Post post) async {
    final bool? postUpdateRes = await context.router.push(PostSaveRoute(post: post));
    if (postUpdateRes == true) {
      GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(const PostDetailEvent.fetchPost());
    }
  }

  void _onDeletePost(int postId) {
    context.showConfirmDialog(title: '안내', message: '해당 글을 삭제하시겠습니까?').then((confirmRes) {
      if (confirmRes) {
        GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(PostDetailEvent.deletePost(postId));
      }
    });
  }

  void _onSelectUserAction(UserActionOnPost action) {
    final UserAuthService userAuthService = GetIt.I<UserAuthService>();
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    final PostDetailState state = GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').state;

    switch (action) {
      case UserActionOnPost.block:
        if (state.post!.userId == null) return;
        _onBlockPostUser(state.post!.userId!);
        break;

      case UserActionOnPost.report:
        _onReportPost(state.post!.id);
        break;

      case UserActionOnPost.update:
        _onUpdatePost(state.post!);
        break;

      case UserActionOnPost.delete:
        _onDeletePost(state.post!.id);
        break;
      default:
    }
  }

  void _onPressReplyButton(Comment comment) {
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    if (GetIt.I.isRegistered<ActReplyListWidgetBloc>(instanceName: 'comment_${comment.id}')) {
      final ActReplyListWidgetBloc replyBloc = GetIt.I<ActReplyListWidgetBloc>(instanceName: 'comment_${comment.id}');
      replyBloc.add(const ActReplyListWidgetEvent.toggleIsWritingReply());
    }
  }

  void _onBlockComment(Comment comment) {
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    context.showConfirmDialog(title: '안내', message: '해당 댓글을 차단하시겠습니까?').then((confirmRes) {
      if (confirmRes) {
        GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}')
            .add(PostDetailEvent.blockComment(comment.userId));
      }
    });
  }

  void _onReportComment(Comment comment) {
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    ActReportReasonDialog.show(context: context).then((String? reason) {
      if (reason != null) {
        GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}')
            .add(PostDetailEvent.reportComment(comment.id, reason));
      }
    });
  }

  void _onUpdateComment(Comment comment) {
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}')
        .add(PostDetailEvent.toggleUpdatingComment(comment.id));
  }

  void _onDeleteComment(Comment comment) {
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    context.showConfirmDialog(title: '안내', message: '해당 댓글을 삭제하시겠습니까?').then((confirmRes) {
      if (confirmRes) {
        GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}')
            .add(PostDetailEvent.deleteComment(commentId: comment.id));
      }
    });
  }

  void _onToggleCommentLike(Comment comment) {
    if (userAuthService.isAuthenticated() == false) {
      ActLoginDialog.tryLogin(context);
      return;
    }

    if (comment.liked) {
      GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(PostDetailEvent.unLikeComment(comment.id));
    } else {
      GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(PostDetailEvent.likeComment(comment.id));
    }
  }

  void _onChageCommentSortType(BoardSortType sortType) {
    GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}').add(PostDetailEvent.changeCommentSortType(sortType));
  }
}

void _onPressPostLikeButton(BuildContext context, bool isLiked, int postId) {
  final UserAuthService userAuthService = GetIt.I<UserAuthService>();
  if (userAuthService.isAuthenticated() == false) {
    ActLoginDialog.tryLogin(context);
    return;
  }

  if (isLiked) {
    context.read<PostDetailBloc>().add(PostDetailEvent.unLikePost(postId));
  } else {
    context.read<PostDetailBloc>().add(PostDetailEvent.likePost(postId));
  }
}

void _onVotePressed(BuildContext context, int postId, int pollId, List<int> answers) {
  final UserAuthService userAuthService = GetIt.I<UserAuthService>();
  if (userAuthService.isAuthenticated() == false) {
    ActLoginDialog.tryLogin(context);
    return;
  }

  if (answers.isEmpty) return;

  final PostDetailBloc bloc = GetIt.I<PostDetailBloc>(instanceName: 'post_$postId');

  bloc.add(PostDetailEvent.votePoll(answers, pollId));
}

void _onReVotePressed(BuildContext context, int postId, int pollId) {
  final UserAuthService userAuthService = GetIt.I<UserAuthService>();
  if (userAuthService.isAuthenticated() == false) {
    ActLoginDialog.tryLogin(context);
    return;
  }

  final PostDetailBloc bloc = GetIt.I<PostDetailBloc>(instanceName: 'post_$postId');

  bloc.add(PostDetailEvent.reVotePoll(pollId));
}
