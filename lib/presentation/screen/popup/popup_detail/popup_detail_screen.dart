import 'dart:async';
import 'dart:html' as html;
import 'dart:html';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/enum/popup/popup_display_target_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_link_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_stock_target_type.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/popup/popup_detail/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

@RoutePage()
class PopupDetailScreen extends StatefulWidget {
  final int? updatePopupId;
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  const PopupDetailScreen({super.key, @pathParam this.updatePopupId});

  @override
  State<PopupDetailScreen> createState() => _PopupDetailScreenState();
}

class _PopupDetailScreenState extends State<PopupDetailScreen> {
  static const gap = 24.0;

  StreamSubscription<PopStateEvent>? _popStateSubscription;

  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      Navigator.of(context).pop();
    });
  }

  _onDismiss() async {
    await context.showAlertDialog(title: '게시글 없음', message: '게시글을 찾을 수 없습니다.');
  }

  @override
  void initState() {
    super.initState();
    if (widget.updatePopupId == null) {
      _onDismiss();
    }
    _registerPopStateListener();
  }

  @override
  void dispose() {
    _popStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PopupDetailBloc, PopupDetailState>(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: MainAppBar(mainTitle: "팝업 상세", context: context),
      create: (context) => PopupDetailBloc()..add(PopupDetailEvent.init(widget.updatePopupId!)),
      builder: (BuildContext context, PopupDetailBloc bloc, PopupDetailState state) {
        final popup = state.updatePopup;
        if (popup == null) {
          return Container(
            height: 200,
            color: Colors.white,
          );
        } else {
          return _buildDetail(context: context, bloc: bloc, state: state);
        }
      },
    );
  }

  _buildDetail({required BuildContext context, required PopupDetailBloc bloc, required PopupDetailState state}) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 16.0),
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildBaseRow(label: "타겟", child: _buildTarget(state: state)),
              const SizedBox(height: gap),
              _buildBaseRow(label: "링크", child: _buildLink(state: state)),
              const SizedBox(height: gap),
              _buildBaseRow(label: "생성기간", child: _buildDateTime(state: state)),
              const SizedBox(height: gap),
              _buildBaseRow(
                  label: "팝업",
                  child: Flexible(
                    fit: FlexFit.tight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_buildPopupPreview(state: state)],
                    ),
                  )),
              const SizedBox(height: gap),
              ElevatedButton(
                onPressed: () {
                  context.router.push(PopupRegisterRoute(updatePopup: state.updatePopup)).then((value) {
                    if (value == true) {
                      bloc.add(PopupDetailEvent.init(widget.updatePopupId!));
                    }
                    _registerPopStateListener();
                  });
                },
                child: const Text('수정하기'),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildBaseRow({required String label, Widget? child}) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: PopupDetailScreen.titleStyle,
          ),
        ),
        if (child != null) child
      ],
    );
  }

  _buildTarget({required PopupDetailState state}) {
    return Row(
      children: [
        Text(state.updatePopup!.displayTargetType.title),
        const Text('/'),
        Text(state.updatePopup!.stockTargetType.title),
        const Text('/'),
        Text(state.updatePopup?.stockName ?? state.updatePopup?.stockGroupName ?? ''),
      ],
    );
  }

  _buildLink({required PopupDetailState state}) {
    return Row(
      children: [
        Text(state.updatePopup!.linkType.title),
      ],
    );
  }

  _buildDateTime({required PopupDetailState state}) {
    return Row(
      children: [
        Text(state.updatePopup!.targetStartDatetime.toFormatString(pattern: dateTimeFormatPattern)),
        const Text('~'),
        Text(state.updatePopup!.targetEndDatetime.toFormatString(pattern: dateTimeFormatPattern)),
      ],
    );
  }

  _buildPopupPreview({required PopupDetailState state}) {
    return Container(
      width: 400,
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 24,
          ),
          Text(
            state.updatePopup!.title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 18),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SingleChildScrollView(
                child: HtmlWidget(
                  state.updatePopup!.content,
                  textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black45),
                  customWidgetBuilder: (element) {
                    switch (element.localName) {
                      case 'img':
                        final imageUrl = element.attributes['src'];
                        if (imageUrl != null) {
                          return Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                errorWidget: (context, url, _) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                  );
                                },
                                placeholder: (context, url) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                  );
                                },
                              ),
                              onTap: () {
                                context.showFullImage(imageUrl);
                              },
                            ),
                          );
                        }
                        break;
                      default:
                        return null;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(state.updatePopup!.linkTitle == null || state.updatePopup!.linkTitle!.isEmpty
                        ? "바로가기"
                        : state.updatePopup!.linkTitle!)),
              )),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text('닫기'),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
