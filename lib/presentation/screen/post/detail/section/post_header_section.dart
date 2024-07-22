part of '../screen.dart';

class _PostHeaderSection extends StatelessWidget {
  final Post post;
  final Function(UserActionOnPost action) onSelectUserAction;

  late final UserAuthService userAuthService = GetIt.I<UserAuthService>();

  _PostHeaderSection({required this.post, required this.onSelectUserAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.boardGroupCategory != null)
            Text(
              '[${post.boardGroupCategory?.displayName}]',
              style: context.textTheme.bodyLarge?.copyWith(
                color: post.isActive ? context.colorScheme.primary : Colors.grey.shade400,
                fontSize: 20.0,
              ),
            ),
          if (post.isActive)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                post.title,
                style: context.textTheme.displayMedium?.copyWith(
                  color: post.isActive ? null : Colors.grey.shade400,
                  fontSize: 28.0,
                ),
              ),
            ),
          if (post.isActive && post.userProfile != null)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserProfileImageWidget(url: post.userProfile?.profileImageUrl ?? '', size: 32),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 12,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                constraints: const BoxConstraints(maxWidth: 120),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    if (post.userProfile?.isSolidarityLeader == true)
                                      SvgPicture.asset('assets/images/ic_crown.svg', width: 15, height: 15),
                                    Text(
                                      post.userProfile!.nickname,
                                      style: context.textTheme.headlineSmall,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                              if (post.userProfile!.individualStockCountLabel?.isNotEmpty == true)
                                // TODO: color 정의 필요
                                ActUserLabelWidget(
                                  text: post.userProfile!.individualStockCountLabel ?? '',
                                  backgroundColor: const Color(0xffE7F5EB),
                                  textColor: const Color(0xff0E9F33),
                                ),
                              if (post.userProfile!.totalAssetLabel?.isNotEmpty == true)
                                // TODO: color 정의 필요
                                ActUserLabelWidget(
                                  text: post.userProfile!.totalAssetLabel ?? '',
                                  backgroundColor: const Color(0xffFFEFF9),
                                  textColor: const Color(0xffDD0A7F),
                                ),
                            ],
                          ),
                          Wrap(
                            spacing: 24,
                            children: [
                              Text(
                                post.createdAt.toFormatString(pattern: 'yyyy-MM-dd HH:mm:ss'),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Text(
                                '조회 ${post.viewCount.toNumberFormat}',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: html.window.location.href)).then((_) {
                            // 클립보드에 복사된 후 사용자에게 알림을 표시합니다.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('URL이 클립보드에 복사되었습니다!')),
                            );
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.link,
                              size: 28,
                            ),
                            const SizedBox(
                              width: 2.0,
                            ),
                            Text(
                              '링크 복사',
                              style: context.textTheme.bodyMedium?.copyWith(height: 1.0),
                            )
                          ],
                        ),
                      ),
                      if (!post.isHolderListReadAndCopyPost) ...[
                        const SizedBox(
                          width: 12.0,
                        ),
                        ListenableBuilder(
                          listenable: userAuthService,
                          builder: (context, child) => ActUserActionOnPostButton(
                            actions: userAuthService.userMe?.id == post.userId
                                ? [UserActionOnPost.update, UserActionOnPost.delete]
                                : [UserActionOnPost.report, UserActionOnPost.block],
                            onSelectAction: onSelectUserAction,
                          ),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
