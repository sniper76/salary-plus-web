import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/enum/poll_selection_type.dart';
import 'package:act_cms/domain/model/enum/poll_vote_type.dart';
import 'package:act_cms/domain/model/poll_register_result.dart';
import 'package:act_cms/presentation/bottomsheet/poll_vote_type_bottom_sheet.dart';
import 'package:act_cms/presentation/screen/action/register/allsign/allsign_screen.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/app_text_form_field.dart';
import 'package:act_cms/presentation/widget/custom_check_box.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PollForm extends StatefulWidget {
  final int index;
  final DateTime? startedAt;
  final DateTime? endedAt;

  final Function({
    DateTime? startedAt,
    DateTime? endedAt,
    String? title,
    String? content,
    List<String>? items,
    PollSelectionType? selectionType,
    PollVoteType? voteType,
  }) onEditPoll;
  final PollRegisterResult pollResult;
  final Function() onDeletePoll;

  const PollForm({
    super.key,
    required this.index,
    required this.onEditPoll,
    required this.pollResult,
    required this.onDeletePoll,
    this.startedAt,
    this.endedAt,
  });

  @override
  State<PollForm> createState() => _PollFormState();
}

class _PollFormState extends State<PollForm> {
  final int _maxItemCount = 10;

  final List<PollInputItem> _items = [];

  var _isMultipleChoice = false;

  var _voteType = PollVoteType.person;

  final _titleTextController = TextEditingController();
  final _contentTextController = TextEditingController();
  final _startedAtTextController = TextEditingController();
  final _endedAtTextController = TextEditingController();
  final _voteTypeTextController = TextEditingController();

  DateTime? _startedAt;

  DateTime? _endedAt;

  PollInputItem _createInputItem({String? value}) {
    return PollInputItem(value: value ?? '');
  }

  _onPollItemAddPressed() {
    if (_items.length >= _maxItemCount) {
      EasyLoading.showToast('설문항목은 최대 $_maxItemCount개까지 입니다');
      return;
    }
    setState(() {
      final newPoll = _createInputItem();
      _items.add(newPoll);
      widget.onEditPoll(items: [...widget.pollResult.pollItems, newPoll.value]);
    });
  }

  _onPollItemDeletePressed(int i) {
    widget.onEditPoll(items: widget.pollResult.pollItems.whereIndexed((index, _) => index != i).toList());
  }

  _onMultipleChoiceCheckedChanged() {
    setState(() {
      _isMultipleChoice = !_isMultipleChoice;
      widget.onEditPoll(selectionType: _isMultipleChoice ? PollSelectionType.multiple : PollSelectionType.single);
    });
  }

  _onPickerStartedDateTime(BuildContext context) async {
    final ret = await showDatePicker(
      context: context,
      initialDate: _startedAt ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (ret != null && mounted) {
      final timeRet = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
        initialEntryMode: TimePickerEntryMode.dialOnly,
      );
      if (timeRet != null) {
        _startedAt = ret.copyWith(hour: timeRet.hour, minute: timeRet.minute, second: 00);
        _startedAtTextController.text = _startedAt?.toFormatString(pattern: dateTimeFormatPattern) ?? '';
        widget.onEditPoll(startedAt: _startedAt);
      }
    }
  }

