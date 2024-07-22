import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/presentation/widget/counter_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PostListItemWidget extends StatelessWidget {
  final String postDetailpath;
  final BoardGroupCategory? boardGroupCategory;
  final String title;
  final bool isUploadedImageExist;
  final String nickname;
  final DateTime createdAt;
  final int likeCount;
  final int viewCount;
  final int commentCount;

  const PostListItemWidget({
    super.key,
    this.boardGroupCategory,
    required this.title,
    required this.isUploadedImageExist,
    required this.nickname,
    required this.createdAt,
    required this.likeCount,
    required this.viewCount,
    required this.commentCount,
    required this.postDetailpath,
  });

  @override
  Widget build(BuildContext context) {
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
            Expanded(
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
                  if (isUploadedImageExist) ...[
                    const SizedBox(width: 3.0),
                    Container(
                      margin: const EdgeInsets.only(top: 2.0),
                      child: const Icon(
                        Icons.photo_outlined,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                    ),
                  ],
                  const SizedBox(width: 4.0),
                  Text(
                    '[${commentCount.toNumberFormat}]',
                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.red, height: 1.3),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      nickname,
                      style: context.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      createdAt.toFormatString(pattern: 'yyyy-MM-dd'),
                      style: context.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CounterView(
                  icon: Icons.favorite,
                  value: likeCount,
                  width: 60,
                ),
                const SizedBox(width: 4),
                CounterView(
                  icon: Icons.remove_red_eye_outlined,
                  value: viewCount,
                  width: 60,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
