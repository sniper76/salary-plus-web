import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/presentation/widget/act_list_title_widget.dart';
import 'package:act_web/presentation/widget/simple_post_list_item_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SimplePostListWidget extends StatelessWidget {
  final String titleSvgAssetPath;
  final List<Post> posts;
  final BoardGroupType boardGroupType;

  const SimplePostListWidget({
    super.key,
    required this.posts,
    required this.titleSvgAssetPath,
    required this.boardGroupType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConfig.leftSectionWidth,
      child: Column(
        children: [
          ActListTitleWidget(
            titleSvgAssetPath: titleSvgAssetPath,
            titleText: AppConfig.globalBoardTitle,
            trailingWidget: InkWell(
              onTap: () {
                context.router.pushNamed('/stock/${AppConfig.globalBoardCode}/${boardGroupType.value}');
              },
              child: Row(
                children: [
                  Text(
                    '더보기',
                    style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 15.0,
                  ),
                ],
              ),
            ),
          ),
          Container(height: 1, color: Colors.grey.shade300),
          ...List.generate(posts.length, (int index) {
            final Post post = posts[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    context.router.pushNamed(
                      post.getDetailRoutePath(
                        stockCode: AppConfig.globalBoardCode,
                        boardGroupType: boardGroupType,
                      ),
                    );
                  },
                  child: SimplePostListItemWidget(post: posts[index]),
                ),
                if (index != 4) Container(height: 1, color: Colors.grey.shade300),
              ],
            );
          }),
        ],
      ),
    );
  }
}
