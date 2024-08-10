import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/domain/model/digital_document.dart';
import 'package:act_cms/domain/model/digital_proxy.dart';
import 'package:act_cms/domain/model/poll.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/widget/counter_view.dart';
import 'package:act_cms/presentation/widget/label.dart';
import 'package:act_cms/presentation/widget/stock_count_label.dart';
import 'package:act_cms/presentation/widget/total_asset_label.dart';
import 'package:act_cms/presentation/widget/user_profile_image.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  final bool showDivider;
  final bool showUserProfile;
  final bool showExtraData;
  final EdgeInsets margin;
  final VoidCallback? onTap;

  const PostListItem({
    super.key,
    required this.post,
    this.showDivider = false,
    this.showUserProfile = false,
    this.showExtraData = true,
    this.margin = const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showUserProfile && post.isActive)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserProfileImage(url: post.userProfile?.profileImageUrl ?? '', size: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 150),
                        child: Text(
                          post.userProfile?.nickname ?? '',
                          style: context.textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (post.userProfile?.individualStockCountLabel?.isNotEmpty == true)
                          StockCountLabel(text: post.userProfile?.individualStockCountLabel ?? ''),
                        if (post.userProfile?.totalAssetLabel?.isNotEmpty == true)
                          TotalAssetLabel(text: post.userProfile?.totalAssetLabel ?? ''),
                      ],
                    )
                  ],
                ),
              ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (post.polls != null && post.isActive)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Label(
                            text: post.polls?.firstOrNull?.statusLabel ?? '',
                            color: post.polls?.firstOrNull?.statusLabelColor ?? Colors.white,
                          ),
                          if (post.polls?.firstOrNull?.isActive == true)
                            Text(
                              'D-${post.polls?.firstOrNull?.remainingDay.toNumberFormat}',
                              style: context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (post.digitalProxy != null && post.isActive)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Label(
                            text: post.digitalProxy?.statusLabel ?? '',
                            color: post.digitalProxy?.statusLabelColor ?? Colors.white,
                          ),
                          if (post.digitalProxy?.isActive == true)
                            Text(
                              'D-${post.digitalProxy?.remainingDay.toNumberFormat}',
                              style: context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (post.digitalDocument != null && post.isActive)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 6,
                        children: [
                          Label(
                            text: post.digitalDocument?.statusLabel ?? '',
                            color: post.digitalDocument?.statusLabelColor ?? Colors.white,
                          ),
                          if (post.digitalDocument?.isActive == true)
                            Text(
                              'D-${post.digitalDocument?.remainingDay.toNumberFormat}',
                              style: context.textTheme.labelLarge?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          if (post.digitalDocument?.isAnswerCompleted == true)
                            Text(
                              '제출완료',
                              style: context.textTheme.labelLarge?.copyWith(
                                color: const Color(0xff0E9F33),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        if (post.boardGroupCategory?.displayName.isNotEmpty == true)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Text(
                              '[${post.boardGroupCategory!.displayName}]',
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: post.isActive ? context.colorScheme.primary : Colors.grey.shade400,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            post.title,
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: post.isActive ? Colors.black87 : Colors.grey.shade400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showExtraData)
                    Wrap(
                      spacing: 22,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          post.createdAt.toFormatString(),
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400),
                        ),
                        CounterView(
                          icon: Icons.favorite,
                          value: post.likedCount,
                        ),
                        CounterView(
                          icon: Icons.comment,
                          value: post.commentCount,
                        ),
                        CounterView(
                          icon: Icons.remove_red_eye_outlined,
                          value: post.viewCount,
                        ),
                      ],
                    ),
                  if (!showExtraData && post.digitalDocument != null)
                    Wrap(
                      spacing: 24,
                      children: [
                        Text(
                          '종료일 ${post.digitalDocument?.targetEndDate?.toFormatString()}',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400),
                        ),
                        Text(
                          '참여 ${post.digitalDocument?.totalAnswerUserCount.toNumberFormat}명 (${post.digitalDocument?.answerShareHoldingPercent.toStringAsFixed(2)}%)',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  if (!showExtraData && post.digitalProxy != null)
                    Wrap(
                      children: [
                        Text(
                          '종료일 ${post.digitalProxy?.targetEndDate?.toFormatString()}',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  if (!showExtraData && post.polls?.firstOrNull != null)
                    Wrap(
                      children: [
                        Text(
                          '종료일 ${post.polls?.firstOrNull?.targetEndDate?.toFormatString()}',
                          style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (showDivider)
              Container(
                height: 1,
                color: Colors.grey.shade200,
                margin: const EdgeInsets.only(top: 20),
              ),
          ],
        ),
      ),
    );
  }
}
