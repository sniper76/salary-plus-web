part of '../widget.dart';

class _ContentSection extends StatelessWidget {
  final TextEditingController titleTextController;
  final TextEditingController contentTextController;
  final TextEditingController startedAtTextController;
  final TextEditingController endedAtTextController;
  final TextEditingController voteTypeTextController;
  final bool isEnableSelectPollVoteType;

  final ActPollCreateBloc bloc;
  late final ActPollCreateState state = bloc.state;

  _ContentSection({
    required this.bloc,
    required this.titleTextController,
    required this.contentTextController,
    required this.startedAtTextController,
    required this.endedAtTextController,
    required this.voteTypeTextController,
    required this.isEnableSelectPollVoteType,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEdit = state.isEdit;

    const int maxItemCount = 10;
    const int minItemCount = 2;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        behavior: HitTestBehavior.translucent,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            if (isEdit)
              Text(
                '- 종료일만 수정할 수 있습니다.',
                style: context.textTheme.bodySmall?.copyWith(color: Colors.red),
              ),
            ActTextFormField(
              controller: titleTextController,
              label: '설문 제목',
              enabled: !isEdit,
            ),
            ActTextFormField(
              controller: contentTextController,
              label: '내용',
              keyboardType: TextInputType.multiline,
              maxLines: null,
              enabled: !isEdit,
            ),
            ...state.pollItemList.mapIndexed(
              (index, e) {
                return PollItemWidget(
                  initialValue: state.pollItemList[index],
                  index: index,
                  minItemCount: minItemCount,
                  isEdit: isEdit,
                  isDeleteButtonEnabled: state.pollItemList.length > 2,
                );
              },
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  if (isEdit) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('설문 항목 수정은 다시 등록하셔야 합니다.'),
                    ));
                    return;
                  }
                  _onPollItemAddPressed(context, maxItemCount);
                },
                child: Text(
                  '설문 항목 추가',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: !isEdit ? _onMultipleChoiceCheckedChanged : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('복수 선택'),
                    CustomCheckBox(
                      enabled: !isEdit,
                      isChecked: state.isMultipleChoiceAllowd,
                      onChanged: (bool isCheck) => _onMultipleChoiceCheckedChanged(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ActTextFormField(
              controller: startedAtTextController,
              label: '설문 시작일(현재 이후 시점으로 등록 가능합니다)',
              readOnly: true,
              enabled: !isEdit,
              backgroundColor: !isEdit ? null : Colors.grey.shade300,
              suffixIcon: const RotatedBox(quarterTurns: 45, child: Icon(Icons.arrow_forward_ios)),
              onTap: !isEdit ? () => _onPickerStartedDateTime(context, startedAtTextController) : null,
            ),
            ActTextFormField(
              controller: endedAtTextController,
              label: '설문 종료일',
              readOnly: true,
              suffixIcon: const RotatedBox(quarterTurns: 45, child: Icon(Icons.arrow_forward_ios)),
              onTap: () => _onPickerEndedDate(context, endedAtTextController),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('설문 기준'),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.white,
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      value: state.selectedVoteType,
                      hint: const Text('선택'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (newValue) {
                        bloc.add(ActPollCreateEvent.changeVoteType(newValue!));
                      },
                      items: PollVoteType.values
                          .where((PollVoteType voteType) => voteType != PollVoteType.unknown)
                          .map<DropdownMenuItem>((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value.title,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
