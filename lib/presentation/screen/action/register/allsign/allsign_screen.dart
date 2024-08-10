import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_proxy_result.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/presentation/screen/action/pdf_screen/sfpdf_screen.dart';
import 'package:act_cms/presentation/screen/action/register/bloc/bloc.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/widget/app_text_form_field.dart';
import 'package:act_cms/presentation/widget/notification_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker_web/image_picker_web.dart';

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

class AllSignScreen extends StatefulWidget {
  final BuildContext parentContext;
  final PostBloc bloc;
  final PostState state;

  const AllSignScreen({super.key, required this.parentContext, required this.bloc, required this.state});

  @override
  State<AllSignScreen> createState() => _PostState();
}

class _PostState extends State<AllSignScreen> {
  final TextEditingController _controllerTitle = TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();
  final TextEditingController _controllerTarget = TextEditingController();
  final textFieldSourceKey = GlobalKey();
  final textFieldTargetKey = GlobalKey();
  OverlayEntry? overlayEntry;
  final textFieldKey = GlobalKey();
  List<FocusNode>? listItemFocusNodes;
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  bool _isNotification = false;

  final _startedAtTextController = TextEditingController();
  final _endedAtTextController = TextEditingController();
  final _templateIdTextController = TextEditingController();
  final _templateNameTextController = TextEditingController();
  final _templateRoleTextController = TextEditingController();

  final _uploadImage = getIt<UploadImage>();

  DateTime? _startedAt;
  DateTime? _endedAt;

  @override
  void initState() {
    super.initState();
    _startedAt = DateTime.now();
    _startedAtTextController.text = _startedAt!.toFormatString();
  }

