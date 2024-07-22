// ignore_for_file: prefer_const_constructors

part of '../screen.dart';

class _PostBodySection extends StatelessWidget {
  final Post post;

  const _PostBodySection({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        post.isActive
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 1,
                    color: context.colorScheme.outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: SelectionArea(
                      child: ActHtmlWidget(content: post.content?.replaceAll('\n', '<br/>').convertUrlLink() ?? ''),
                    ),
                  ),
                  if (post.postImages?.isNotEmpty == true)
                    ...post.postImages!.map(
                      (image) => Image.network(
                        image.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 20),
                  Text(
                    post.content ?? '',
                    style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey.shade400),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
        if (post.polls != null)
          ...post.polls!.map(
            (poll) => PostPollWidget(
              postId: post.id,
              poll: poll,
            ),
          ),
        if (post.boardGroupType == BoardGroupType.action && post.digitalDocument != null)
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text(
              '※ 액션 참여는 앱에서만 가능합니다.',
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        if (post.isActive)
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (post.stock != null && post.boardGroupType != null) {
                          context.router.pushNamed('/stock/${post.stock?.code}/${post.boardGroupType?.value}');
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.menu_outlined, size: 24),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            '목록보기',
                            style: context.textTheme.bodyMedium?.copyWith(height: 1.0),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            _onPressPostLikeButton(context, post.liked, post.id);
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 6,
                            children: [
                              Icon(
                                post.liked ? Icons.favorite_outlined : Icons.favorite_border,
                                color: Colors.red,
                                size: 20,
                              ),
                              Text(
                                post.likeCount.toNumberFormat,
                                style: context.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  height: 1,
                  color: context.colorScheme.outline,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
