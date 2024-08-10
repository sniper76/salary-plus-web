import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/comment.dart';
import 'package:act_cms/presentation/widget/button/act_delete_button.dart';
import 'package:act_cms/presentation/widget/button/act_elevated_button.dart';
import 'package:act_cms/presentation/widget/ripple_button.dart';
import 'package:act_cms/presentation/widget/stock_count_label.dart';
import 'package:act_cms/presentation/widget/total_asset_label.dart';
import 'package:act_cms/presentation/widget/user_profile_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class ReplyListItem extends StatelessWidget {
  final Comment comment;
  final String? stockCode;
  final EdgeInsets? margin;
  final bool enabledReply;
  final bool enableMoreButton;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onLikePressed;
  final VoidCallback? onReplyPressed;
  final VoidCallback? onCommentDeletePressed;
  final VoidCallback? onCommentActivePressed;
  final VoidCallback? onCommentEditPressed;
  final bool isReport;
  final bool isAdmin;

  const ReplyListItem({
    super.key,
    required this.comment,
    this.stockCode,
    this.margin,
    this.enabledReply = true,
    this.enableMoreButton = false,
    this.onMenuPressed,
    this.onLikePressed,
    this.onReplyPressed,
    this.onCommentDeletePressed,
    this.onCommentActivePressed,
    this.onCommentEditPressed,
    this.isReport = false,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfileImage(
                url: comment.userProfile?.profileImageUrl ?? '',
                size: 32,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 120),
                            child: Text(
                              comment.userProfile?.nickname ?? '',
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (comment.userProfile?.individualStockCountLabel?.isNotEmpty == true)
                            StockCountLabel(text: comment.userProfile?.individualStockCountLabel ?? ''),
                          if (comment.userProfile?.totalAssetLabel?.isNotEmpty == true)
                            TotalAssetLabel(text: comment.userProfile?.totalAssetLabel ?? ''),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: SelectionArea(
                          child: Linkify(
                            options: const LinkifyOptions(humanize: false),
                            onOpen: (link) {
                              context.pushRoute(WebRoute(url: link.url));
                            },
                            text: comment.content,
                            style: context.textTheme.bodyMedium
                                ?.copyWith(color: comment.isActive ? Colors.black87 : Colors.grey.shade500),
                            linkStyle: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 22,
                        children: [
                          Text(
                            comment.createdAt.toFormatString(pattern: dateTimeFormatPattern2),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Wrap(
                            spacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: comment.liked ? Colors.red.shade700 : Colors.grey.shade500,
                                size: 20,
                              ),
                              Text(
                                comment.likeCount.toNumberFormat,
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          if (enabledReply)
                            RippleButton(
                              onTap: onReplyPressed,
                              padding: EdgeInsets.zero,
                              child: Wrap(
                                spacing: 4,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                    Icons.insert_comment_outlined,
                                    color: Colors.grey.shade500,
                                    size: 20,
                                  ),
                                  Text(
                                    comment.replyCommentCount.toNumberFormat,
                                    style:
                                        context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade500, height: 1.2),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (comment.isActive && enableMoreButton)
                IconButton(
                  onPressed: onMenuPressed,
                  icon: const Icon(
                    Icons.more_vert,
                    size: 20,
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isReport)
                    const Icon(
                      Icons.info_outline,
                      color: Colors.pink,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  if (onCommentDeletePressed != null && isAdmin)
                    ActDeleteButton(
                      onPressed: comment.isActive ? onCommentDeletePressed : null,
                      isActive: comment.isActive,
                    ),
                  if (onCommentEditPressed != null && comment.isActive && isAdmin) ...[
                    const SizedBox(height: 8),
                    ActElevatedButton(titleWidget: const Text('수정'), onPressed: onCommentEditPressed),
                  ],
                  const SizedBox(height: 8),
                  if (!comment.isActive && onCommentActivePressed != null && isAdmin)
                    ElevatedButton(
                      onPressed: onCommentActivePressed,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xffFFA621)),
                        foregroundColor: MaterialStateProperty.all(const Color(0xffFFFFFF)),
                      ),
                      child: const Text("취소"),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
