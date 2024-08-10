import 'dart:async';
import 'dart:html' as html;
import 'dart:math';

import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/enum/action_document_type.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/action/pdf_screen/sfpdf_screen.dart';
import 'package:act_cms/presentation/screen/action/register/allsign/allsign_screen.dart';
import 'package:act_cms/presentation/screen/action/register/digitaldocument/digital_document_screen.dart';
import 'package:act_cms/presentation/screen/action/register/survey/survey_screen.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/widget/act_campaign_title_input.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import './bloc/bloc.dart';

class PollInputItem {
  final String value;
  late final TextEditingController textController;

  PollInputItem({this.value = ''}) {
    textController = TextEditingController();
    textController.text = value;
  }

  addTextControllerListener(VoidCallback listener) {
    textController.addListener(listener);
  }
}

@RoutePage()
class ActionPostRegisterScreen extends StatefulWidget {
  final ActionPostType postType;

  const ActionPostRegisterScreen({super.key, this.postType = ActionPostType.action});

  @override
  State<ActionPostRegisterScreen> createState() => _PostState();
}

class _PostState extends State<ActionPostRegisterScreen> {
  final textFieldTargetKey = GlobalKey();
  OverlayEntry? overlayEntry;
  OverlayEntry? overlayPDF;

  final TextEditingController _controllerTarget = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerCampaignTitle = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  StreamSubscription<html.PopStateEvent>? _popStateSubscription;

