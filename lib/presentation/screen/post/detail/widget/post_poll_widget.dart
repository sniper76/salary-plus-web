part of '../screen.dart';

class PostPollWidget extends StatelessWidget {
  final int postId;
  final Poll poll;

  const PostPollWidget({
    super.key,
    required this.poll,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (poll.content != null) Text(poll.content ?? ''),
          const SizedBox(height: 12),
          ActPollWidget(
            pollId: poll.id,
            viewType: poll.viewType,
            isEnded: poll.isEnded,
            isMultipleChoice: poll.selectionType == PollSelectionType.multiple,
            isShareholderBase: poll.voteType == PollVoteType.shareholder,
            title: poll.title,
            choices: poll.pollItems,
            totalAnswerCount: poll.pollItems.fold<int>(0, (total, e) => total + e.voteItemStockSum),
            totalAnswerPersonCount: poll.pollItems.fold<int>(0, (total, e) => total + e.voteItemCount),
            answers: poll.isActive == true && poll.answers != null
                ? poll.answers!.map((PollAnswer answer) => answer.pollItemId).toList()
                : [],
            onVotePressed:
                poll.isActive == true ? (List<int> answers) => _onVotePressed(context, postId, poll.id, answers) : null,
            onReVotePressed: poll.isActive == true ? () => _onReVotePressed(context, postId, poll.id) : null,
          ),
        ],
      ),
    );
  }
}
