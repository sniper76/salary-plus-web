part of '../widget.dart';

class PollItemWidget extends StatefulWidget {
  final int index;
  final int minItemCount;
  final bool isEdit;
  final bool isDeleteButtonEnabled;
  final String? initialValue;

  const PollItemWidget({
    super.key,
    required this.index,
    required this.isEdit,
    required this.isDeleteButtonEnabled,
    required this.minItemCount,
    this.initialValue,
  });

  @override
  State<PollItemWidget> createState() => _PollItemWidgetState();
}

class _PollItemWidgetState extends State<PollItemWidget> {
  late final TextEditingController _textController = TextEditingController(text: widget.initialValue ?? '');

  @override
  Widget build(BuildContext context) {
    return ActTextFormField(
      controller: _textController,
      onChanged: (String value) {
        final ActPollCreateBloc bloc = GetIt.I<ActPollCreateBloc>();
        bloc.add(ActPollCreateEvent.changePollItem(widget.index, value));
      },
      margin: const EdgeInsets.symmetric(vertical: 2),
      label: widget.index == 0 ? '설문 항목' : null,
      hintText: '항목 ${widget.index + 1}',
      enabled: !widget.isEdit,
      backgroundColor: Colors.transparent,
      suffixIcon: widget.isDeleteButtonEnabled
          ? InkWell(
              onTap: () {
                _onPollItemClearPressed(context, widget.index, widget.minItemCount);
              },
              child: const Icon(Icons.clear),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
