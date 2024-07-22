import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/poll_selection_type.dart';
import 'package:act_web/domain/enum/poll_vote_type.dart';
import 'package:act_web/domain/model/post/poll_register_result.dart';
import 'package:act_web/presentation/widget/act_poll_create_dialog/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_text_form_field.dart';
import 'package:act_web/presentation/widget/custom_check_box.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'section/content_section.dart';

part 'widget/dialog_title_widget.dart';
part 'widget/poll_item_widget.dart';

part 'handler.dart';

class ActPollCreateDialog extends StatefulWidget {
  final PollRegisterResult? result;
  final BoardGroupType? boardGroupType;

  const ActPollCreateDialog({
    super.key,
    this.result,
    this.boardGroupType,
  });

  static Future<PollRegisterResult?> show({
    required BuildContext context,
    PollRegisterResult? result,
    BoardGroupType? boardGroupType,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return ActPollCreateDialog(
          result: result,
          boardGroupType: boardGroupType,
        );
      },
    );
  }

  @override
  ActPollCreateDialogState createState() => ActPollCreateDialogState();
}

class ActPollCreateDialogState extends State<ActPollCreateDialog> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _contentTextController = TextEditingController();
  final TextEditingController _startedAtTextController = TextEditingController();
  final TextEditingController _endedAtTextController = TextEditingController();
  final TextEditingController _voteTypeTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _titleTextController.text = widget.result?.title ?? '';
    _contentTextController.text = widget.result?.content ?? '';
    _startedAtTextController.text = widget.result?.startedAt.toFormatString(pattern: 'yyyy-MM-dd HH:mm:ss') ?? '';
    _endedAtTextController.text = widget.result?.endedAt.toFormatString(pattern: 'yyyy-MM-dd HH:mm:ss') ?? '';
    _voteTypeTextController.text = widget.result?.voteType.title ?? '';

    if (GetIt.I.isRegistered<ActPollCreateBloc>() == false) {
      GetIt.I.registerSingleton(ActPollCreateBloc(widget.result));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActPollCreateBloc, ActPollCreateState>(
      bloc: GetIt.I<ActPollCreateBloc>()..add(const ActPollCreateEvent.init()),
      builder: (context, state) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          width: 500.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _DialogTitleWidget(title: '설문 ${state.isEdit ? '수정' : '입력'}'),
              const SizedBox(height: 24.0),
              _ContentSection(
                bloc: GetIt.I<ActPollCreateBloc>(),
                titleTextController: _titleTextController,
                contentTextController: _contentTextController,
                startedAtTextController: _startedAtTextController,
                endedAtTextController: _endedAtTextController,
                voteTypeTextController: _voteTypeTextController,
                isEnableSelectPollVoteType: widget.boardGroupType?.enableSelectPollVoteType ?? false,
              ),
              ElevatedButton(
                onPressed: _onPollSave,
                child: Text('설문 ${state.isEdit ? '수정' : '생성'}'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<ActPollCreateBloc>();
    _titleTextController.dispose();
    _contentTextController.dispose();
    _startedAtTextController.dispose();
    _endedAtTextController.dispose();
    super.dispose();
  }
}
