import 'dart:async';
import 'dart:html' as html;

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/report/report_post_detail/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/post_detail_view.dart';
import 'package:act_cms/presentation/widget/post_profile.dart';
import 'package:act_cms/presentation/widget/reply_list_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ReportPostDetailScreen extends StatefulWidget {
  final String reportType; // POST or COMMENT
  final int reportId;

  const ReportPostDetailScreen({super.key, required this.reportType, required this.reportId});

  @override
  State<ReportPostDetailScreen> createState() => _PostState();
}

class _PostState extends State<ReportPostDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerReason = TextEditingController();
  final _scrollController = ScrollController();
  StreamSubscription<html.PopStateEvent>? _popStateSubscription;

  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      Navigator.of(context).pop(); // 여기에 원하는 데이터를 넣어 반환합니다.
    });
  }

  @override
  void initState() {
    super.initState();
    _registerPopStateListener();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _popStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostBloc, PostState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PostBloc(widget.reportType, widget.reportId)
        ..add(
          const PostEvent.init(),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildMainScreen(context, bloc, state);
      },
    );
  }

  String formatPhoneNumber(String rawNumber) {
    // 숫자만 포함된 문자열을 기대합니다.
    if (rawNumber.length == 11) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 7)}-${rawNumber.substring(7, 11)}';
    } else if (rawNumber.length == 10) {
      // 일부 번호는 10자리일 수 있습니다.
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 6)}-${rawNumber.substring(6, 10)}';
    }
    return rawNumber; // 다른 길이의 번호는 수정하지 않고 반환합니다.
  }

  String formatAssetAmount(int? amount) {
    if (amount == null) {
      return "-";
    }
    final numberFormat = NumberFormat('#,###', 'ko_KR');
    return numberFormat.format(amount);
  }

  Widget _buildMainScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(
          context: context,
          mainTitle: "신고 (${widget.reportType == 'POST' ? '게시글' : '댓글/답글'})",
        ),
        body: SizedBox(
          width: 1200,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  widget.reportType == 'POST'
                      ? _buildPostScreen(context, bloc, state)
                      : _buildCommentScreen(context, bloc, state),
                  const SizedBox(width: 16),
                  _buildSubmitScreen(context, bloc, state),
                  // 빈 컨테이너 박스
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostScreen(BuildContext context, PostBloc bloc, PostState state) {
    return (BlocListener<PostBloc, PostState>(
        listener: (context, state) {},
        child: state.reportDetail == null
            ? Container(
                width: 500,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                      spreadRadius: 0, // 그림자의 범위를 설정합니다.
                      blurRadius: 11, // 흐림 정도를 설정합니다.
                      offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView(children: const [Text("...")]),
              )
            : Container(
                width: 500,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                      spreadRadius: 0, // 그림자의 범위를 설정합니다.
                      blurRadius: 11, // 흐림 정도를 설정합니다.
                      offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 8,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '[${state.reportDetail?.post?.boardGroupCategory?.displayName}]',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.primary,
                            ),
                          ),
                          Text(
                            state.reportDetail?.post?.stock?.name ?? "",
                            style: context.textTheme.headlineSmall,
                          ),
                          Text(
                            state.reportDetail?.post?.stock?.code ?? "",
                            style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade300),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                      child: Text(
                        state.reportDetail?.post?.title ?? "",
                        style: context.textTheme.displaySmall,
                      ),
                    ),
                    PostProfile(
                      userProfile: state.reportDetail!.post!.displayUserProfile,
                      stockCode: state.reportDetail?.post?.stock?.code ?? '',
                      userId: state.reportDetail?.post?.userId ?? 0,
                      dateTime: state.reportDetail?.post?.createdAt,
                      viewCount: state.reportDetail?.post?.viewCount ?? 0,
                      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      // onMenuPressed: () => _onMenuPressed(
                      //   post: post,
                      //   isOwner: state.isOwner,
                      // ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: PostDetailView(content: state.reportDetail!.post!.content ?? ''),
                    ),
                  ],
                ))));
  }

  Widget _buildCommentScreen(BuildContext context, PostBloc bloc, PostState state) {
    return (BlocListener<PostBloc, PostState>(
        listener: (context, state) {},
        child: state.reportDetail == null
            ? Container(
                width: 500,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                      spreadRadius: 0, // 그림자의 범위를 설정합니다.
                      blurRadius: 11, // 흐림 정도를 설정합니다.
                      offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView(children: const [Text("...")]),
              )
            : Container(
                width: 500,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                    spreadRadius: 0, // 그림자의 범위를 설정합니다.
                    blurRadius: 11, // 흐림 정도를 설정합니다.
                    offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  children: [
                    if (state.reportDetail?.comment != null)
                      ReplyListItem(
                        comment: state.reportDetail!.comment!,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        enabledReply: false,
                        enableMoreButton: false,
                        onCommentDeletePressed: null,
                        onCommentActivePressed: null,
                        isReport: state.reportDetail!.report!.contentId == state.reportDetail!.comment!.id,
                      ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      color: context.colorScheme.outline,
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(top: 12, bottom: 20, left: 46, right: 20),
                        itemCount: state.reportDetail?.reply?.length ?? 0,
                        itemBuilder: (context, index) {
                          final reply = state.reportDetail!.reply![index];
                          return ReplyListItem(
                              comment: reply,
                              enabledReply: false,
                              onCommentDeletePressed: null,
                              onCommentActivePressed: null,
                              isReport: state.reportDetail!.report!.contentId == reply.id);
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: 1,
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            color: context.colorScheme.outline,
                          );
                        },
                      ),
                    ),
                  ],
                ))));
  }

  Widget _buildSubmitScreen(BuildContext context, PostBloc bloc, PostState state) {
    const spaceHeight = 24.0;
    const titleFontSize = 16.0;
    const contentFontSize = 12.0;
    return (BlocListener<PostBloc, PostState>(
        listener: (context, state) {},
        child: Container(
            width: 500,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                spreadRadius: 0, // 그림자의 범위를 설정합니다.
                blurRadius: 11, // 흐림 정도를 설정합니다.
                offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: ListView(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        "신고자",
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "${state.reportDetail?.report?.nickname}",
                      style: const TextStyle(fontSize: contentFontSize, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: spaceHeight),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        "신고일시",
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      state.reportDetail?.report?.createdAt != null
                          ? state.reportDetail!.report!.createdAt!.toFormatString(pattern: dateTimeFormatPattern)
                          : "",
                      style: const TextStyle(fontSize: contentFontSize, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: spaceHeight),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        "신고사유",
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "${state.reportDetail?.report?.reason}",
                      style: const TextStyle(fontSize: contentFontSize, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: spaceHeight),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text(
                        "판단이유",
                        style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controllerReason,
                        minLines: 5,
                        maxLines: null, // 멀티라인 입력 활성화
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            // borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Color(0xffD9D9D9)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: spaceHeight),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStateUpdateButton(context, bloc, state, "COMPLETE", "승인", Colors.red),
                        const SizedBox(width: 16),
                        _buildStateUpdateButton(context, bloc, state, "REJECT", "반려", const Color(0xffFFA621)),
                        const SizedBox(width: 16),
                        _buildStateUpdateButton(context, bloc, state, "READY", "준비", const Color(0xffFFA621)),
                      ],
                    ))
                  ],
                )
              ],
            ))));
  }

  Widget _buildStateUpdateButton(
      BuildContext context, PostBloc bloc, PostState state, String reportStatus, String label, Color bgcolor) {
    return SizedBox(
      width: 120, // 버튼의 너비를 120으로 설정
      child: ElevatedButton(
        onPressed: (state.reportDetail?.report?.reportStatus ?? "") == reportStatus
            ? null
            : () {
                bloc.add(PostEvent.fetchUpdateState(
                  type: state.reportDetail!.report!.contentType!,
                  reportId: state.reportDetail!.report!.reportId!,
                  result: _controllerReason.text,
                  currentReportStatus: state.reportDetail!.report!.reportStatus!,
                  changeReportStatus: reportStatus,
                ));
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor, // 버튼의 배경색을 빨간색으로 설정
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white), // 글씨색을 흰색으로 설정
          ),
        ),
      ),
    );
  }
}
