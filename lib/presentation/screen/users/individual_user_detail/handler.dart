part of 'screen.dart';

extension _UserDetailStateExtension on _UserDetailState {
  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      context.router.pop();
    });
  }
}

void _onOpenNicknameDialog(BuildContext context, String? nickname, TextEditingController nicknameController) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      nicknameController.text = nickname ?? getRandomNickName();

      return AlertDialog(
        title: const Text("닉네임 변경"),
        content: TextField(
          controller: nicknameController,
          decoration: const InputDecoration(
            hintText: "새 닉네임을 입력하세요",
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("취소"),
            onPressed: () {
              Navigator.of(context).pop(); // 팝업 닫기
            },
          ),
          TextButton(
            onPressed: () {
              final bloc = GetIt.I<UserDetailBloc>();
              bloc.add(UserDetailEvent.updateNickname(nicknameController.text));
              Navigator.of(context).pop(true);
            },
            child: const Text("저장"),
          ),
        ],
      );
    },
  );
}

void _onTapConfidentailDownloadButton() async {
  final bloc = GetIt.I<UserDetailBloc>();
  bloc.add(const UserDetailEvent.downloadConfidential());
}

String getRandomNickName() {
  var rng = Random();
  final int randomNumber = rng.nextInt(1000000); // 0부터 999999까지의 숫자를 생성
  final String randomNickName = randomNumber.toString().padLeft(6, '0');
  return '액트$randomNickName';
}

void _onMoveDummyStockScreen(BuildContext context, int userId) async {
  final res = await context.router.push(CmsDummyStockRoute(userId: userId));
  if (res != null) _addDummyStock(res as UserStockData);
}

void _onOpenDeleteDummyStock(String stockCode) async {
  final bloc = GetIt.I<UserDetailBloc>();
  bloc.add(UserDetailEvent.deleteDummyData(stockCode));
}

void _onOpenDeleteDummyStockDialog(BuildContext context, String stockCode) async {
  final res = await context.showConfirmDialog(title: '더미 종목 삭제', message: '더미 종목을 삭제하시겠습니까?');
  if (res == true) _onOpenDeleteDummyStock(stockCode);
}

void _addDummyStock(UserStockData dummyStock) {
  final bloc = GetIt.I<UserDetailBloc>();
  bloc.add(UserDetailEvent.addDummyData(dummyStock));
}
