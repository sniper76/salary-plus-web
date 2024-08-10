import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/domain/model/user_profile.dart';
import 'package:act_cms/presentation/widget/stock_count_label.dart';
import 'package:act_cms/presentation/widget/total_asset_label.dart';
import 'package:act_cms/presentation/widget/user_profile_image.dart';
import 'package:flutter/material.dart';

class PostProfile extends StatelessWidget {
  final UserProfile userProfile;
  final String stockCode;
  final int userId;

  final int viewCount;
  final DateTime? dateTime;
  final EdgeInsets? margin;
  final VoidCallback? onMenuPressed;

  const PostProfile({
    super.key,
    required this.userProfile,
    required this.stockCode,
    this.userId = 0,
    this.viewCount = 0,
    this.dateTime,
    this.margin,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: !userProfile.isAnonymous && userId > 0 ? () => null : null,
            child: UserProfileImage(url: userProfile.profileImageUrl ?? '', size: 32),
          ),
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
                        child: Text(
                          userProfile.nickname,
                          style: context.textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (userProfile.individualStockCountLabel?.isNotEmpty == true)
                        StockCountLabel(text: userProfile.individualStockCountLabel ?? ''),
                      if (userProfile.totalAssetLabel?.isNotEmpty == true)
                        TotalAssetLabel(text: userProfile.totalAssetLabel ?? ''),
                    ],
                  ),
                  Wrap(
                    spacing: 24,
                    children: [
                      if (dateTime != null)
                        Text(
                          dateTime?.toFormatString(pattern: 'yyyy-MM-dd HH:mm:ss') ?? '',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      Text(
                        '조회 ${viewCount.toNumberFormat}',
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
          if (onMenuPressed != null)
            IconButton(
              onPressed: onMenuPressed,
              alignment: Alignment.centerRight,
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
    );
  }
}
