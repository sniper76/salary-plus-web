import 'package:act_web/config/theme.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/user_action_on_post.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/presentation/widget/act_user_action_on_post_button.dart';
import 'package:act_web/presentation/widget/act_user_label_widget.dart';
import 'package:act_web/presentation/widget/user_profile_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ActCommentItemWidget extends StatefulWidget {
  final bool enabledReply;
  final bool enableMoreButton;
  final bool isReply;
  final bool isOwner;
  final int postId;
  final BoardGroupType boardGroupType;
  final Comment comment;
  final String? stockCode;
  final String? commentOwnerNickname;
  final EdgeInsets? margin;
  final Function(UserActionOnPost action)? onSelectUserAction;
  final VoidCallback? onLikePressed;
  final VoidCallback? onReplyPressed;

  const ActCommentItemWidget({
    super.key,
    this.enabledReply = true,
    this.enableMoreButton = true,
    required this.isReply,
    required this.isOwner,
    required this.postId,
    required this.boardGroupType,
    required this.comment,
    this.stockCode,
    this.commentOwnerNickname,
    this.margin,
    this.onSelectUserAction,
    this.onLikePressed,
    this.onReplyPressed,
  });

  @override
  State<ActCommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<ActCommentItemWidget> {
  final TextStyle? defaultTextStyle = AppTheme.defaultTextTheme.bodySmall?.copyWith(color: Colors.grey.shade500);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: widget.margin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.isReply) ...[
                const Icon(
                  Icons.subdirectory_arrow_right_rounded,
                ),
                const SizedBox(width: 12.0)
              ],
              _buildProfile(context),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildUserInfoMenu(context),
                                  _buildComment(context),
                                  const SizedBox(height: 4.0),
                                ],
                              ),
                            ),
                            ActUserActionOnPostButton(
                              actions: widget.isOwner
                                  ? [UserActionOnPost.update, UserActionOnPost.delete]
                                  : [UserActionOnPost.report, UserActionOnPost.block],
                              onSelectAction: widget.onSelectUserAction,
                            ),
                          ],
                        ),
                      ],
                    ),
                    _buildReplyInfo(),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoMenu(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (widget.comment.isActive) _buildUserInfo(context),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return widget.comment.isActive
        ? UserProfileImageWidget(url: widget.comment.userProfile?.profileImageUrl ?? '', size: 32)
        : const SizedBox(width: 30);
  }

  Widget _buildUserInfo(BuildContext context) {
    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildUserNickname(context),
        if (widget.comment.userProfile!.individualStockCountLabel?.isNotEmpty == true)
          // TODO: color 정의 필요
          ActUserLabelWidget(
            text: widget.comment.userProfile!.individualStockCountLabel ?? '',
            backgroundColor: const Color(0xffE7F5EB),
            textColor: const Color(0xff0E9F33),
          ),
        if (widget.comment.userProfile!.totalAssetLabel?.isNotEmpty == true)
          // TODO: color 정의 필요
          ActUserLabelWidget(
            text: widget.comment.userProfile!.totalAssetLabel ?? '',
            backgroundColor: const Color(0xffFFEFF9),
            textColor: const Color(0xffDD0A7F),
          ),
      ],
    );
  }

  Widget _buildUserNickname(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 120),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (widget.comment.userProfile?.isSolidarityLeader == true)
            SvgPicture.asset('assets/images/ic_crown.svg', width: 15, height: 15),
          Text(
            widget.comment.userProfile?.nickname ?? '',
            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  Widget _buildComment(BuildContext context) {
    return Row(
      children: [
        if (widget.isReply && widget.commentOwnerNickname?.isNotEmpty == true) ...[
          Text(
            widget.commentOwnerNickname ?? '',
            style: defaultTextStyle?.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.primary),
          ),
          const SizedBox(width: 8.0),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SelectionArea(
            child: Linkify(
              options: const LinkifyOptions(humanize: false),
              onOpen: (link) => launchUrl(Uri.parse(link.url)),
              text: widget.comment.content,
              style: defaultTextStyle?.copyWith(color: widget.comment.isActive ? Colors.black87 : Colors.grey.shade500),
              linkStyle: defaultTextStyle?.copyWith(color: context.colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReplyInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCreatedDate(),
        const SizedBox(width: 12.0),
        _buildLikeButton(),
        const SizedBox(width: 12.0),
        if (widget.enabledReply) _buildReplyButton(),
      ],
    );
  }

  Widget _buildCreatedDate() {
    return Text(
      widget.comment.createdAt.toFormatString(pattern: 'yyyy-MM-dd HH:mm'),
      style: defaultTextStyle,
      textScaler: TextScaler.noScaling,
    );
  }

  Widget _buildLikeButton() {
    return InkWell(
      onTap: widget.comment.isActive ? widget.onLikePressed : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite, color: widget.comment.liked ? Colors.red.shade700 : Colors.grey.shade500, size: 16),
          const SizedBox(width: 4.0),
          Text(
            widget.comment.likeCount.toNumberFormat,
            style: defaultTextStyle?.copyWith(height: 1.25),
            textAlign: TextAlign.center,
            textScaler: TextScaler.noScaling,
          ),
        ],
      ),
    );
  }

  Widget _buildReplyButton() {
    return TextButton(
      onPressed: widget.onReplyPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        '답글 쓰기',
        style: defaultTextStyle?.copyWith(height: 1.2),
        textScaler: TextScaler.noScaling,
      ),
    );
  }
}
