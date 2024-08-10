import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/poll_selection_type.dart';
import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/domain/model/poll_register_result.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/presentation/screen/action/register/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/notification_checkbox.dart';
import 'package:act_cms/presentation/widget/poll_form.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class SurveyScreen extends StatefulWidget {
  final BuildContext parentContext;
  final PostBloc bloc;
  final PostState state;

  const SurveyScreen({super.key, required this.parentContext, required this.bloc, required this.state});

  @override
  State<SurveyScreen> createState() => _PostState();
}

class _PostState extends State<SurveyScreen> {
  final HtmlEditorController controller = HtmlEditorController();
  final textFieldSourceKey = GlobalKey();

  OverlayEntry? overlayEntry;
  final textFieldKey = GlobalKey();

  final _uploadImage = getIt<UploadImage>();
  bool _isNotification = false;

  _onVotePoll(PostBloc bloc, index) => ({
        DateTime? startedAt,
        DateTime? endedAt,
        String? title,
        String? content,
        List<String>? items,
        PollSelectionType? selectionType,
        PollVoteType? voteType,
      }) {
        bloc.add(PostEvent.onEditPoll(
          pollId: index,
          title: title,
          content: content,
          items: items,
          selectionType: selectionType,
          voteType: voteType,
          endedAt: endedAt,
          startedAt: startedAt,
        ));
      };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostRegisterScreen(widget.parentContext, widget.bloc, widget.state);
  }

  Widget _buildPostRegisterScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      bloc: bloc,
      listener: (context, state) {},
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                _buildPostContentEditScreen(context, bloc, state),
                const SizedBox(height: 16),
                ...state.pollResults.mapIndexed((index, poll) {
                  return PollForm(
                      index: index,
                      pollResult: poll,
                      onDeletePoll: () => bloc.add(PostEvent.onDeletePoll(index)),
                      startedAt: index > 0 ? state.pollResults.first.startedAt : null,
                      endedAt: index > 0 ? state.pollResults.first.endedAt : null,
                      onEditPoll: _onVotePoll(bloc, index));
                }),
                const SizedBox(height: 16),
                if (state.pollResults.isNotEmpty) _buildAddPollButton(bloc, state.pollResults.first),
                _buildDocSubmitButton(context, bloc, state)
              ],
            )),
      ),
    );
  }

  Widget _buildAddPollButton(PostBloc bloc, PollRegisterResult firstPoll) {
    final validateString = _validPollInputs(firstPoll);
    onAddPoll() {
      if (validateString != null) {
        EasyLoading.showToast(validateString);
        return;
      }
      bloc.add(const PostEvent.addPoll());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tooltip(
          message: validateString ?? '',
          child: ElevatedButton(
            onPressed: onAddPoll,
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.amber)),
            child: const Text('설문 추가', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  bool _checkSameText(List<String> items) {
    final inputTexts = items.where((value) => value.isNotEmpty).map((value) => value).toList();
    return inputTexts.length != inputTexts.toSet().length;
  }

  // state.title == null || state.title!.isEmpty

  bool _validChoices(List<String> items) {
    final inputTextCount = items.where((value) => value.isNotEmpty).length;
    return inputTextCount > 1;
  }

  String? _validPollInputs(PollRegisterResult pollResult) {
    if (pollResult.title.isEmpty) {
      return '설문 제목을 입력해주세요';
    }
    if (!_validChoices(pollResult.pollItems)) {
      return '설문항목은 2개 이상 입력하셔야 합니다';
    }

    if (_checkSameText(pollResult.pollItems)) {
      return '동일한 설문항목이 있습니다';
    }

    if (pollResult.endedAt == null) {
      return '시작일과 종료일을 설정해주세요';
    }
    return null;
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
          if (state.postType == null) return;

          String content = await controller.getText();
          if (state.postType!.isCampaign && state.stockGroup == null) {
            EasyLoading.showToast('종목그룹을 선택해주세요');
            return;
          }

          if (state.postType!.isAction && state.stockCode == null) {
            EasyLoading.showToast('종목을 선택해주세요');
            return;
          }

          if (content == "") {
            EasyLoading.showToast('내용을 입력해주세요');
            return;
          }

          for (final pollResult in state.pollResults) {
            final validateString = _validPollInputs(pollResult);
            if (validateString != null) {
              EasyLoading.showToast(validateString);
              return;
            }
          }

          if (state.postType!.isCampaign) {
            bloc.add(PostEvent.campaignSave(
              title: state.title ?? "",
              content: content,
              polls: state.pollResults.map((pollResult) => pollResult.toPoll()).toList(),
              isAnonymous: true,
              boardGroupCategory: const BoardGroupCategory(displayName: "설문", name: "SURVEYS"),
              isNotification: _isNotification,
            ));
          } else {
            bloc.add(PostEvent.actionSave(
              title: state.title ?? "",
              content: content,
              polls: state.pollResults.map((pollResult) => pollResult.toPoll()).toList(),
              isAnonymous: true,
              boardGroupCategory: const BoardGroupCategory(displayName: "설문", name: "SURVEYS"),
              isNotification: _isNotification,
            ));
          }
        },
        child: Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text('등록')),
      )
    ]);
  }

  Widget _buildPostContentEditScreen(BuildContext context, PostBloc bloc, PostState state) {
    return ActFieldContainer(
      title: "내용",
      children: [
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
                  onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
                    if (file != null) {}
                  },
                  onNavigationRequestMobile: (String url) {
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
