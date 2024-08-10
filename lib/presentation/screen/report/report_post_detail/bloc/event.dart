part of 'bloc.dart';

@immutable
abstract class PostEvent {
  const PostEvent._();

  const factory PostEvent.init() = PostOnInit;

  const factory PostEvent.postOnSetSourceSearchKeyword(String searchKeyword) = PostOnSetReason;

  const factory PostEvent.fetchUpdateState({
    required String type,
    required int reportId,
    required String result,
    required String currentReportStatus,
    required String changeReportStatus,
  }) = PostOnUpdateState;
}

class PostOnInit extends PostEvent {
  const PostOnInit() : super._();
}

class PostOnSetReason extends PostEvent {
  final String reason;

  const PostOnSetReason(this.reason) : super._();
}

class PostOnUpdateState extends PostEvent {
  final String type;
  final int reportId;
  final String result;
  final String currentReportStatus;
  final String changeReportStatus;

  const PostOnUpdateState({
    required this.type,
    required this.reportId,
    required this.result,
    required this.currentReportStatus,
    required this.changeReportStatus,
  }) : super._();
}
