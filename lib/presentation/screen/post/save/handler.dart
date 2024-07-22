part of 'screen.dart';

extension _PostSaveScreenStateExtension on _PostSaveScreenState {
  Future<void> _onImageDelete() async {
    final bool imageDeleteConfirmRes = await context.showConfirmDialog(title: '이미지삭제', message: '이미지를 삭제하시겠습니까?');
    if (imageDeleteConfirmRes) {
      GetIt.I<PostSaveBloc>().add(PostSaveEvent.deleteUploadImage());
    }
  }

  Future<void> _onPollCreate() async {
    PollRegisterResult? receivedResult = await ActPollCreateDialog.show(context: context);
    if (receivedResult != null) {
      GetIt.I<PostSaveBloc>().add(PostSaveEvent.createPoll(receivedResult));
    }
  }

  Future<void> _onCameraPressed(int uploadImageFileCount) async {
    if (uploadImageFileCount >= _maxUploadCount) {
      context.showAlertDialog(title: '업로드 갯수 제한', message: '이미지 업로드는 $_maxUploadCount개 까지만 가능합니다');
      return;
    }

    final Uint8List? result = await ImagePickerWeb.getImageAsBytes();
    if (result == null) return;
    GetIt.I<PostSaveBloc>().add(PostSaveEvent.uploadImage(result));
  }

  void _onChangeShareHolderOnly(bool? isChecked) {
    GetIt.I<PostSaveBloc>().add(PostSaveEvent.toggleIsExclusiveToHolders());
  }

  void _onChangeAnonymousMode(bool isChecked) {
    GetIt.I<PostSaveBloc>().add(PostSaveEvent.toggleAnonymous());
  }

  Future<void> _onSavePressed() async {
    final PostSaveBloc bloc = GetIt.I<PostSaveBloc>();
    final formState = _formKey.currentState;

    if (formState == null) return;

    if (formState.validate()) {
      formState.save();
      FocusManager.instance.primaryFocus?.unfocus();
      bloc.add(PostSaveEvent.save(
        title: _titleTextController.text,
        content: _contentTextController.text,
        isAnonymous: bloc.state.isAnonymous,
        polls: bloc.state.pollRegisterResultList.map((poll) => poll.toPoll()).toList(),
      ));
    }
  }

  void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry? createSimpleStockOverlay({
    required BuildContext context,
    required GlobalKey textFieldKey,
    required List<BaseStock> holdingStockList,
    required void Function(int i) onListTap,
    OverlayEntry? oldOverlayEntry,
    required void Function() removeOverlay,
    double sidebarSize = 300,
  }) {
    if (textFieldKey.currentContext == null) return null;
    final RenderBox renderBox = textFieldKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final topPosition = offset.dy + size.height + 4;
    // Remove the existing OverlayEntry.
    removeOverlay();
    // assert(oldOverlayEntry == null);
    if (holdingStockList.isEmpty) return null;

    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // 여기서 Positioned 위젯을 사용하여 정확한 위치를 설정합니다.
        return PointerInterceptor(
            child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                removeOverlay();
                return;
              },
            ),
            Positioned(
              top: topPosition, // 위에서 떨어진 위치
              left: offset.dx, // 왼쪽에서 떨어진 위치
              width: size.width, // TextField의 가로 크기를 설정합니다.
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xffd9d9d9), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                        spreadRadius: 0, // 그림자의 범위를 설정합니다.
                        blurRadius: 11, // 흐림 정도를 설정합니다.
                        offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                      ),
                    ]),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: holdingStockList.length,
                    itemBuilder: (context, i) {
                      // 리스트 아이템을 구축합니다.
                      return ListTile(
                        title: Row(
                          children: [
                            Text('${holdingStockList[i].name}(${holdingStockList[i].code})'),
                          ],
                        ),
                        onTap: () => onListTap(i),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      GetIt.I<PostSaveBloc>().add(PostSaveEvent.tempSavePostContent(_contentTextController.text));
    });
  }
}
