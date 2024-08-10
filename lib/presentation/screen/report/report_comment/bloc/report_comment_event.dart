part of 'report_comment_bloc.dart';

@immutable
abstract class ReportCommentEvent {
  const ReportCommentEvent._();

  const factory ReportCommentEvent.init() = ReportCommentOnInit;

  const factory ReportCommentEvent.postNewsOnPostList(List<ReportList> reportList) = ReportCommentOnPostList;

  const factory ReportCommentEvent.setReportStatus(ReportStatusType reportStatus) = ReportCommentOnSetStatus;

  const factory ReportCommentEvent.fetchReportComment({
    String? reportStatus,
    int page,
    int size,
    String? sorts,
  }) = FetchReportComment;

  const factory ReportCommentEvent.fetchUserDetail(int userId) = FetchUserDetail;

  const factory ReportCommentEvent.addRoleToUserEvent(int userId, String roleType) = AddRoleToUserEvent;

  const factory ReportCommentEvent.assignAdminEvent(int userId) = AssignAdminEvent;

  const factory ReportCommentEvent.pageRefresh() = PostOnPageRefresh;
}

class ReportCommentOnInit extends ReportCommentEvent {
  const ReportCommentOnInit() : super._();
}

class ReportCommentOnPostList extends ReportCommentEvent {
  final List<ReportList> reportList;

  const ReportCommentOnPostList(this.reportList) : super._();
}

class ReportCommentOnSetStatus extends ReportCommentEvent {
  final ReportStatusType reportStatus;

  const ReportCommentOnSetStatus(this.reportStatus) : super._();
}

class FetchReportComment extends ReportCommentEvent {
  final String? reportStatus;
  final int page;
  final int size;
  final String? sorts;

  const FetchReportComment({
    this.reportStatus,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class FetchUserDetail extends ReportCommentEvent {
  final int userId;

  const FetchUserDetail(this.userId) : super._();
}

class AddRoleToUserEvent extends ReportCommentEvent {
  final int userId;
  final String roleType;

  const AddRoleToUserEvent(this.userId, this.roleType) : super._();
}

class AssignAdminEvent extends ReportCommentEvent {
  final int userId;

  const AssignAdminEvent(this.userId) : super._();
}

class PostOnPageRefresh extends ReportCommentEvent {
  const PostOnPageRefresh() : super._();
}
