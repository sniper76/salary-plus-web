part of '../screen.dart';

class _SolidarityLeaderWidget extends StatelessWidget {
  final StockHomeBloc bloc;
  final UserAuthService _authService = GetIt.I<UserAuthService>();

  _SolidarityLeaderWidget({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _authService,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bloc.state.stockHome?.leaderElectionDetail != null &&
                        bloc.state.stockHome?.leaderElectionDetail?.electionStatus != ElectionStatus.finished
                    ? '주주대표 선출 공지'
                    : '주주대표 인사말 🎤',
                style: context.textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              Text(_getLeaderMessage(bloc)),
              const Spacer(),
              if (_authService.userMe != null &&
                  _authService.userMe?.leadingSolidarityStockCodes?.contains(bloc.stockCode) == true)
                InkWell(
                  onTap: () {
                    _SolidarityLeaderMessageUpdateDialog.show(
                      context: context,
                      bloc: bloc,
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.content_paste_go,
                                color: context.colorScheme.primary,
                                size: 16.0,
                              ),
                              const SizedBox(width: 2.0),
                              Text(
                                '등록하기',
                                style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.primary),
                              ),
                            ],
                          ),
                          Container(
                            height: 1.0,
                            color: context.colorScheme.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
