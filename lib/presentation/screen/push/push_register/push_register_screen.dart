import 'dart:async';
import 'dart:html' as html;

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/enum/push/push_link_type.dart';
import 'package:act_cms/domain/model/enum/push/push_send_type.dart';
import 'package:act_cms/domain/model/enum/push/push_target_type.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/screen/push/push_register/bloc/bloc.dart';
import 'package:act_cms/presentation/util/date_ui_helper.dart';
import 'package:act_cms/presentation/widget/based_label.dart';
import 'package:act_cms/presentation/widget/custom_dropdown.dart';
import 'package:act_cms/presentation/widget/custom_text_field.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/push_preview.dart';
import 'package:act_cms/presentation/widget/push_send_type_buttons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

@RoutePage()
class PushRegisterScreen extends StatefulWidget {
  const PushRegisterScreen({super.key});

  @override
  State<PushRegisterScreen> createState() => _PushState();
}

class _PushState extends State<PushRegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final linkPushIdFieldTargetKey = GlobalKey();
  final linkTitleFieldTargetKey = GlobalKey();

  final TextEditingController _controllerTarget = TextEditingController();
  final TextEditingController _controllerContent = TextEditingController();

  OverlayEntry? overlayEntry;
  final textFieldTargetKey = GlobalKey();
  List<FocusNode>? listItemFocusNodes;

  static const gap = 32.0;
  StreamSubscription<html.PopStateEvent>? _popStateSubscription;

  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      Navigator.of(context).pop();
    });
  }

  _onSetPushData({
    String? targetLinkPostId,
    PushLinkType? targetLinkType,
    PushSendType? sendType,
    DateTime? dateTime,
    String? title,
    String? content,
    SimpleStockGroup? stockGroup,
    SimpleStock? stock,
  }) {
    final bloc = _scaffoldKey.currentContext?.read<PushBloc>();
    if (bloc == null) {
      return;
    }
    bloc.add(PushEvent.setPushData(
      targetLinkPostId: targetLinkPostId,
      targetLinkType: targetLinkType,
      sendType: sendType,
      dateTime: dateTime,
      title: title,
      content: content,
      stockGroup: stockGroup,
      stock: stock,
    ));
  }

  @override
  void initState() {
    super.initState();
    _registerPopStateListener();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    removeOverlay();
    _popStateSubscription?.cancel();
    super.dispose();
  }

  onComplete() {
    context.showAlertDialog(title: "푸시 발송", message: "푸시메시지가 발송(예약) 되었습니다.").then((value) {
      context.router.pop();
    });
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Future<void> selectDateTime(BuildContext context, PushBloc bloc) async {
    DateTime? finalDateTime = await DateUiHelper.selectDateTime(context, bloc.state.targetDatetime);
    if (finalDateTime == null) {
      return;
    }
    _onSetPushData(dateTime: finalDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PushBloc, PushState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PushBloc(),
      listener: (context, state) {
        if (state.isComplete) onComplete();
      },
      backgroundColor: const Color(0xfff5f5f5),
      appBar: MainAppBar(
        mainTitle: "푸시 발송",
        context: context,
      ),
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildMainScreen(context, bloc, state);
      },
    );
  }

  Widget _buildMainScreen(BuildContext context, PushBloc bloc, PushState state) {
    return Container(
      margin: const EdgeInsets.all(32.0),
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSelectTarget(context, bloc, state),
            const SizedBox(height: gap),
            _buildSendType(context, bloc, state),
            const SizedBox(height: gap),
            _buildTitle(context, bloc, state),
            const SizedBox(height: gap),
            _buildContent(context, bloc, state),
            const SizedBox(height: gap),
            _buildPreview(context, bloc, state),
            const SizedBox(height: gap),
            _buildLink(context, bloc, state),
            const SizedBox(height: gap),
            ElevatedButton(
              onPressed: state.isReadyToSend
                  ? () async {
                      final ret = await context.showConfirmDialog(title: "푸시 발송", message: "푸시를 발송하시겠습니까?");
                      if (ret) {
                        bloc.add(const PushEvent.push());
                      }
                    }
                  : null,
              child: Container(
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('발송'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectTarget(BuildContext context, PushBloc bloc, PushState state) {
    return BasedLabel(
      label: '타겟',
      children: [
        BlocListener<PushBloc, PushState>(
            listenWhen: (previousState, currentState) =>
                previousState.targetCandidateStockList != currentState.targetCandidateStockList,
            listener: (context, state) {
              overlayEntry = createSimpleStockOverlay(
                context: context,
                textFieldKey: textFieldTargetKey,
                simpleStockList: state.targetCandidateStockList,
                onListTap: (int i) {
                  _controllerTarget.text = state.targetCandidateStockList[i].name;
                  _onSetPushData(stock: state.targetCandidateStockList[i]);
                  removeOverlay();
                },
                oldOverlayEntry: overlayEntry,
                removeOverlay: removeOverlay,
                sidebarSize: 300,
              );
            },
            child: const SizedBox(width: 32)),
        CustomDropdown<PushTargetType>(
            value: state.targetSearchType,
            items: PushTargetType.values.where((element) => element != PushTargetType.unknown).toList(),
            getText: (PushTargetType value) => value.title,
            onChanged: (PushTargetType? newValue) {
              if (state.targetSearchType != newValue) {
                bloc.add(PushEvent.setSearchType(newValue!));
                _controllerTarget.text = "";
              }
            }),
        BlocListener<PushBloc, PushState>(
            listenWhen: (previousState, currentState) =>
                previousState.targetCandidateStockGroupList != currentState.targetCandidateStockGroupList,
            listener: (context, state) {
              overlayEntry = createStockGroupOverlay(
                context: context,
                textFieldKey: textFieldTargetKey,
                stockGroupList: state.targetCandidateStockGroupList,
                onListTap: (int i) {
                  _controllerTarget.text = state.targetCandidateStockGroupList[i].name;
                  _onSetPushData(stockGroup: state.targetCandidateStockGroupList[i]);
                  removeOverlay();
                },
                oldOverlayEntry: overlayEntry,
                removeOverlay: removeOverlay,
                sidebarSize: 300,
              );
            },
            child: const SizedBox(width: 32)),
        CustomTextField(
          enabled: state.targetSearchType == PushTargetType.all ? false : true,
          key: textFieldTargetKey,
          controller: _controllerTarget,
          onChanged: (value) {
            bloc.add(PushEvent.searchKeyword(value));
          },
        )
      ],
    );
  }

  Widget _buildSendType(BuildContext context, PushBloc bloc, PushState state) {
    return BasedLabel(
      label: '발송일시',
      children: [
        const SizedBox(width: 32),
        PushSendTypeButtons(
          sendType: state.sendType,
          targetDatetime: state.targetDatetime,
          onPressed: (bool isSchedule) =>
              _onSetPushData(sendType: isSchedule ? PushSendType.schedule : PushSendType.immediately),
          selectDateTime: () {
            selectDateTime(context, bloc);
          },
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, PushBloc bloc, PushState state) {
    return BasedLabel(
      label: '제목',
      children: [
        const SizedBox(width: 32),
        CustomTextField(
          onChanged: (value) {
            _onSetPushData(title: value);
          },
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, PushBloc bloc, PushState state) {
    return BasedLabel(
      label: '내용입력',
      children: [
        const SizedBox(width: 32),
        CustomTextField(
          controller: _controllerContent,
          onChanged: (value) {
            _onSetPushData(content: value);
          },
        ),
      ],
    );
  }

  Widget _buildPreview(BuildContext context, PushBloc bloc, PushState state) {
    return BasedLabel(
      label: '미리보기',
      children: [
        const SizedBox(width: 32),
        PushPreview(
          title: state.title,
          targetDatetime: state.targetDatetime,
          targetSearchType: state.targetSearchType,
          content: state.content,
          selectedSimpleStock: state.selectedSimpleStock,
        ),
      ],
    );
  }

  Widget _buildLink(BuildContext context, PushBloc bloc, PushState state) {
    return BasedLabel(
      label: '링크',
      children: [
        const SizedBox(width: 32),
        CustomDropdown<PushLinkType>(
          value: state.targetLinkType,
          items: PushLinkType.values,
          getText: (value) => value.title,
          onChanged: (newValue) {
            if (newValue != null) {
              _onSetPushData(targetLinkType: newValue);
            }
          },
        ),
        const SizedBox(width: 32),
        if (state.targetLinkType == PushLinkType.link)
          CustomTextField(
            onChanged: (value) {
              _onSetPushData(targetLinkPostId: value);
            },
            labelText: '게시글 ID',
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
          ),
      ],
    );
  }
}
