import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:flutter/material.dart';

class SimplePostListItemWidget extends StatelessWidget {
  final Post post;

  const SimplePostListItemWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                if (post.boardGroupCategory != null) ...[
                  Text(
                    '[${post.boardGroupCategory?.displayName}]',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.lightBlue.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Flexible(
                  child: Text(
                    post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 3.0),
                if (post.thumbnailImageUrl != null)
                  Container(
                    margin: const EdgeInsets.only(top: 2.0),
                    child: const Icon(
                      Icons.photo_outlined,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                  ),
                const SizedBox(width: 4.0),
                Text(
                  '[${post.commentCount.toNumberFormat}]',
                  style: context.textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          SizedBox(
            width: 120,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15.0,
                  backgroundImage: NetworkImage('${post.userProfile?.profileImageUrl}'),
                ),
                const SizedBox(width: 8.0),
                Flexible(
                  child: Text(
                    post.userProfile?.nickname ?? '',
                    style: context.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