  @override
  void dispose() {
    _templateIdTextController.dispose();
    _templateNameTextController.dispose();
    _templateRoleTextController.dispose();
    EasyLoading.dismiss();
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostRegisterScreen(widget.parentContext, widget.bloc, widget.state);
  }

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Widget _buildPostRegisterScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      bloc: bloc,
      listener: (context, state) {},
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildSelectTargetBoard(context, bloc, state),
                      const SizedBox(height: 16),
                      _buildPostTitleScreen(context, bloc, state),
                      const SizedBox(height: 16),
                      _buildPostContentEditScreen(context, bloc, state),
                      const SizedBox(height: 16),
                      _buildDigitalProxy(context, bloc, state),
                      const SizedBox(height: 16),
                      _buildDocSubmitButton(context, bloc, state),
                    ],
                  ),
                ),
                state.isPreviewOn
                    ? SizedBox(
                        width: 500,
                        height: 500,
                        child: SfPDFScreen(
                          url: state.pdf!,
                        ))
                    : const SizedBox(height: 16),
              ],
            )),
      ),
    );
  }

  Widget _buildDocSubmitButton(BuildContext context, PostBloc bloc, PostState state) {
    return Column(children: [
      const SizedBox(height: 16),
      NotificationCheckBox(
        onChange: (newState) {
          setState(() {
            _isNotification = !newState;
            bloc.add(PostEvent.setIsNotification(newState));
          });
        },
        isChecked: _isNotification,
      ),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: () async {
          String content = await controller.getText();
          if (state.stockCode == null) {
            EasyLoading.showToast('종목을 선택해주세요');
            return;
          }
          if (_controllerTitle.text.isEmpty) {
            EasyLoading.showToast('제목을 입력해주세요');
            return;
          }
          if (content == "") {
            EasyLoading.showToast('내용을 입력해주세요');
            return;
          }

          if (_templateIdTextController.text.isEmpty) {
            EasyLoading.showToast('모두싸인 템플릿 ID를 입력해주세요');
            return;
          }

          if (_templateNameTextController.text.isEmpty) {
            EasyLoading.showToast('모두싸인 템플릿 Name을 입력해주세요');
            return;
          }

          if (_templateRoleTextController.text.isEmpty) {
            EasyLoading.showToast('모두싸인 템플릿 Role을 입력해주세요');
            return;
          }

          if (_startedAt == null || _endedAt == null) {
            EasyLoading.showToast('시작일과 종료일을 설정해주세요');
            return;
          }
          final result = DigitalProxyResult(
            templateId: _templateIdTextController.text,
            templateName: _templateNameTextController.text,
            templateRole: _templateRoleTextController.text,
            startedAt: _startedAt!,
            endedAt: _endedAt!,
          );
          bloc.add(PostEvent.actionSave(
            title: state.title ?? "",
            content: content,
            digitalProxy: result,
            isAnonymous: true,
            isNotification: _isNotification,
            boardGroupCategory:
                BoardGroupCategory(displayName: BoardCategoryType.digitalDelegation.title, name: "DIGITAL_DELEGATION"),
          ));
        },
        child: Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text('등록')),
      )
    ]);
  }

  Widget _buildPostTitleScreen(BuildContext context, PostBloc bloc, PostState state) {
    return Row(
      children: [
        _buildTitle("제목"),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
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
        ),
      ],
    );
  }

  Widget _buildPostContentEditScreen(BuildContext context, PostBloc bloc, PostState state) {
    return Row(
      children: [
        _buildTitle("내용"),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(
              minHeight: 48,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SingleChildScrollView(
              child: HtmlEditor(
                controller: controller,
                htmlEditorOptions: const HtmlEditorOptions(
                  autoAdjustHeight: false,
                  hint: 'Your text here...',
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  toolbarPosition: ToolbarPosition.aboveEditor,
                  toolbarType: ToolbarType.nativeGrid,
                  onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) async {
                    if (ButtonType.picture == type) {
                      final bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                      final res = await _uploadImage(file: List<int>.from(bytesFromPicker!));
                      if (res.isSuccess()) {
                        final result = res.tryGetSuccess();
                        if (result != null) {
                          controller.insertNetworkImage(result.url);
                        }
                      }
                      return false;
                    }

                    return true;
                  },
                  onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
                    return true;
                  },
                  mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                    return true;
                  },
                ),
                otherOptions: const OtherOptions(height: 500),
                callbacks: Callbacks(
                  onFocus: () {
                    FocusScope.of(context).unfocus();
                    controller.setFocus();
                  },
                  onBlur: () {
                    controller.clearFocus();
                  },
                  onNavigationRequestMobile: (String url) {
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitalProxy(BuildContext context, PostBloc bloc, PostState state) {
    _onPickerStartedDateTime() async {
      final ret = await showDatePicker(
        context: context,
        initialDate: _startedAt ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)),
      );
      if (ret != null) {
        _startedAt = ret;
        _startedAtTextController.text = _startedAt != null ? _startedAt!.toFormatString() : "-";
      }
    }

    _onPickerEndedDate() async {
      final ret = await showDatePicker(
        context: context,
        initialDate: _endedAt ?? DateTime.now().add(const Duration(days: 7)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)),
      );

      if (ret != null) {
        _endedAt = ret;
        _endedAtTextController.text = _endedAt == null ? "-" : _endedAt!.toFormatString();
      }
    }

    return Row(
      children: [
        _buildTitle("모두싸인"),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffD9D9D9)),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(children: [
                AppTextFormField(
                  controller: _templateIdTextController,
                  label: '모두싸인 템플릿 ID',
                ),
                AppTextFormField(
                  controller: _templateNameTextController,
                  label: '모두싸인 템플릿 Name',
                ),
                AppTextFormField(
                  controller: _templateRoleTextController,
                  label: '모두싸인 템플릿 Role',
                ),
                AppTextFormField(
                  controller: _startedAtTextController,
                  label: '시작일',
                  readOnly: true,
                  suffixIcon: Container(
                    height: 12,
                    width: 12,
                    margin: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      'assets/images/ic_calendar.svg',
                    ),
                  ),
                  onTap: _onPickerStartedDateTime,
                ),
                AppTextFormField(
                  controller: _endedAtTextController,
                  label: '종료일',
                  readOnly: true,
                  suffixIcon: Container(
                    height: 12,
                    width: 12,
                    margin: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      'assets/images/ic_calendar.svg',
                    ),
                  ),
                  onTap: _onPickerEndedDate,
                ),
              ])),
        ),
      ],
    );
  }

  Widget _buildSelectTargetBoard(BuildContext context, PostBloc bloc, PostState state) {
    return (BlocListener<PostBloc, PostState>(
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
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          _buildTitle("종목"),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              key: textFieldTargetKey,
              controller: _controllerTarget,
              decoration: InputDecoration(
                hintText: "종목명 또는 종목코드를 입력하세요.",
                label: state.stockDetail == null ? null : Text(state.stockDetail!.solidarity!.name),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
              onChanged: (value) {
                bloc.add(PostEvent.searchStock(value));
              },
              onSubmitted: (value) {
                _controllerTarget.text = state.targetCandidateStockList[0].name;
                bloc.add(PostEvent.setTargetStock(state.targetCandidateStockList[0]));
              },
            ),
          ),
        ])));
  }

  Widget _buildTitle(String title) {
    return SizedBox(
      width: 80,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: titleStyle,
      ),
    );
  }
}
