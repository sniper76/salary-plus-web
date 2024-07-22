part of '../screen.dart';

class _PostListPreviewWidget extends StatelessWidget {
  final String stockCode;
  final BoardGroupType boardGroupType;
  final List<Post> postListPreviews;

  const _PostListPreviewWidget({
    required this.stockCode,
    required this.boardGroupType,
    required this.postListPreviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActListTitleWidget(
          titleSvgAssetPath: boardGroupType.iconPath,
          titleText: boardGroupType.title,
          trailingWidget: InkWell(
            onTap: () {
              context.router.pushNamed('/stock/$stockCode/${boardGroupType.value}');
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
        ...List.generate(
          postListPreviews.length,
          (int index) {
            final Post post = postListPreviews[index];

            return Column(
              children: [
                boardGroupType == BoardGroupType.action
                    ? ActionPostListItemWidget(
                        title: post.title,
                        actionEndDate: post.digitalDocument?.targetEndDate ?? DateTime.now(),
                        postDetailpath: post.getDetailRoutePath(
                          stockCode: stockCode,
                          boardGroupType: boardGroupType,
                        ),
                        boardGroupCategory: post.boardGroupCategory,
                        digitalDocument: post.digitalDocument,
                        poll: post.polls?.isNotEmpty == true ? post.polls?.first : null,
                      )
                    : PostListItemWidget(
                        title: post.title,
                        isUploadedImageExist: post.thumbnailImageUrl?.isNotEmpty == true,
                        nickname: post.userProfile?.nickname ?? '',
                        createdAt: post.createdAt,
                        likeCount: post.likeCount,
                        viewCount: post.viewCount,
                        commentCount: post.commentCount,
                        boardGroupCategory: post.boardGroupCategory,
                        postDetailpath: post.getDetailRoutePath(
                          stockCode: stockCode,
                          boardGroupType: boardGroupType,
                        ),
                      ),
                if (index != postListPreviews.length - 1) Container(height: 1, color: Colors.grey.shade300),
              ],
            );
          },
        ),
      ],
    );
  }
}