  _onPickerEndedDate(BuildContext context) async {
    final ret = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (ret != null && mounted) {
      final timeRet = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
        initialEntryMode: TimePickerEntryMode.dialOnly,
      );
      if (timeRet != null) {
        _endedAt = ret.copyWith(hour: timeRet.hour, minute: timeRet.minute, second: 00);
        _endedAtTextController.text = _endedAt?.toFormatString(pattern: dateTimeFormatPattern) ?? '';
        widget.onEditPoll(endedAt: _endedAt);
      }
    }
  }

  _onVoteType(BuildContext context) async {
    final ret = await PollVoteTypeBottomSheet.show(context, selectedValue: _voteType);
    if (ret != null) {
      _voteTypeTextController.text = ret.title;
      setState(() {
        _voteType = ret;
        widget.onEditPoll(voteType: _voteType);
      });
    }
  }

  _onRefresh() {
    _startedAt = widget.startedAt ?? DateTime.now();
    _endedAt = widget.endedAt;

    _startedAtTextController.text = _startedAt?.toFormatString(pattern: dateTimeFormatPattern) ?? '';
    _endedAtTextController.text = _endedAt?.toFormatString(pattern: dateTimeFormatPattern) ?? '';
  }

  _onInit() {
    widget.onEditPoll(items: [_createInputItem().value, _createInputItem().value]);

    _onRefresh();
    _voteTypeTextController.text = _voteType.title;
  }

  @override
  void initState() {
    super.initState();
    _onInit();
  }

  @override
  void didUpdateWidget(PollForm pollForm) {
    super.didUpdateWidget(pollForm);
    if (widget.index > 0) {
      _onRefresh();
      widget.onEditPoll(startedAt: _startedAt);
      widget.onEditPoll(endedAt: _endedAt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActFieldContainer(
      title: "설문 ${widget.index + 1}",
      onDelete: widget.index > 0 ? widget.onDeletePoll : null,
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffD9D9D9)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              AppTextFormField(
                controller: _titleTextController,
                label: '설문 제목',
                onChanged: (value) => widget.onEditPoll(title: value),
              ),
              AppTextFormField(
                controller: _contentTextController,
                label: '설문 내용',
                onChanged: (value) => widget.onEditPoll(content: value),
              ),
              ...widget.pollResult.pollItems.mapIndexed(
                (index, e) {
                  return AppTextFormField(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    label: index == 0 ? '설문 항목' : null,
                    hintText: '항목 ${index + 1}',
                    suffixIcon: index < 2
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _onPollItemDeletePressed(index);
                            },
                          ),
                    onChanged: (value) {
                      widget.onEditPoll(
                          items: widget.pollResult.pollItems.mapIndexed((pollIndex, itemValue) {
                        if (pollIndex == index) return value;
                        return itemValue;
                      }).toList());
                    },
                  );
                },
              ),
              TextButton(
                onPressed: _onPollItemAddPressed,
                child: Text(
                  '설문 항목 추가',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Ink(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: InkWell(
                  onTap: _onMultipleChoiceCheckedChanged,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('복수 선택'),
                        const SizedBox(width: 24),
                        CustomCheckBox(
                          isChecked: _isMultipleChoice,
                          onChanged: (value) => _onMultipleChoiceCheckedChanged(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppTextFormField(
                controller: _startedAtTextController,
                label: '설문 시작일(현재 이후 시점으로 등록 가능합니다)',
                readOnly: true,
                enabled: widget.startedAt == null,
                backgroundColor: widget.startedAt == null ? null : Colors.grey.shade100,
                suffixIcon: Container(
                  height: 12,
                  width: 12,
                  margin: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset('assets/images/ic_calendar.svg'),
                ),
                onTap: () => _onPickerStartedDateTime(context),
              ),
              AppTextFormField(
                controller: _endedAtTextController,
                label: '설문 종료일',
                readOnly: true,
                enabled: widget.endedAt == null,
                backgroundColor: widget.endedAt == null ? null : Colors.grey.shade100,
                suffixIcon: Container(
                  height: 12,
                  width: 12,
                  margin: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'assets/images/ic_calendar.svg',
                  ),
                ),
                onTap: () => _onPickerEndedDate(context),
              ),
              AppTextFormField(
                controller: _voteTypeTextController,
                label: '설문 기준',
                readOnly: true,
                suffixIcon: const RotatedBox(
                  quarterTurns: 45,
                  child: Icon(Icons.arrow_forward_ios),
                ),
                onTap: () => _onVoteType(context),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
