import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/push/notice_push_send_status.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/push_request.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/event_board/register/bloc/bloc.dart';
import 'package:act_cms/presentation/screen/event_board/register/bloc/event.dart';
import 'package:act_cms/presentation/screen/event_board/register/bloc/state.dart';
import 'package:act_cms/presentation/screen/event_board/register/widget/push_check_dialog.dart';
import 'package:act_cms/presentation/widget/based_label.dart';
import 'package:act_cms/presentation/widget/custom_html_editor.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/push_preview.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:html_editor_enhanced/html_editor.dart';

part 'handler.dart';
part 'widget/sections.dart';
part 'widget/radio_Item.dart';
part 'widget/register_pick_date_item.dart';

@RoutePage()
class EventBoardRegisterScreen extends StatefulWidget {
  final BoardGroupCategory boardGroupCategory;
  final Post? updatePost;

  const EventBoardRegisterScreen({
    super.key,
    this.updatePost,
    required this.boardGroupCategory,
  });

  @override
  State<EventBoardRegisterScreen> createState() => _EventBoardRegisterScreenState();
}

class _EventBoardRegisterScreenState extends State<EventBoardRegisterScreen> {
  final _titleTextController = TextEditingController();
  final _contentTextController = HtmlEditorController();
  final _pushTitleTextController = TextEditingController();
  final _pushContentTextController = TextEditingController();

  late final String commandTitle;

  @override
  void initState() {
    super.initState();
    GetIt.I.registerSingleton(
      EventBoardRegisterBloc(
        boardGroupCategory: widget.boardGroupCategory,
        updatePost: widget.updatePost,
      ),
      instanceName: widget.boardGroupCategory.name,
    );
    commandTitle = widget.updatePost == null ? "등록" : "수정";

    _titleTextController.text = widget.updatePost == null ? '' : widget.updatePost?.title ?? '';
    _pushTitleTextController.text = widget.updatePost == null ? '' : widget.updatePost?.push?.title ?? '';
    _pushContentTextController.text = widget.updatePost == null ? '' : widget.updatePost?.push?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<EventBoardRegisterBloc, EventBoardRegisterState>(
      create: (context) => GetIt.I.get<EventBoardRegisterBloc>(instanceName: widget.boardGroupCategory.name)
        ..add(EventBoardRegisterEvent.init()),
      listener: (context, state) {
        if (state.isComplete) {
          _onComplete(context, commandTitle);
        }
      },
      builder: (context, bloc, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: MainAppBar(
              mainTitle: '${widget.boardGroupCategory.displayName} $commandTitle',
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _CategorySection(
                    boardGroupCategory: widget.boardGroupCategory,
                  ),
                  const SizedBox(height: 15),
                  _TitleSection(
                    onChanged: (String? titleString) {
                      _onTitleTextChanged(bloc, titleString);
                    },
                    titleTextController: _titleTextController,
                  ),
                  const SizedBox(height: 15),
                  _ActiveRadioSection(
                    bloc: bloc,
                  ),
                  const SizedBox(height: 15),
                  _RegisterSection(bloc: bloc),
                  const SizedBox(height: 15),
                  _MainContentSection(
                    contentTextController: _contentTextController,
                    updatePost: widget.updatePost,
                  ),
                  const SizedBox(height: 15),
                  _SendAlarmSection(bloc: bloc),
                  const SizedBox(height: 15),
                  widget.updatePost == null ? _SendPushSection(bloc: bloc) : const SizedBox.shrink(),
                  const SizedBox(height: 15),
                  Column(
                    children: [
                      if (widget.updatePost?.push != null) ...[
                        _PushViewSection(
                          title: '푸시 제목',
                          content: _pushTitleTextController.text,
                        ),
                        const SizedBox(height: 15),
                        _PushViewSection(
                          title: '푸시 내용',
                          content: _pushContentTextController.text,
                        ),
                      ] else if (state.selectedNoticePushSendStatus == NoticePushSendStatus.send) ...[
                        _TitleSection(
                          onChanged: (String? pushTitleString) {
                            _onPushTitleTextChanged(bloc, pushTitleString);
                          },
                          titleTextController: _pushTitleTextController,
                        ),
                        const SizedBox(height: 15),
                        _ContentSection(
                          onChanged: (String? pushContentString) {
                            _onPushContentTextChanged(bloc, pushContentString);
                          },
                          contentTextController: _pushContentTextController,
                        ),
                        const SizedBox(height: 15),
                        BasedLabel(
                          label: '미리보기',
                          children: [
                            PushPreview(
                              title: state.pushRequest?.title,
                              targetDatetime: state.activeStartDate,
                              content: state.pushRequest?.content ?? '',
                              targetSearchType: state.targetType!,
                            ),
                          ],
                        ),
                      ] else
                        const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _saveEventBoardPost(
                          bloc: bloc,
                          state: state,
                          titleController: _titleTextController,
                          contentController: _contentTextController,
                          pushTitleTextController: _pushTitleTextController,
                          pushContentTextController: _pushContentTextController,
                        ),
                        child: Text(widget.updatePost == null ? '등록' : '수정'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                        onPressed: _onTapCancelButton,
                        child: const Text('취소'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ]),
              ),
            ));
      },
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<EventBoardRegisterBloc>(instanceName: widget.boardGroupCategory.name);
    EasyLoading.dismiss();
    super.dispose();
  }
}
