part of 'bloc.dart';

@immutable
abstract class CmsEvent {
  const CmsEvent._();

  const factory CmsEvent.init(SimpleStock stock) = CmsOnInit;

  const factory CmsEvent.setLeaderComment(String comment) = CmsOnSetLeaderComment;

  const factory CmsEvent.setLeader(int solidarityId, int solidarityApplicantId) = CmsOnSetLeader;

  const factory CmsEvent.deleteLeader() = CmsOnDeleteLeader;

  const factory CmsEvent.setCorporationLeader(int userId) = CmsOnSetCorporationLeader;

  const factory CmsEvent.cancelLeaderCandidate(int solidarityId, int solidarityApplicantId, String cancelReason) =
      CmsOnCancelLeaderCandidate;

  const factory CmsEvent.clearToastMsg() = CmsOnClearToastMsg;

  const factory CmsEvent.downloadUserList(String stockCode) = CmsOnDownloadUserList;

  const factory CmsEvent.onSelectCorporation(CorporationUser corporation) = CmsOnSelectCorporation;

  const factory CmsEvent.onAcceptUser(AcceptUser acceptUser) = CmsOnAcceptUser;

  const factory CmsEvent.onGetCorporationList({
    String? searchKeyword,
    int? page,
    int? size,
  }) = CmsOnGetCorporationList;

  const factory CmsEvent.onFireAcceptUser({required String stockCode, required int userId}) = CmsOnFireAcceptUser;
}

class CmsOnInit extends CmsEvent {
  final SimpleStock stock;

  const CmsOnInit(this.stock) : super._();
}

class CmsOnSetLeaderComment extends CmsEvent {
  final String comment;

  const CmsOnSetLeaderComment(this.comment) : super._();
}

class CmsOnSetLeader extends CmsEvent {
  final int solidarityId;
  final int solidarityApplicantId;

  const CmsOnSetLeader(this.solidarityId, this.solidarityApplicantId) : super._();
}

class CmsOnDeleteLeader extends CmsEvent {
  const CmsOnDeleteLeader() : super._();
}

class CmsOnSetCorporationLeader extends CmsEvent {
  final int userId;

  const CmsOnSetCorporationLeader(this.userId) : super._();
}

class CmsOnCancelLeaderCandidate extends CmsEvent {
  final int solidarityId;
  final int solidarityApplicantId;
  final String cancelReason;

  const CmsOnCancelLeaderCandidate(this.solidarityId, this.solidarityApplicantId, this.cancelReason) : super._();
}

class CmsOnClearToastMsg extends CmsEvent {
  const CmsOnClearToastMsg() : super._();
}

class CmsOnDownloadUserList extends CmsEvent {
  final String stockCode;

  const CmsOnDownloadUserList(this.stockCode) : super._();
}

class CmsOnSelectCorporation extends CmsEvent {
  final CorporationUser corporation;

  const CmsOnSelectCorporation(this.corporation) : super._();
}

class CmsOnAcceptUser extends CmsEvent {
  final AcceptUser acceptUser;

  const CmsOnAcceptUser(this.acceptUser) : super._();
}

class CmsOnFireAcceptUser extends CmsEvent {
  final int userId;
  final String stockCode;

  const CmsOnFireAcceptUser({required this.userId, required this.stockCode}) : super._();
}

class CmsOnGetCorporationList extends CmsEvent {
  final String? searchKeyword;
  final int? page;
  final int? size;

  const CmsOnGetCorporationList({
    this.searchKeyword,
    this.page,
    this.size,
  }) : super._();
}
