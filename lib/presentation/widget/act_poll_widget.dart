import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/domain/enum/poll_view_type.dart';
import 'package:act_web/domain/model/document/poll_item.dart';
import 'package:flutter/material.dart';

class ActPollWidget extends StatefulWidget {
  final int pollId;
  final PollViewType viewType;
  final String title;
  final List<PollItem> choices;
  final List<int> answers;
  final bool isEnded;
  final int totalAnswerPersonCount;
  final int totalAnswerCount;
  final Color borderColor;
  final bool isShareholderBase;
  final bool isMultipleChoice;
  final Function(List<int>)? onVotePressed;
  final VoidCallback? onReVotePressed;

  const ActPollWidget({
    super.key,
    required this.title,
    required this.choices,
    required this.answers,
    this.viewType = PollViewType.vote,
    this.isEnded = false,
    this.borderColor = const Color(0xffEBEEF0),
    this.totalAnswerPersonCount = 0,
    this.totalAnswerCount = 0,
    this.isShareholderBase = false,
    required this.isMultipleChoice,
    this.onVotePressed,
    this.onReVotePressed,
    required this.pollId,
  });

  @override
  State<ActPollWidget> createState() => _ActPollWidgetState();
}

class _ActPollWidgetState extends State<ActPollWidget> {
  List<int> answers = [];

  @override
  void initState() {
    super.initState();
    answers = widget.answers;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.borderColor),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: widget.borderColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        widget.title,
                        style: context.textTheme.headlineSmall?.copyWith(color: Colors.grey.shade800),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (widget.viewType == PollViewType.vote && !widget.isEnded)
              ...widget.choices.map((PollItem item) => _Item(
                    title: item.text,
                    value: item.id,
                    groupValue: answers,
                    isMultipleChoice: widget.isMultipleChoice,
                    onChanged: (int id, bool isChecked) {
                      setState(() {
                        if (widget.isMultipleChoice) {
                          if (!isChecked) {
                            answers.remove(id);
                          } else {
                            answers.add(id);
                          }
                        } else {
                          answers.clear();
                          answers.add(id);
                        }
                      });
                    },
                  )),
            if (widget.viewType == PollViewType.result || widget.isEnded)
              ...widget.choices.map((PollItem item) {
                final percent = widget.isShareholderBase
                    ? item.voteItemStockSum / widget.totalAnswerCount
                    : item.voteItemCount / widget.totalAnswerPersonCount;
                return _Result(
                  title: item.text,
                  answerPersonCount: item.voteItemCount,
                  answerCount: item.voteItemStockSum,
                  percent: (percent.isNaN || percent.isInfinite) ? 0 : percent,
                  isChecked: widget.answers.contains(item.id),
                  isShareholderBase: widget.isShareholderBase,
                );
              }),
            if (widget.isEnded)
              Center(
                child: Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '종료됨',
                      style: context.textTheme.headlineMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (!widget.isEnded && widget.viewType == PollViewType.vote)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: widget.onVotePressed != null ? () => widget.onVotePressed!(answers) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.answers.isNotEmpty ? context.colorScheme.primary : Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      minimumSize: const Size(130, 40),
                    ),
                    child: const Text('투표하기'),
                  ),
                ),
              ),
            if (!widget.isEnded && widget.viewType == PollViewType.result)
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ElevatedButton(
                    onPressed: widget.onReVotePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.answers.isNotEmpty ? context.colorScheme.primary : Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text('다시 투표하기'),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.isMultipleChoice) Text('복수선택가능', style: context.textTheme.labelLarge),
                  Text(
                    widget.isShareholderBase
                        ? '${widget.totalAnswerCount.toNumberFormat}주 참여(주식수 기준)'
                        : '${widget.totalAnswerPersonCount.toNumberFormat}명 참여(인원수 기준)',
                    style: context.textTheme.labelLarge,
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String title;
  final int value;
  final List<int> groupValue;
  final Function(int, bool) onChanged;
  final double size;
  final bool isMultipleChoice;

  const _Item({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = 24.0,
    this.isMultipleChoice = true,
  });

  @override
  Widget build(BuildContext context) {
    final isChecked = groupValue.contains(value);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(value, !isChecked),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isChecked ? context.colorScheme.primary : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(size / 2),
                ),
                child: isMultipleChoice
                    ? Icon(
                        Icons.check,
                        size: 18,
                        color: isChecked ? context.colorScheme.primary : Colors.grey.shade300,
                      )
                    : Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isChecked ? context.colorScheme.primary : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(size / 2),
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Result extends StatelessWidget {
  final String title;
  final int answerPersonCount;
  final int answerCount;
  final double percent;
  final bool isChecked;
  final bool isShareholderBase;

  const _Result({
    required this.title,
    required this.answerPersonCount,
    required this.answerCount,
    required this.percent,
    required this.isChecked,
    this.isShareholderBase = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(color: isChecked ? Colors.blue : Colors.black87),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${(percent * 100).toStringAsFixed(1)}%',
                      style: context.textTheme.labelLarge?.copyWith(color: Colors.grey.shade500),
                    ),
                    Text(
                      isShareholderBase
                          ? '${answerCount.toNumberFormat}주 (${answerPersonCount.toNumberFormat}명)'
                          : '${answerPersonCount.toNumberFormat}명 (${answerCount.toNumberFormat}주)',
                      style: context.textTheme.labelLarge?.copyWith(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: TweenAnimationBuilder<double>(
              duration: AnimationDuration.medium,
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: percent),
              builder: (context, value, _) {
                return LinearProgressIndicator(
                  minHeight: 4,
                  value: value,
                  color: Colors.blue,
                  backgroundColor: Colors.grey,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