  PostBloc _getBloc() {
    final currentContext = _scaffoldKey.currentContext;
    final bloc = BlocProvider.of<PostBloc>(currentContext!);
    return bloc;
  }

  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      Navigator.of(context).pop(); // 여기에 원하는 데이터를 넣어 반환합니다.
    });
  }

  void _createPDFOverlay({double? newX, double? newY}) {
    double left = newX ?? MediaQuery.of(context).size.width - 850;
    double top = newY ?? 0;
    if (overlayPDF != null) {
      overlayPDF!.remove();
    }
    overlayPDF = OverlayEntry(
      builder: (context) => _buildDraggablePDFViewer(top: top, left: left),
    );
    Overlay.of(context).insert(overlayPDF!);
  }

  void _closePDFPreviewer() {
    final bloc = _getBloc();

    bloc.add(const PostEvent.setActionPreview(isPreviewOn: false));
  }

  Widget _buildDraggablePDFViewer({double? top = 0, double left = 0}) {
    final bloc = _getBloc();
    final state = bloc.state;

    return Positioned(
      top: top,
      left: left,
      child: Draggable(
        feedback: Material(
          elevation: 4.0,
          child: PointerInterceptor(child: _buildPDFViewer(state, true)),
        ),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          double newX = max(0, details.offset.dx - 300);
          double newY = details.offset.dy;
          _createPDFOverlay(newX: newX, newY: newY);
        },
        child: PointerInterceptor(child: _buildPDFViewer(state, false)),
      ),
    );
  }

  Widget _buildPDFViewer(PostState state, bool isOnDragging) {
    return Container(
      width: 500,
      height: 700,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade300)),
      child: SfPDFScreen(
        url: state.pdf!,
        dragging: isOnDragging,
        draggable: true,
        onClose: _closePDFPreviewer,
      ),
    );
  }

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void _removeDPFOverlay() {
    overlayPDF?.remove();
    overlayPDF = null;
  }

  @override
  void initState() {
    super.initState();
    _registerPopStateListener();
  }

  @override
  void dispose() {
    super.dispose();
    _removeDPFOverlay();
    EasyLoading.dismiss();
    _popStateSubscription?.cancel();
    removeHighlightOverlay();
    _titleFocusNode.dispose();
    _controllerTitle.dispose();
    _controllerCampaignTitle.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostBloc, PostState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PostBloc()..add(PostEvent.init(widget.postType)),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildActionPostRegisterScreen(context, bloc, state);
      },
    );
  }

  _onComplete(msg) {
    context.showAlertDialog(title: "등록완료", message: msg).then((value) => context.router.pop(true));
  }

  Widget _buildActionPostRegisterScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      bloc: bloc,
      listenWhen: (prev, cur) => prev.completeMsg != cur.completeMsg,
      listener: (context, state) {
        if (state.completeMsg != "") {
          _onComplete(state.completeMsg);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: MainAppBar(mainTitle: "${widget.postType.title} 등록", context: context),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(children: [
                  _buildActionTypeList(context, bloc, state),
                  const SizedBox(height: 24),
                  if (!widget.postType.isAction) ...[
                    ActCampaignTitleInput(
                        controllerCampaignTitle: _controllerCampaignTitle,
                        onChanged: (String value) => bloc.add(PostEvent.setCampaignTitle(value))),
                    const SizedBox(height: 24),
                  ],
                  _buildSelectTarget(context, bloc, state),
                  const SizedBox(height: 16),
                  _buildPostTitleScreen(context, bloc, state),
                  const SizedBox(height: 16),
                  _buildForm(context, bloc, state),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, PostBloc bloc, PostState state) {
    switch (state.selectedActionDocumentType) {
      case ActionDocumentType.poll:
        return SurveyScreen(parentContext: context, bloc: bloc, state: state);
      case ActionDocumentType.digitalDocument:
        return DigitalDocumentScreen(
            parentContext: context,
            bloc: bloc,
            state: state,
            overlayPDF: overlayPDF,
            createPDFOverlay: _createPDFOverlay,
            removeDPFOverlay: _removeDPFOverlay);
      default:
        return AllSignScreen(parentContext: context, bloc: bloc, state: state);
    }
  }

  Widget _buildActionTypeList(BuildContext context, PostBloc bloc, PostState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ...ActionDocumentType.getDocsTypeList(widget.postType)
            .map(
              (item) => _buildFilterButton(
                  context, bloc, state, item.title, state.selectedActionDocumentType == item, const Color(0xff2A4ABA),
                  () {
                if (state.selectedActionDocumentType != item) {
                  bloc.add(const PostEvent.setActionPreview(isPreviewOn: false));
                  bloc.add(PostEvent.setActionDocType(item));
                }
              }),
            )
            .toList(),
      ],
    );
  }

  Widget _buildFilterButton(BuildContext context, PostBloc bloc, PostState state, String text, bool isSelected,
      Color mainColor, void Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: text == '전자문서' ? 16.0 : 0),
      child: isSelected
          ? ElevatedButton(
              onPressed: onPressed, child: SizedBox(width: 90, height: 40, child: Center(child: Text(text))))
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              child: SizedBox(width: 90, height: 40, child: Center(child: Text(text))),
            ),
    );
  }

  Widget _buildPostTitleScreen(BuildContext context, PostBloc bloc, PostState state) {
    return ActFieldContainer(
      title: widget.postType.isAction ? "제목" : '게시글 제목',
      children: [
        Expanded(
          child: TextField(
            focusNode: _titleFocusNode,
            controller: _controllerTitle,
            decoration: InputDecoration(
              hintText: "제목을 입력하세요.",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
            ),
            onChanged: (value) {
              bloc.add(PostEvent.setTitle(value));
            },
          ),
        )
      ],
    );
  }

  Widget _buildSelectTarget(BuildContext context, PostBloc bloc, PostState state) {
    return (BlocListener<PostBloc, PostState>(
      listener: (context, state) {},
      child: ActFieldContainer(
        title: widget.postType.isAction ? "종목" : '종목그룹',
        children: [
          BlocListener<PostBloc, PostState>(
              listenWhen: (previousState, currentState) =>
                  previousState.targetCandidateStockList != currentState.targetCandidateStockList,
              listener: (context, state) {
                if (state.targetCandidateStockList.isNotEmpty) {
                  overlayEntry = createSimpleStockOverlay(
                    context: context,
                    textFieldKey: textFieldTargetKey,
                    simpleStockList: state.targetCandidateStockList,
                    onListTap: (i) {
                      _controllerTarget.text = state.targetCandidateStockList[i].name;
                      bloc.add(PostEvent.setTargetStock(state.targetCandidateStockList[i]));
                      overlayEntry?.remove();
                      overlayEntry = null;
                    },
                    oldOverlayEntry: overlayEntry,
                    removeOverlay: () {
                      overlayEntry?.remove();
                      overlayEntry = null;
                    },
                    sidebarSize: 300,
                  );
                } else {
                  overlayEntry?.remove();
                  overlayEntry = null;
                }
              },
              child: const SizedBox()),
          BlocListener<PostBloc, PostState>(
              listenWhen: (previousState, currentState) =>
                  previousState.targetCandidateStockGroupList != currentState.targetCandidateStockGroupList,
              listener: (context, state) {
                overlayEntry = createStockGroupOverlay(
                  context: context,
                  textFieldKey: textFieldTargetKey,
                  stockGroupList: state.targetCandidateStockGroupList,
                  onListTap: (int i) {
                    _controllerTarget.text = state.targetCandidateStockGroupList[i].name;
                    bloc.add(PostEvent.setTargetStockGroup(state.targetCandidateStockGroupList[i]));
                    overlayEntry?.remove();
                    overlayEntry = null;
                  },
                  oldOverlayEntry: overlayEntry,
                  removeOverlay: () {
                    overlayEntry?.remove();
                    overlayEntry = null;
                  },
                  sidebarSize: 300,
                );
              },
              child: const SizedBox()),
          Expanded(
            child: TextField(
              key: textFieldTargetKey,
              controller: _controllerTarget,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
              onChanged: (value) {
                if (widget.postType == ActionPostType.campaign) {
                  bloc.add(PostEvent.searchStockGroup(value));
                } else {
                  bloc.add(PostEvent.searchStock(value));
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
