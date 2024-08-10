part of 'report_post_bloc.dart';

@immutable
abstract class ReportPostEvent {
  const ReportPostEvent._();

  const factory ReportPostEvent.init() = ReportPostOnInit;

  const factory ReportPostEvent.pageRefresh() = PostOnPageRefresh;

  const factory ReportPostEvent.reportOnPostList(List<ReportList> reportList) = ReportPostOnPostList;

  const factory ReportPostEvent.setReportStatus(ReportStatusType reportStatus) = ReportPostOnSetStatus;

  const factory ReportPostEvent.fetchReportPost({
    String? reportStatus,
    int page,
    int size,
    String? sorts,
  }) = FetchReportPost;
}

class ReportPostOnInit extends ReportPostEvent {
  const ReportPostOnInit() : super._();
}

class ReportPostOnPostList extends ReportPostEvent {
  final List<ReportList> reportList;

  const ReportPostOnPostList(this.reportList) : super._();
}

class ReportPostOnSetStatus extends ReportPostEvent {
  final ReportStatusType reportStatus;

  const ReportPostOnSetStatus(this.reportStatus) : super._();
}

class FetchReportPost extends ReportPostEvent {
  final String? reportStatus;
  final int page;
  final int size;
  final String? sorts;

  const FetchReportPost({
    this.reportStatus,
    this.page = 1,
    this.size = apiLoadSize,
    this.sorts,
  }) : super._();
}

class PostOnPageRefresh extends ReportPostEvent {
  const PostOnPageRefresh() : super._();
}
