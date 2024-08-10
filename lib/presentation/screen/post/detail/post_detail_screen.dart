import 'dart:async';
import 'dart:html';

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/solidarity_leader_election_application.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/detail/bloc/post_detail_bloc.dart';
import 'package:act_cms/presentation/widget/act_comment_list/act_comments_list.dart';
import 'package:act_cms/presentation/widget/act_comment_list/bloc/act_comment_list_bloc.dart';
import 'package:act_cms/presentation/widget/act_detail_post.dart';
import 'package:act_cms/presentation/widget/act_round_based_widget.dart';
import 'package:act_cms/presentation/widget/act_solidarity_leader_election_detail.dart';
import 'package:act_cms/presentation/widget/button/act_delete_button.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

part 'widget/election_application_text_box.dart';

@RoutePage()
class PostDetailScreen extends StatefulWidget {
  final String stockCode;
  final String stockName;
  final String boardGroup;
  final int postId;
  final BoardGroupCategory? boardGroupCategory;

  const PostDetailScreen({
    super.key,
    @pathParam required this.stockCode,
    @pathParam required this.stockName,
    @pathParam required this.boardGroup,
    @pathParam required this.postId,
    this.boardGroupCategory,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _commentFocusNode = FocusNode();

  // ignore: unused_field
  StreamSubscription<PopStateEvent>? _popStateSubscription;

  _onDeletePostPressed({required Post post}) async {
    final bloc = _scaffoldKey.currentContext?.read<PostDetailBloc>();
    if (bloc == null) return;
    final confirm = await context.showConfirmDialog(title: '게시글 삭제', message: '게시글을 삭제하시겠습니까?');
    if (confirm) {
      bloc.add(const PostDetailEvent.delete());
    }
  }

  _openDigitalProxyUrl(String url) {
    context.pushRoute(WebRoute(url: url, title: BoardCategoryType.digitalDelegation.title));
  }

  _onDismiss() async {
    await context.showAlertDialog(
        title: '게시글 없음 {${widget.boardGroup}, ${widget.postId}}',
        message: '게시글을 찾을 수 없습니다.[${widget.stockCode}]${widget.stockName}');
  }

  _onHandleState(PostDetailState state) {
    if (state.post?.polls != null) {
      // _onPollInit(state.post!.polls!);
    }

    if (state.isNotFound) {
      _onDismiss();
    }

    if (state.digitalProxyEmbeddedUrl?.isNotEmpty == true) {
      _openDigitalProxyUrl(state.digitalProxyEmbeddedUrl!);
    }

    if (state.onPopScreen) {
      context.router.pop();
    }

    if (state.holderListReadAndCopyDownloadLink?.isNotEmpty == true) {
      AnchorElement(href: state.holderListReadAndCopyDownloadLink)
        ..setAttribute("download", state.post?.holderListReadAndCopyDigitalDocument?.fileName ?? '주주명부 열람/등사 청구.pdf')
        ..click();
      Url.revokeObjectUrl(state.holderListReadAndCopyDownloadLink!);
    }
  }

  void _onTapDownloadButton() {
    final bloc = _scaffoldKey.currentContext?.read<PostDetailBloc>();
    if (bloc == null) return;
    bloc.add(PostDetailEvent.downloadHolderListReadAndCopyDocs());
  }

  void _registerPopStateListener() {
    _popStateSubscription = window.onPopState.listen((event) {
      context.router.pop();
    });
  }

  @override
  void initState() {
    super.initState();
    _registerPopStateListener();
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BaseBlocLayout<PostDetailBloc, PostDetailState>(
          scaffoldKey: _scaffoldKey,
          backgroundColor: const Color(0xfff5f5f5),
          appBar: MainAppBar(mainTitle: "게시글보기 (${widget.boardGroupCategory?.displayName})", context: context),
          create: (context) => PostDetailBloc(
                stock: Stock(code: widget.stockCode, name: widget.stockName),
                boardGroupType: BoardGroupType.values.byName(widget.boardGroup.toLowerCase()),
                postId: widget.postId,
                boardGroupCategory: widget.boardGroupCategory,
              )..add(const PostDetailEvent.init()),
          listener: (context, state) => _onHandleState(state),
          builder: (context, bloc, state) {
            final Post? post = state.post;
            if (post == null) return Container(height: 200, color: Colors.white);
            if (post.election != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildSolidarityLeaderElectionDetail(post, bloc),
                          state.isShowingSolidarityApplication && state.electionApplication != null
                              ? ActRoundBasedWidget(
                                  child: _buildElectionApplication(context, state.electionApplication!))
                              : ActRoundBasedWidget(child: _buildComments(post)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPost(post),
                        ActRoundBasedWidget(child: _buildComments(post)),
                      ],
                    ),
                  ),
                ),
                if (state.userMe?.isAdmin == true) ...[
                  _buildButtons(state, context, post, bloc),
                  const SizedBox(height: 16)
                ],
              ],
            );
          }),
    );
  }

  Widget _buildButtons(PostDetailState state, BuildContext context, Post post, PostDetailBloc bloc) {
    return SizedBox(
      width: actRoundBaseWidgetTotalWidth * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ActDeleteButton(onPressed: () => _onDeletePostPressed(post: state.post!)),
          const SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.boardGroup == BoardGroupType.globalevent.value && widget.boardGroupCategory != null
                  ? context.router
                      .push(EventBoardRegisterRoute(
                      updatePost: post,
                      boardGroupCategory: widget.boardGroupCategory!,
                    ))
                      .then((value) {
                      bloc.add(const PostDetailEvent.init());
                      _registerPopStateListener();
                    })
                  : context.router
                      .push(PostRegisterRoute(
                      boardGroupType: BoardGroupType.values
                          .firstWhere((boardGroupType) => boardGroupType.value == widget.boardGroup),
                      updatePost: post,
                      updateStock: Stock(code: widget.stockCode, name: widget.stockName),
                    ))
                      .then((value) {
                      bloc.add(const PostDetailEvent.init());
                      _registerPopStateListener();
                    });
            },
            child: const Text("수정"),
          ),
        ],
      ),
    );
  }

  Widget _buildPost(Post post) {
    return ActDetailPost(
      post: post,
      boardGroupCategoryName: post.boardGroupCategory?.displayName ?? '',
      onTapDownloadButton: _onTapDownloadButton,
    );
  }

  Widget _buildSolidarityLeaderElectionDetail(Post post, PostDetailBloc bloc) {
    return ActDetailSolidarityLeaderElection(
      boardGroupCategoryName: post.boardGroupCategory?.displayName ?? '',
      stockName: post.stock?.name ?? widget.stockName,
      stockCode: post.stock?.code ?? widget.stockCode,
      postTitle: post.title,
      userProfile: post.displayUserProfile,
      userId: post.userId ?? 0,
      postCreatedAt: post.createdAt,
      postViewCount: post.viewCount,
      status: post.status,
      election: post.election!,
      onShowSolidarityApplication: (int solidarityApplicantId) {
        bloc.add(PostDetailEvent.showSolidarityApplication(solidarityApplicantId));
      },
    );
  }

  Widget _buildComments(Post post) {
    return Navigator(
      initialRoute: 'commentEdit',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => BlocBuilder<PostDetailBloc, PostDetailState>(builder: (context, state) {
            return BlocProvider<ActCommentListBloc>(
              create: (context) => ActCommentListBloc(
                boardGroupType: BoardGroupType.values.byName(widget.boardGroup.toLowerCase()),
                boardGroupCategory: widget.boardGroupCategory,
                post: post,
                stockCode: post.stock?.code ?? widget.stockCode,
              ),
              child: ActCommentsList(
                stockCode: widget.stockCode,
                stockName: widget.stockName,
                boardGroup: widget.boardGroup,
                userMe: state.userMe,
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildElectionApplication(BuildContext context, SolidarityLeaderElectionApplication electionApplication) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('지원동기', style: context.textTheme.displaySmall),
          const SizedBox(height: 12.0),
          _ElectionApplicationTextBox(text: electionApplication.reasonsForApply),
          const SizedBox(height: 12.0),
          Text('현기업 경영에 대한 지식', style: context.textTheme.displaySmall),
          const SizedBox(height: 12.0),
          _ElectionApplicationTextBox(text: electionApplication.knowledgeOfCompanyManagement),
          const SizedBox(height: 12.0),
          Text('주주행동 운영 목표 및 간단한 계획', style: context.textTheme.displaySmall),
          const SizedBox(height: 12.0),
          _ElectionApplicationTextBox(text: electionApplication.goals),
          const SizedBox(height: 12.0),
          Text('주주에게 하고 싶은 말', style: context.textTheme.displaySmall),
          const SizedBox(height: 12.0),
          _ElectionApplicationTextBox(text: electionApplication.commentsForStockHolder),
          const SizedBox(height: 12.0),
        ],
      ),
    );
  }
}
