part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent {
  const PostDetailEvent._();

  const factory PostDetailEvent.init() = PostDetailOnInit;

  const factory PostDetailEvent.refresh() = PostDetailOnRefresh;

  const factory PostDetailEvent.toggleLike() = PostDetailOnToggleLike;

  const factory PostDetailEvent.report(String reason) = PostDetailOnReport;

  const factory PostDetailEvent.updateDone() = PostDetailOnUpdateDone;

  const factory PostDetailEvent.delete() = PostDetailOnDelete;

  const factory PostDetailEvent.requestDigitalProxyUrl() = PostDetailOnRequestDigitalProxyUrl;

  const factory PostDetailEvent.downloadHolderListReadAndCopyDocs() = PostDetailOnDownloadHolderListReadAndCopyDocs;

  const factory PostDetailEvent.showSolidarityApplication(int solidarityApplicantId) =
      PostDetailShowSolidarityApplication;
}

class PostDetailOnInit extends PostDetailEvent {
  const PostDetailOnInit() : super._();
}

class PostDetailOnRefresh extends PostDetailEvent {
  const PostDetailOnRefresh() : super._();
}

class PostDetailOnToggleLike extends PostDetailEvent {
  const PostDetailOnToggleLike() : super._();
}

class PostDetailOnReport extends PostDetailEvent {
  final String reason;

  const PostDetailOnReport(this.reason) : super._();
}

class PostDetailOnUpdateDone extends PostDetailEvent {
  const PostDetailOnUpdateDone() : super._();
}

class PostDetailOnDelete extends PostDetailEvent {
  const PostDetailOnDelete() : super._();
}

class PostDetailOnRequestDigitalProxyUrl extends PostDetailEvent {
  const PostDetailOnRequestDigitalProxyUrl() : super._();
}

class PostDetailShowSolidarityApplication extends PostDetailEvent {
  final int solidarityApplicantId;

  const PostDetailShowSolidarityApplication(this.solidarityApplicantId) : super._();
}

class PostDetailOnDownloadHolderListReadAndCopyDocs extends PostDetailEvent {
  const PostDetailOnDownloadHolderListReadAndCopyDocs() : super._();
}
