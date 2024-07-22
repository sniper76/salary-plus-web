part of '../screen.dart';

class _MySolidarityOrderUpdateDialog extends StatefulWidget {
  final StockBloc bloc = GetIt.I<StockBloc>();

  _MySolidarityOrderUpdateDialog();

  static show({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return _MySolidarityOrderUpdateDialog();
      },
    );
  }

  @override
  _MySolidarityOrderUpdateDialogState createState() => _MySolidarityOrderUpdateDialogState();
}

class _MySolidarityOrderUpdateDialogState extends State<_MySolidarityOrderUpdateDialog> {
  late List<Solidarity> cachedList;

  @override
  void initState() {
    cachedList = [...widget.bloc.state.wholeMySolidarityList];
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _MySolidarityOrderUpdateDialog oldWidget) {
    if (widget.bloc.state.wholeMySolidarityList != oldWidget.bloc.state.wholeMySolidarityList) {
      cachedList = [...widget.bloc.state.wholeMySolidarityList];
    }
    super.didUpdateWidget(oldWidget);
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
                  '종목편집',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/ic_arrow_to_end.svg',
                            width: 22.0,
                          ),
                          Transform.flip(
                            flipY: true,
                            child: SvgPicture.asset(
                              'assets/images/ic_arrow_to_end.svg',
                              width: 22.0,
                            ),
                          ),
                          const Text('맨 위/아래이동'),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/ic_arrow.svg',
                            width: 16.0,
                          ),
                          const SizedBox(width: 4.0),
                          Transform.flip(
                            flipY: true,
                            child: SvgPicture.asset(
                              'assets/images/ic_arrow.svg',
                              width: 16.0,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          const Text('한 칸 이동'),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.drag_indicator),
                          Text('드래그 이동'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ReorderableListView.builder(
                      buildDefaultDragHandles: false,
                      onReorder: onReorderList,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      itemCount: cachedList.length,
                      itemBuilder: (context, index) {
                        final Solidarity solidarity = cachedList[index];
                        return MySolidarityOrderItemWidget(
                          key: Key(index.toString()),
                          index: index,
                          solidarity: solidarity,
                          onClickUpButton: (int index) {
                            if (index == 0) return;
                            onReorderList(index, index - 1);
                          },
                          onClickDownButton: (int index) {
                            if (index == cachedList.length - 1) return;
                            // should be + 2 because of the previous index is already moved to the next index
                            onReorderList(index, index + 2);
                          },
                          onClickTopButton: (int index) {
                            if (index == 0) return;
                            onReorderList(index, 0);
                          },
                          onClickBottomButton: (int index) {
                            if (index == cachedList.length - 1) return;
                            // should cachedList.length because of the previous index is already moved to the next index
                            onReorderList(index, cachedList.length);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ElevatedButton(
                    onPressed: () {
                      widget.bloc.add(const StockEvent.updateDisplayOrder());
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

  void onReorderList(int previousIndex, int currentIndex) {
    setState(() {
      final Solidarity item = cachedList.removeAt(previousIndex);
      cachedList.insert(previousIndex < currentIndex ? currentIndex - 1 : currentIndex, item);
    });

    widget.bloc.add(
      StockEvent.changeDisplayOrder(
        previousIndex: previousIndex,
        currentIndex: currentIndex,
      ),
    );
  }
}
