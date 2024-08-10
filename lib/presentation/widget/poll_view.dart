import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:flutter/material.dart';

class PollItem {
  final String text;
  final int value;
  final int answerCount;
  final int answerStock;

  const PollItem({
    required this.text,
    required this.value,
    this.answerCount = 0,
    this.answerStock = 0,
  });
}

enum PollViewType { vote, result }

class PollView extends StatelessWidget {
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

  const PollView({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: borderColor,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        title,
                        style: context.textTheme.headlineSmall?.copyWith(color: Colors.grey.shade800),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ...choices.map((e) {
              final percent =
                  isShareholderBase ? e.answerStock / totalAnswerCount : e.answerCount / totalAnswerPersonCount;
              return _Result(
                title: e.text,
                answerPersonCount: e.answerCount,
                answerCount: e.answerStock,
                percent: (percent.isNaN || percent.isInfinite) ? 0 : percent,
                isChecked: answers.contains(e.value),
                isShareholderBase: isShareholderBase,
              );
            }).toList(),
            Center(
              child: Container(
                width: 130,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isEnded ? Colors.grey.shade400 : AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    isEnded ? '종료됨' : "진행중",
                    style: context.textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isMultipleChoice ? '복수선택가능' : '',
                    style: context.textTheme.labelLarge,
                  ),
                  Text(
                    isShareholderBase
                        ? '${totalAnswerCount.toNumberFormat}주 참여\n(주식수 기준)'
                        : '${totalAnswerPersonCount.toNumberFormat}명 참여(인원수 기준)',
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

class _Result extends StatelessWidget {
  final String title;
  final int answerPersonCount;
  final int answerCount;
  final double percent;
  final bool isChecked;
  final bool isShareholderBase;

  const _Result({
    Key? key,
    required this.title,
    required this.answerPersonCount,
    required this.answerCount,
    required this.percent,
    required this.isChecked,
    this.isShareholderBase = false,
  }) : super(key: key);

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
