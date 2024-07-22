import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/document/poll_item.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ActionPostListItemWidget extends StatelessWidget {
  final String postDetailpath;
  final BoardGroupCategory? boardGroupCategory;
  final String title;
  final DateTime actionEndDate;
  final Poll? poll;
  final DigitalDocument? digitalDocument;

  const ActionPostListItemWidget({
    super.key,
    this.boardGroupCategory,
    required this.title,
    required this.actionEndDate,
    required this.postDetailpath,
    this.poll,
    this.digitalDocument,
  });

  @override
  Widget build(BuildContext context) {
    final Color? statusLabelColor = digitalDocument?.statusLabelColor ?? poll?.statusLabelColor;
    final String? statusLabel = digitalDocument?.statusLabel ?? poll?.statusLabel;
    final String statusTime = digitalDocument?.statusTime() ?? poll?.statusTime() ?? '';

    return InkWell(
      onTap: () {
        context.router.pushNamed(postDetailpath);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 235.0,
              child: Row(
                children: [
                  if (boardGroupCategory != null) ...[
                    Text(
                      '[${boardGroupCategory?.displayName}]',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.lightBlue.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              width: 120,
              alignment: Alignment.center,
              child: Container(
                width: 48.0,
                constraints: const BoxConstraints(maxWidth: 48.0),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                height: 22,
                decoration: BoxDecoration(
                  color: statusLabelColor?.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: statusLabelColor ?? Colors.blue, width: 1),
                ),
                child: Center(
                  child: Text(
                    statusLabel ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.18,
                      color: statusLabelColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            SizedBox(
              width: 130,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      statusTime,
                      style: context.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            if (poll != null)
              Expanded(
                child: Text(
                  '참여 ${poll!.pollItems.fold(0, (int previousValue, PollItem element) => previousValue + element.voteItemCount).toNumberFormat}명',
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400, height: 1.25),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            if (digitalDocument != null)
              Expanded(
                child: Text(
                  '참여 ${digitalDocument?.totalAnswerUserCount.toNumberFormat}명 (${digitalDocument?.answerShareHoldingPercent.toStringAsFixed(2)}%)',
                  style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400, height: 1.25),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}
