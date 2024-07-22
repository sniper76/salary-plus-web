// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:math';

import 'package:act_web/config/constants.dart';
import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/core/extension/number_extension.dart';
import 'package:act_web/core/extension/string_extension.dart';
import 'package:act_web/core/route/app_router.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/board_sort_type.dart';
import 'package:act_web/domain/enum/poll_selection_type.dart';
import 'package:act_web/domain/enum/poll_vote_type.dart';
import 'package:act_web/domain/enum/user_action_on_post.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/document/poll_answer.dart';
import 'package:act_web/domain/model/post/comment.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/presentation/base/base_bloc_layout.dart';
import 'package:act_web/presentation/screen/post/detail/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_comment_item_widget.dart';
import 'package:act_web/presentation/widget/act_comment_text_field.dart';
import 'package:act_web/presentation/widget/act_filter_checked_button.dart';
import 'package:act_web/presentation/widget/act_html_widget.dart';
import 'package:act_web/presentation/widget/act_login_dialog/widget.dart';
import 'package:act_web/presentation/widget/act_logo_widget.dart';
import 'package:act_web/presentation/widget/act_poll_widget.dart';
import 'package:act_web/presentation/widget/act_ranking_widget/widget.dart';
import 'package:act_web/presentation/widget/act_reply_list_widget/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_reply_list_widget/widget.dart';
import 'package:act_web/presentation/widget/act_report_reason_dialog.dart';
import 'package:act_web/presentation/widget/act_text_form_field.dart';
import 'package:act_web/presentation/widget/act_user_action_on_post_button.dart';
import 'package:act_web/presentation/widget/act_user_label_widget.dart';
import 'package:act_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:act_web/presentation/widget/user_profile_image_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'dart:html' as html;

part 'section/post_detail_title_section.dart';
part 'section/post_header_section.dart';
part 'section/post_body_section.dart';
part 'section/post_comments_section.dart';

part 'widget/post_poll_widget.dart';

part 'handler.dart';

@RoutePage()
class PostDetailScreen extends StatefulWidget {
  final String stockCode;
  final String boardGroupName;
  final int postId;

  const PostDetailScreen({
    super.key,
    @pathParam required this.stockCode,
    @pathParam required this.boardGroupName,
    @pathParam required this.postId,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> with SingleTickerProviderStateMixin {
  final UserAuthService userAuthService = GetIt.I<UserAuthService>();

  @override
  void initState() {
    super.initState();
    if (GetIt.I.isRegistered<PostDetailBloc>(instanceName: 'post_${widget.postId}') == false) {
      GetIt.I.registerSingleton(
          PostDetailBloc(
            stockCode: widget.stockCode,
            boardGroupName: widget.boardGroupName,
            postId: widget.postId,
          ),
          instanceName: 'post_${widget.postId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostDetailBloc, PostDetailState>(
      appBarbuilder: (context, bloc, state) {
        return DefaultActWebAppBar();
      },
      backgroundColor: Colors.white,
      create: (_) => GetIt.I<PostDetailBloc>(instanceName: 'post_${widget.postId}')..add(const PostDetailEvent.init()),
      listener: (context, state) {
        if (state.onPopScreen == true) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, bloc, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 100.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppConfig.leftSectionWidth,
                child: Column(
                  children: [
                    if (state.post != null) ...[
                      if (state.post!.stock?.code != AppConfig.globalBoardCode)
                        _PostDetailTitleSection(
                          stockCode: state.post!.stock?.code,
                          stockName: state.post!.stock?.name,
                        ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      _PostHeaderSection(
                        post: state.post!,
                        onSelectUserAction: _onSelectUserAction,
                      ),
                      _PostBodySection(post: state.post!),
                      const SizedBox(height: 24.0),
                      _PostCommentsSection(
                        post: state.post!,
                        sortType: state.sortType,
                        totalCommentCount: state.commentPaging.total,
                        comments: state.comments,
                        stockCode: state.post?.stock?.code ?? '',
                        boardGroupType: state.post!.boardGroupType ?? BoardGroupType.unknown,
                        postId: state.post!.id,
                        onReplyPressed: _onPressReplyButton,
                        onCommentBlock: _onBlockComment,
                        onCommentUpdate: _onUpdateComment,
                        onToggleCommentLike: _onToggleCommentLike,
                        onCommentReport: _onReportComment,
                        onDeleteComment: _onDeleteComment,
                        onChangeSortType: _onChageCommentSortType,
                      ),
                    ],
                  ],
                ),
              ),
              const Column(
                children: [
                  SizedBox(
                    width: AppConfig.rankingWidgetWidth,
                    child: ActRankingWidget(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<PostDetailBloc>(instanceName: 'post_${widget.postId}');
    super.dispose();
  }
}
