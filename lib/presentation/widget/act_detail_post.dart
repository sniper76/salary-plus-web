import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/enum/poll_selection_type.dart';
import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/widget/act_round_based_widget.dart';
import 'package:act_cms/presentation/widget/holder_list_read_and_copy_docs_widget.dart';
import 'package:act_cms/presentation/widget/poll_view.dart';
import 'package:act_cms/presentation/widget/post_detail_view.dart';
import 'package:act_cms/presentation/widget/post_profile.dart';
import 'package:flutter/material.dart';

class ActDetailPost extends StatefulWidget {
  final Post post;
  final String boardGroupCategoryName;
  final void Function()? onTapDownloadButton;

  const ActDetailPost({
    super.key,
    required this.post,
    required this.boardGroupCategoryName,
    this.onTapDownloadButton,
  });

  @override
  State<ActDetailPost> createState() => _ActDetailPostState();
}

class _ActDetailPostState extends State<ActDetailPost> {
  @override
  Widget build(BuildContext context) {
    return ActRoundBasedWidget(child: buildPost());
  }

  Widget buildPost() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 8,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '[${widget.boardGroupCategoryName}]',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
              Text(
                widget.post.stock?.name ?? '',
                style: context.textTheme.headlineSmall,
              ),
              Text(
                widget.post.stock?.code ?? '',
                style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade300),
              ),
              if (widget.post.status != PostStatusType.active)
                Text(
                  '[${widget.post.status.title}]',
                  style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade500),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          child: Text(widget.post.title, style: context.textTheme.displaySmall),
        ),
        PostProfile(
          userProfile: widget.post.displayUserProfile,
          stockCode: widget.post.stock?.code ?? '',
          userId: widget.post.userId ?? 0,
          dateTime: widget.post.createdAt,
          viewCount: widget.post.viewCount,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        if (widget.post.isHolderListReadAndCopyPost && widget.post.holderListReadAndCopyDigitalDocument != null)
          HolderListReadAndCopyDocsWidget(
            digitalDocument: widget.post.holderListReadAndCopyDigitalDocument!,
            onTapDownloadButton: widget.onTapDownloadButton,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PostDetailView(
            content: widget.post.content?.replaceAll('\n', '<br/>') ?? '',
            postImages: widget.post.postImages,
          ),
        ),
        if (widget.post.polls != null && widget.post.polls?.isNotEmpty == true)
          ...widget.post.polls!.map(
            (poll) => _buildPoll(poll),
          ),
      ],
    );
  }

  Widget _buildPoll(Poll poll) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(poll.content ?? ''),
          PollView(
            viewType: poll.answers?.isNotEmpty == true ? PollViewType.result : PollViewType.vote,
            isEnded: poll.isEnded,
            isMultipleChoice: poll.selectionType == PollSelectionType.multiple,
            isShareholderBase: poll.voteType == PollVoteType.shareholder,
            title: poll.title,
            choices: poll.pollItems.map((e) {
              return PollItem(
                text: e.text,
                value: e.id,
                answerCount: e.voteCount,
                answerStock: e.stockSum,
              );
            }).toList(),
            totalAnswerCount: poll.pollItems.fold<int>(0, (total, e) => total + e.stockSum),
            totalAnswerPersonCount: poll.pollItems.fold<int>(0, (total, e) => total + e.voteCount),
            answers: poll.isActive == true && poll.answers != null
                ? poll.answers!.map((answer) => answer.pollItemId).toList()
                : [],
          ),
        ],
      ),
    );
  }
}
