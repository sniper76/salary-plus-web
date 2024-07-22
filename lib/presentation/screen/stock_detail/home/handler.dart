part of 'screen.dart';

String _getLeaderMessage(StockHomeBloc bloc) {
  bool isHaveLeaderMessage = bloc.state.stockHome?.leader?.leaderMessage.isNotEmpty == true;

  switch (bloc.state.stockHome?.leaderElectionDetail?.electionStatus) {
    case ElectionStatus.candidateRegistrationPeriod:
      return '주주대표 선출을 위한 후보자 등록이 시작되었습니다.\n주주대표에 관심이 있다면 앱에서 지원해 보세요!';
    case ElectionStatus.votePeriod:
      return '주주대표 후보자 등록이 마감되었습니다.\n앱에서 주주대표 선출을 위한 투표를 해주세요';
    case ElectionStatus.finished:
    default:
      if (bloc.state.stockHome?.leader?.isElected == true) {
        if (isHaveLeaderMessage) {
          return bloc.state.stockHome?.leader?.leaderMessage ?? '';
        } else {
          return '주주대표가 아직 등록하지 않았습니다.';
        }
      } else {
        return '아직 주주대표가 선출되지 않았습니다\n주주대표에 지원해주세요';
      }
  }
}
