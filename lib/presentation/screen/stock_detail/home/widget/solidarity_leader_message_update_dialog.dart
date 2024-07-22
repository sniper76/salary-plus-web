part of '../screen.dart';

class _SolidarityLeaderMessageUpdateDialog extends StatefulWidget {
  final StockHomeBloc bloc;

  const _SolidarityLeaderMessageUpdateDialog({
    required this.bloc,
  });

  static show({
    required BuildContext context,
    required StockHomeBloc bloc,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return _SolidarityLeaderMessageUpdateDialog(
          bloc: bloc,
        );
      },
    );
  }

  @override
  _SolidarityLeaderMessageUpdateDialogState createState() => _SolidarityLeaderMessageUpdateDialogState();
}

class _SolidarityLeaderMessageUpdateDialogState extends State<_SolidarityLeaderMessageUpdateDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.bloc.state.stockHome?.leader?.leaderMessage ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        width: 500.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '주주대표 인사말 등록',
                  style: context.textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    context.router.maybePop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 300.0,
                    child: TextField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText: '주주대표 인사말을 입력해주세요',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      maxLength: 150,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {
                      widget.bloc.add(StockHomeEvent.updateSolidarityLeaderMessage(_controller.text));
                      context.router.maybePop(true);
                    },
                    style: ElevatedButton.styleFrom(fixedSize: const Size(120, 40)),
                    child: const Text('저장'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
